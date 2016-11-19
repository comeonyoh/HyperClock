//
//  UIViewControllerExtension.swift
//  HyperClock
//
//  Created by KimJungSu on 11/19/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import Foundation
import UIKit

/**
 * Extension about AlertView
 */
extension UIViewController {
    
    //  USED only without no choice case
    func showAlertView(withPrompt message: String?) {
        
        let alert = UIAlertController.init(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.`default`) { (action) in }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
}

/**
 * Extension about presentViewController
 */

extension UIViewController {
    
    func presentToNavigationController(_ viewController: UIViewController, withSourceView sourceView: UIView)  {
        
        let navigationVC = UINavigationController.init(rootViewController: viewController)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            navigationVC.modalPresentationStyle = .popover
            navigationVC.popoverPresentationController?.sourceView = sourceView
        }
        
        self.present(navigationVC, animated: true, completion: nil)
    }
}
