//
//  CommonProtocols.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 01/12/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit

protocol LoadableViewController: class {
  static var storyboardFileName: String { get }
  static var storyboardID: String { get }
}

extension LoadableViewController where Self: UIViewController {

  static var storyboardID: String {
    return String(describing: self)
  }

  static func instantiate(from bundleName: String? = nil) -> Self {
    guard let vc = UIStoryboard.instanceofViewController(with: storyboardID, from: storyboardFileName, bundleName: bundleName) as? Self else {
      fatalError("The viewcontrolller '\(storyboardID)' of '\(storyboardFileName)' does not exists or does not a  '\(self)' class ")
    }
    return vc
  }
}

protocol Alertable {
    func presentAlert(with title: String, message: String)
}

protocol Greetable {
    func greet()
}

extension Greetable where Self: UIViewController {
    func greet() {
        print("Hello")
        view.backgroundColor = .red
    }
}
