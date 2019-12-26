//
//  CustomCellClass.swift
//  reworked
//
//  Created by Дмитрий on 24.12.2019.
//  Copyright © 2019 Дмитрий. All rights reserved.
//

import Foundation
import UIKit

protocol CustomCellClassDelegate: class {
    func didTapButton(cell: CustomCellClass)
}

class CustomCellClass: UITableViewCell {
    weak var delegate: CustomCellClassDelegate?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var metroNumLabel: UILabel!
    @IBOutlet weak var tatNumLabel: UILabel!
    @IBOutlet weak var totalSpentLabel: UILabel!
    
    @IBAction func editButtonPushed(_ sender: UIButton) {
        delegate?.didTapButton(cell: self)
    }  
}
