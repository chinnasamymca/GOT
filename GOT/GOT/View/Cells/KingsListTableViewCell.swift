//
//  KingsListTableViewCell.swift
//  GOT
//
//  Created by Chinnasamy ChinnaRaj on 06/05/18.
//  Copyright © 2018 Chinnasamy ChinnaRaj. All rights reserved.
//

import UIKit

class KingsListTableViewCell: UITableViewCell {

    @IBOutlet weak var kingImageView: UIImageView!
    @IBOutlet weak var kingNameLable: UILabel!
    @IBOutlet weak var kingRatingLable: UILabel!
    @IBOutlet weak var numberOfWonLable: UILabel!
    @IBOutlet weak var numberOfAttachedLable: UILabel!
    @IBOutlet weak var numberOfDefendedLable: UILabel!
    
    var kingModel: KingsModel? {
        didSet {
            self.configureCellView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCellView () {
        self.kingNameLable.text = kingModel?.kingName
        self.numberOfWonLable.text = "\(kingModel!.getNumberofWin())"
        self.imageView?.image = UIImage(named: (kingModel?.kingImage)!)
        
        self.numberOfAttachedLable.text = "\(kingModel!.getNumberOfAttacked())"
        self.numberOfDefendedLable.text = "\(kingModel!.getNumberOfDefended())"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
