//
//  ContactDetailWireFrame.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 24/11/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit

protocol ContactDetailWireframeProtocol {
    static func buildContactDetailModule() -> ContactDetailViewController
}
class ContactDetailWireframe: ContactDetailWireframeProtocol {
    
    static func buildContactDetailModule() -> ContactDetailViewController {
        return ContactDetailViewController.instantiate()
    }

}
