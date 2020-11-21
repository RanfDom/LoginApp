//
//  AgendaTableViewCell.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 19/11/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit

protocol AgendaTableViewCellDelegate {
    func buttonGreetDidPressed(at indexPath: IndexPath)
}

class AgendaTableViewCell: UITableViewCell {
    static let reuseID: String = "AgendaTableViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var greetButton: UIButton!
    
    var delegate: AgendaTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func greetAction(_ sender: Any) {
        guard let tableView: UITableView = self.superview as? UITableView else { return }
        guard let indexPath = tableView.indexPath(for: self) else { return }
        delegate?.buttonGreetDidPressed(at: indexPath)
    }
}
