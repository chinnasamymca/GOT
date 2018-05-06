//
//  KingsBattledetailsTableViewCell.swift
//  GOT
//
//  Created by Chinnasamy ChinnaRaj on 06/05/18.
//  Copyright © 2018 Chinnasamy ChinnaRaj. All rights reserved.
//

import UIKit

class KingsBattledetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var countLable: UILabel!
    
    var battleDetails: KingBattleDetails? {
        didSet {
           self.configureCell()
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
    
    func configureCell() {
        self.titleLable.text = self.battleDetails?.title
        self.countLable.text = self.battleDetails?.value
    }
}
