//
//  Tutorial.swift
//  Framewerk
//
//  Created by Michael Neas on 4/15/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import SwiftUI

struct Tutorial: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Rectangle()
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 36, height: 36)
                    .position(x: 32, y: 64)
                Rectangle()
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 36, height: 36)
                    .position(x: geo.size.width - 32, y: 64)
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
        .background(Color(UIColor.systemIndigo.withAlphaComponent(0.9)))
        .edgesIgnoringSafeArea(.all)
    }
}

struct Tutorial_Previews: PreviewProvider {
    static var previews: some View {
        Tutorial()
    }
}
