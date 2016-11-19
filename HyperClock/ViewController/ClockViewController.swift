//
//  ClockViewController.swift
//  HyperClock
//
//  Created by KimJungSu on 11/19/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController {

    /**
     * Propertis about UI elements
     */

    @IBOutlet weak var beginningView: BeginningView!
    
    @IBOutlet weak var clockView: ClockView!
    
    /**
     * Propertis about Model
     */

    let timeline = Timeline.init()
    
    var playTimeManager = PlayTimeManager.init()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.setLayout()
    }

    func setLayout() {
        
        self.clockView.delegate = self
        self.beginningView.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension ClockViewController: BeginningViewDelegate {
    
    func didStartButtonClicked(_ startButton: UIButton) {
        
        self.beginningView.showIndicatorAndHideStartButton()
        
        self.timeline.requestTimelineFeeds { (isSucces, error) in
            
            if isSucces == true {
                
                self.beginningView.isHidden = true
                
                self.displayClockView()
            }
            else {
                //  show error message
                self.showAlertView(withPrompt: "Please check your network and try again.")
                
                self.beginningView.hideIndicatorAndShowStartButton()
            }
        }
    }
}

extension ClockViewController: ClockViewDelegate {

    func didPlayTimeSetButtonClicked(_ clockView: ClockView) {

        let storyboard = StoryboardManager.Main.instance
        
        let st =
            storyboard.instantiateViewController(withIdentifier: PlayTimeViewController.identifier) as! PlayTimeViewController
        
        st.delegate = self
        st.playTimeIndex = playTimeManager.playTime
        
        self.presentToNavigationController(st, withSourceView: self.clockView.playTimeButton)
        
    }
}

extension ClockViewController: PlayTimeViewControllerDelegate {

    func playTimeViewController(_ viewController: PlayTimeViewController, didPlayTimeChanged playTime: Int) {
     
        self.playTimeManager.playTime = playTime
    }

}

extension ClockViewController {
    
    fileprivate func displayClockView() {
        
        if let feed = self.timeline.feedAtCurrentIndex() {
            
            self.clockView.currentPageLabel.text = String(self.timeline.getCurrentFeedIndex() + 1) +
                " of " + String(self.timeline.feedsCount())
            
            self.clockView.showFeed(feed, withPlayTime: self.playTimeManager.playTime){
                
                (isFadeOut) in

                self.timeline.increaseCurrentIndex()
                
                self.displayClockView()

            }
        }
        
        else {
            self.clockView.currentTimeLabel.text = ""
        }
   }
}

