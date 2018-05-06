//
//  KingsListInteractor.swift
//  GOT
//
//  Created by Chinnasamy ChinnaRaj on 06/05/18.
//  Copyright © 2018 Chinnasamy ChinnaRaj. All rights reserved.
//

import Foundation
import SwiftyJSON

class KingsListInteractor: KingsListUseCase {
    func loadKingsList(completion: @escaping (KingsListResult) -> (Void)) {
        APiWorker().fetchJSONDatafromServer { (response) -> (Void) in
            switch response {
            case .Success(let data):
                // Process JSON Data to create Data Models
                let kingsList = self.processJSONData(jsonData: data.arrayValue)
                completion(KingsListResult.Success(kingsList: kingsList))
                break
            case .Failiur(let errorCode):
                completion(KingsListResult.Failiur(errorCode: errorCode))
                break
            }
        }
    }
    
    func processJSONData(jsonData: [JSON]) -> [KingsModel] {
        var kingsModelList = Array<KingsModel>()
        
        for eachBattle in jsonData {
            
            let nameOfBattle = eachBattle["name"].stringValue
            let year = eachBattle["year"].stringValue
            let attackerKing = eachBattle["attacker_king"].stringValue
            let defenderKing = eachBattle["defender_king"].stringValue
            
            let isAttackerWon: Bool = eachBattle["attacker_outcome"].stringValue == "win" ? true : false
            
            let attackerKingModel = self.getKingModel(kingName: attackerKing, kingsList: kingsModelList)
            if attackerKingModel.isNew == true {
                kingsModelList.append(attackerKingModel.king)
            }
            
            // Add battle to Attacker
            let attackerBattle = BattleDetails(name: nameOfBattle, year: year, againstKing: defenderKing, attacked: true, isWon: isAttackerWon)
            attackerKingModel.king.battels.append(attackerBattle)
            
            let defenderKingModel = self.getKingModel(kingName: defenderKing, kingsList: kingsModelList)
            if defenderKingModel.isNew == true {
                kingsModelList.append(defenderKingModel.king)
            }
            
            // Add Battle to Defender
            let defenderBattle = BattleDetails(name: nameOfBattle, year: year, againstKing: attackerKing, attacked: false, isWon: !isAttackerWon)
            defenderKingModel.king.battels.append(defenderBattle)
            
            // Update Rating
            let rating = self.getNewRatingFor(attacker: attackerKingModel.king, defender: defenderKingModel.king, isAttackerWon: isAttackerWon)
            attackerKingModel.king.points = rating.newAttackerPoints
            defenderKingModel.king.points = rating.newDefenderPoints
        }
        return kingsModelList
    }
    
    func getKingModel(kingName: String, kingsList: [KingsModel]) -> (king: KingsModel, isNew:Bool) {
        if let kingModel = kingsList.filter({$0.kingName == kingName}).first {
            return (kingModel, false)
        }
        else {
            let kingModel = KingsModel(name: kingName)
            return (kingModel, true)
        }
    }
    
    func getNewRatingFor(attacker: KingsModel, defender:KingsModel, isAttackerWon: Bool) -> (newAttackerPoints: Int, newDefenderPoints: Int) {
    
        // Calculating new rating
        let currentPointsAttacker = attacker.points!
        let currentPointsDefender = defender.points!
        
        // Step 1
//        R(1) = 10^(r(1)/400)
//        R(2) = 10^(r(2)/400)
        let attackerPoint = 10^(currentPointsAttacker/400)
        let defenderPoint = 10^(currentPointsDefender/400)
        
        // Step 2
//        E(1) = R(1) / (R(1) + R(2))
//        E(2) = R(2) / (R(1) + R(2))
        let attackerExpectedScore = (attackerPoint / (attackerPoint + defenderPoint))
        let defenderExpectedScore = (defenderPoint / (attackerPoint + defenderPoint))
        
        // Step 3
//        S(1) = 1 if player 1 wins / 0.5 if draw / 0 if player 2 wins
//        S(2) = 0 if player 1 wins / 0.5 if draw / 1 if player 2 wins
        var attackerWiningScore = 0
        var defenderWiningScore = 0
        if isAttackerWon == true {
            attackerWiningScore = 1
            defenderWiningScore = 0
        }
        else {
            attackerWiningScore = 0
            defenderWiningScore = 1
        }
        
        // Step 4
//        r'(1) = r(1) + K * (S(1) – E(1))
//        r'(2) = r(2) + K * (S(2) – E(2))
        let constantRating = 32
        let newAttackerPoint = currentPointsAttacker + constantRating * (attackerWiningScore - attackerExpectedScore)
        let newDefenderPoint = currentPointsDefender + constantRating * (defenderWiningScore - defenderExpectedScore)
    
        return (newAttackerPoint, newDefenderPoint)
    }
}
