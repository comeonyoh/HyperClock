//
//  BeginningView.swift
//  HyperClock
//
//  Created by KimJungSu on 11/19/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import UIKit


/**
 * protocol that notify event from Beginning view (eg. startButtonClicked)
 */

protocol BeginningViewDelegate: class {
    func didStartButtonClicked(_ startButton: UIButton)
}

@IBDesignable
class BeginningView: UIView, LoadFromXib {
    
    fileprivate let nibName = "BeginningView"

    weak var delegate: BeginningViewDelegate?
    
    /**
     * Properties about UI Elements
     */
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var promptMessageLabel: UILabel!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.loadXib(self, withXibName: nibName, withClass: self.classForCoder)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.loadXib(self, withXibName: nibName, withClass: self.classForCoder)
    }
    
    @IBAction func didStartButtonClicked(_ sender: Any) {
        
        let startButton = sender as! UIButton
        
        self.delegate?.didStartButtonClicked(startButton)
    }
    
}

/**
 * Extension for public API (UIView status(eg. text, hidden) change)
 */

extension BeginningView {

    
    /**
     * USED when 'start' button clicked
     */

    func showIndicatorAndHideStartButton() {
        
        if self.loadingIndicator.isAnimating == false {
            self.loadingIndicator.startAnimating()
        }
        
        if self.startButton.isHidden == false {
            self.startButton.isHidden = true
        }
        
        self.promptMessageLabel.text = "Fetching data..."
    }
    
    
    /**
     * USED when network error occur
     */

    func hideIndicatorAndShowStartButton() {
        
        self.startButton.isHidden = false
        self.loadingIndicator.stopAnimating()
        self.promptMessageLabel.text = "Click start button please!"
    }
    
}







