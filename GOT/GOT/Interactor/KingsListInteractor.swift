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
            
            // rating for Attacker
            let attackerRating = self.getNewRatingFor(king: attackerKingModel.king, isWon: isAttackerWon)
//            attackerKingModel.king.rating = attackerRating.newRating
//            attackerKingModel.king.points = attackerRating.newPoints
            
            let defenderKingModel = self.getKingModel(kingName: defenderKing, kingsList: kingsModelList)
            if defenderKingModel.isNew == true {
                kingsModelList.append(defenderKingModel.king)
            }
            
            // Add Battle to Defender
            let defenderBattle = BattleDetails(name: nameOfBattle, year: year, againstKing: attackerKing, attacked: false, isWon: !isAttackerWon)
            defenderKingModel.king.battels.append(defenderBattle)
            
            // rating for defender
            let defenderRating = self.getNewRatingFor(king: defenderKingModel.king, isWon: !isAttackerWon)
//            defenderKingModel.king.rating = defenderRating.newRating
//            defenderKingModel.king.points = defenderRating.newPoints
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
    
    //func getNewRatingFor(king: KingsModel, isWon: Bool) -> (newRating: Double, newPoints: Int) {
    func getNewRatingFor(king: KingsModel, isWon: Bool) -> Double {
        
        // Calculating new rating
        var points = king.points!
        if isWon == true {
            points += 400
        }
        else {
            points -= 400
        }
        let newRating = (points/king.battels.count)
        return Double(newRating)
        //return (Double(newRating), points)
    }
}
