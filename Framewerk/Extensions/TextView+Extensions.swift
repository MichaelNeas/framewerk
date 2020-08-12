//
//  TextView+Extensions.swift
//  Framewerk
//
//  Created by Michael Neas on 2/29/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import UIKit
import SwiftUI

struct TextView: UIViewRepresentable {
    var placeholder: String
    @Binding var text: String

    var minHeight: CGFloat
    var callback: ((String) -> ())?
    @Binding var calculatedHeight: CGFloat

    init(placeholder: String, text: Binding<String>, minHeight: CGFloat, calculatedHeight: Binding<CGFloat>, finished: ((String) -> ())? = nil) {
        self.placeholder = placeholder
        self._text = text
        self.minHeight = minHeight
        self._calculatedHeight = calculatedHeight
        self.callback = finished
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator

        // Decrease priority of content resistance, so content would not push external layout set in SwiftUI
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = .clear
        textView.textColor = .black
        textView.font = FramewerkStyle.smallFont
        
        if text.isEmpty {
            // Set the placeholder
            textView.text = placeholder
        } else {
            textView.text = text
        }

        return textView
    }

    func updateUIView(_ textView: UITextView, context: Context) {
        if textView.text != self.text {
            self.text = textView.text
        }

        recalculateHeight(view: textView)
    }

    func recalculateHeight(view: UIView) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if minHeight < newSize.height && $calculatedHeight.wrappedValue != newSize.height {
            DispatchQueue.main.async {
                self.$calculatedHeight.wrappedValue = newSize.height // !! must be called asynchronously
            }
        } else if minHeight >= newSize.height && $calculatedHeight.wrappedValue != minHeight {
            DispatchQueue.main.async {
                self.$calculatedHeight.wrappedValue = self.minHeight // !! must be called asynchronously
            }
        }
    }

    class Coordinator : NSObject, UITextViewDelegate {

        var parent: TextView

        init(_ uiTextView: TextView) {
            self.parent = uiTextView
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            parent.recalculateHeight(view: textView)
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            // clear placeholder
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
            }
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            guard let text = textView.text, !text.isEmpty else {
                textView.text = parent.placeholder
                return
            }
            parent.text = textView.text
            parent.callback?(text)
        }
    }
}
