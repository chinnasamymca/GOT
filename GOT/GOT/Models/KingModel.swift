//
//  KingModel.swift
//  GOT
//
//  Created by Chinnasamy ChinnaRaj on 06/05/18.
//  Copyright © 2018 Chinnasamy ChinnaRaj. All rights reserved.
//

import Foundation

class KingsModel {
    var kingName: String!
    var kingImage: String!
    var points: Int!
    
    var battels = Array<BattleDetails>()
    
    init(name: String) {
        self.kingName = name
        self.points = 400
        self.kingImage = self.randomKingImage()
    }
    
    func getNumberofWin() -> Int {
        let winBattels = self.battels.filter({$0.isOwn == true})
        return winBattels.count
    }
    
    func getNumberOfAttacked() -> Int {
        let attackedBattels = self.battels.filter({$0.isAttacked == true})
        return attackedBattels.count
    }
    
    func getNumberOfDefended() -> Int {
        let defendedBattels = self.battels.filter({$0.isAttacked == false})
        return defendedBattels.count
    }
    
    func getNumberOfAttacksOwn() -> Int {
        let attacksWon = self.battels.filter({$0.isAttacked == true}).filter({$0.isOwn == true})
        return attacksWon.count
    }
    
    func getNumberOfDefendesOwn() -> Int {
        let attacksWon = self.battels.filter({$0.isAttacked == false}).filter({$0.isOwn == true})
        return attacksWon.count
    }
    
    private func randomKingImage() -> String {
        let kingImages = ["GOT", "Greyjoy", "Lannister", "Mance", "Stannis", "Stark", "Tully"]
        let randomIndex = Int(arc4random_uniform(UInt32(kingImages.count)))
        let imageName = (randomIndex < kingImages.count) ? kingImages[randomIndex] : kingImages.first ?? ""
        return imageName
    }

}

class BattleDetails {
    var battleName: String!
    var battleYear: String!
    var againstKingName: String!
    var isOwn: Bool!
    var isAttacked: Bool!
    
    init(name: String, year: String, againstKing: String, attacked:Bool, isWon: Bool) {
        self.battleName = name
        self.battleYear = year
        self.againstKingName = againstKing
        self.isOwn = isWon
        self.isAttacked = attacked
    }
}
