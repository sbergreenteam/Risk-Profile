//
//  UIImage.swift
//  Risk Profile
//
//  Created by XCodeClub on 2019-11-16.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

extension UIImage {
    convenience init(bundleName: String) {
        self.init(named: bundleName)!
    }
}
