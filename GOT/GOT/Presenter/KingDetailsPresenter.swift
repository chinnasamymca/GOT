//
//  KingDetailsPresenter.swift
//  GOT
//
//  Created by Chinnasamy ChinnaRaj on 06/05/18.
//  Copyright © 2018 Chinnasamy ChinnaRaj. All rights reserved.
//

import Foundation

class KingDetailsPresenter: KingDetailsPresentation {
    
    weak var view: KingDetailsView?
    var kingModel: KingsModel?
    
    func viewDidLoad() {
        if let kingDataModel = self.kingModel {
            self.showKingDetailsToUI(kingModel: kingDataModel)
        }
    }
    
    func showKingDetailsToUI(kingModel: KingsModel) {
        
        let detailsViewModel = KingDetailsViewModel(title: kingModel.kingName, image: kingModel.kingImage)
        
        detailsViewModel.battleDetails.append(KingBattleDetails(title: "Attacks Made", value: "\(kingModel.getNumberOfAttacked())"))
        detailsViewModel.battleDetails.append(KingBattleDetails(title: "Defended", value: "\(kingModel.getNumberOfDefended())"))
        detailsViewModel.battleDetails.append(KingBattleDetails(title: "Total Wins", value: "\(kingModel.getNumberofWin())"))
        detailsViewModel.battleDetails.append(KingBattleDetails(title: "Attacks Won", value: "\(kingModel.getNumberOfAttacksOwn())"))
        detailsViewModel.battleDetails.append(KingBattleDetails(title: "Defended Successfully", value: "\(kingModel.getNumberOfDefendesOwn())"))
        
        detailsViewModel.wars = kingModel.battels
        
        self.view?.showKingDetails(kingModel: detailsViewModel)
    }
    
}
