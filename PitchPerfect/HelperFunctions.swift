//
//  HelperFunctions.swift
//  PitchPerfect
//
//  Created by Mark Jainchell on 5/17/17.
//  Copyright © 2017 Mark Jainchell. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Helper function to scale buttons
    func scaleTheButtons (_ button: UIButton...) {
        for i in button {
            i.imageView?.contentMode = .scaleAspectFit
        }
    }
    
    // Helper function to show alerts
    func showAlert(_ alertType: UIAlertController, _ actionType: UIAlertAction) {
        alertType.addAction(actionType)
        self.present(alertType, animated: true, completion: nil)
    }
}

