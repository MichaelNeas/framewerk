//
//  HostingController.swift
//  Framewerk
//
//  Created by Michael Neas on 8/11/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import SwiftUI

class HostingController<ContentView: View>: UIHostingController<ContentView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}
