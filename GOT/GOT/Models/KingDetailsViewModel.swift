//
//  KingDetailsViewModel.swift
//  GOT
//
//  Created by Chinnasamy ChinnaRaj on 06/05/18.
//  Copyright © 2018 Chinnasamy ChinnaRaj. All rights reserved.
//

import Foundation

class KingDetailsViewModel {
    var title: String!
    var image: String!
    
    var battleDetails = Array<KingBattleDetails>()
    var wars = Array<BattleDetails>()
    
    init(title: String, image: String) {
        self.title = title
        self.image = image
    }
    
}


// SubModel
class KingBattleDetails {
    var title: String!
    var value: String!
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}
