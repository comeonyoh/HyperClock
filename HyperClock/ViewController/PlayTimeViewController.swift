//
//  PlayTimeViewController.swift
//  HyperClock
//
//  Created by KimJungSu on 11/19/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import UIKit

protocol PlayTimeViewControllerDelegate: class {
    
    func playTimeViewController(_ viewController: PlayTimeViewController, didPlayTimeChanged playTime: Int)
}

class PlayTimeViewController: UIViewController {
    
    static let identifier = "PlayTimeViewController"

    var playTimeIndex = 0

    weak var delegate: PlayTimeViewControllerDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didCancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func didSaveButtonClicked(_ sender: Any) {
        
        self.delegate?.playTimeViewController(self, didPlayTimeChanged: self.playTimeIndex)
        
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension PlayTimeViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "simple_cell_id", for: indexPath)
        
        let secondsValue = indexPath.row + 1
        
        cell.textLabel?.text = String(secondsValue) + " seconds"
        
        if secondsValue == playTimeIndex {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        
        return cell
    }

}

extension PlayTimeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.playTimeIndex = indexPath.row + 1
        
        tableView.reloadData()
    }
}
