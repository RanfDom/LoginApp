//
//  FinalStepViewController.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 26/11/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit

protocol FinalStepDelegate {
    func nextControllerPressed()
}

class FinalStepViewController: UIViewController {
    var delegate: FinalStepDelegate?
    
    
    @IBAction func beginButtonPressed(_ sender: Any) {
        delegate?.nextControllerPressed()
    }
}
