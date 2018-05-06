//
//  KingDetailsWarTableViewCell.swift
//  GOT
//
//  Created by Chinnasamy ChinnaRaj on 06/05/18.
//  Copyright © 2018 Chinnasamy ChinnaRaj. All rights reserved.
//

import UIKit

class KingDetailsWarTableViewCell: UITableViewCell {

    var battle: BattleDetails? {
        didSet {
           self.configureView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView() {
        self.textLabel?.text = self.battle?.battleName
        self.detailTextLabel?.text = self.battle?.againstKingName
    }
}
