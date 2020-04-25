//
//  View+Extensions.swift
//  Framewerk
//
//  Created by Michael Neas on 4/16/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import SwiftUI

extension View {
    func isHidden(_ hide: Bool) -> some View {
        hide ? AnyView(self.hidden()) : AnyView(self)
    }
    
    func stacked(at position: Int, in total: Int, initialOffset: CGFloat) -> some View {
        let offset = CGFloat(total - position)
        #if os(watchOS)
        return self.offset(CGSize(width: initialOffset, height: -(1/offset) * 12))
        #else
        return self.offset(CGSize(width: initialOffset, height: -(1/offset) * 50))
        #endif
    }
}
