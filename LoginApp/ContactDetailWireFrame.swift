//
//  ContactDetailWireFrame.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 24/11/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit

class ContactDetailWireframe {
    
    static func buildLoginModule() -> Any {
        let viewController = UIStoryboard(name: "ContactDetailViewController", bundle: nil).instantiateViewController(identifier: "ContactDetailViewController") as! ContactDetailViewController
        
        return viewController
    }

}
