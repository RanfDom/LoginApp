//
//  StoryboardExtensions.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 02/12/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit

typealias CBStoryboardID = String

extension UIStoryboard {

  class func instanceofViewController(with storyboardID: CBStoryboardID, from storyboardFileName: String, bundleName: String? = nil) -> UIViewController? {
    var bundle: Bundle? = nil
    if let bundleNotNil = bundleName {
      bundle = Bundle(identifier: bundleNotNil)
    }
    let storyboard = UIStoryboard(
      name: storyboardFileName,
      bundle: bundle
    )

    return storyboard.instantiateViewController(withIdentifier: storyboardID)
  }
}
