//
//  ClockView.swift
//  HyperClock
//
//  Created by KimJungSu on 11/19/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import UIKit


protocol ClockViewDelegate: class {

    func didPlayTimeSetButtonClicked(_ clockView: ClockView)
}

@IBDesignable
class ClockView: UIView, LoadFromXib {

    
    fileprivate let nibName = "ClockView"
    
    weak var delegate: ClockViewDelegate?

    /**
     * Properties about UI Elements
     */
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    @IBOutlet weak var feedImageView: UIImageView!
    
    @IBOutlet weak var currentPageLabel: UILabel!
    
    @IBOutlet weak var playTimeButton: UIButton!

    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.loadXib(self, withXibName: nibName, withClass: self.classForCoder)
        
        self.executeTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.loadXib(self, withXibName: nibName, withClass: self.classForCoder)
        
        self.executeTimer()
    }
    
    @IBAction func didPlayTimeSetButtonClicked(_ sender: Any) {
        self.delegate?.didPlayTimeSetButtonClicked(self)
    }
    
}

extension ClockView: FadeAnimation {
    
    typealias AnimationCompletion = (_ isFadeOut: Bool) -> Void
    
    func showFeed(_ feed: Feed, withPlayTime playTime: Int, withAnimationCompletion completion: AnimationCompletion?) {
        
        self.feedImageView.image = nil
        
        feed.requestFetchImageUrl(withHandler: { (isSuccess) in

            if isSuccess == true {
                
                self.feedImageView.image = feed.mediaImage
                
                let animationTime = Double.init(playTime)
                
                self.executeFadeEffect(withPlayTime: animationTime, withAnimationCompletion: completion)
                
            }
            else {
                
                completion?(false)
            }
        })
    }
    
    fileprivate func executeFadeEffect(withPlayTime animationTime: Double,
                                       withAnimationCompletion completion: AnimationCompletion?) {

        let fadeEffectTime = 1.0
        
        self.fadeIn(self.feedImageView, withDuration: fadeEffectTime, withCompletion: {
            
            if $0 == true {
                
                DispatchQueue.init(label: "queue.show.slide").asyncAfter(deadline: .now() + animationTime , execute: {

                    self.fadeOut(self.feedImageView, withDuration: fadeEffectTime, withCompletion: { (isFadeOutFinished) in
                        
                        if isFadeOutFinished == true {
                            
                            completion?(true)
                        }
                    })
                })
            }
        })
    }
    
}


/**
 * Extension about current timer
 */

extension ClockView {
    
    func executeTimer() {

        let format = DateFormatter.init()

        format.dateFormat = "HH:mm:ss"
        
        self.currentTimeLabel.text = format.string(from: Date.init())
        
        self.perform(#selector(executeTimer), with: nil, afterDelay: 1.0)
    }
    
}
