//
//  Log.swift
//  Framewerk
//
//  Created by Michael Neas on 4/19/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import os.log

struct Log {
    static var app = OSLog(subsystem: "neas.lease.Framewerk", category: "app")
}
