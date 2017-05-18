//
//  HelperFunctions.swift
//  PitchPerfect
//
//  Created by Mark Jainchell on 5/17/17.
//  Copyright © 2017 Mark Jainchell. All rights reserved.
//

import UIKit

extension UIViewController {

    func scaleTheButtons (_ button: UIButton...) {
        for i in button {
            i.imageView?.contentMode = .scaleAspectFit
        }
    }
}

