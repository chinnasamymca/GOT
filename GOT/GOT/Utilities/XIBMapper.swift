//
//  XIBMapper.swift
//  GOT
//
//  Created by Chinnasamy ChinnaRaj on 06/05/18.
//  Copyright © 2018 Chinnasamy ChinnaRaj. All rights reserved.
//

import Foundation

class XIBMapper {
    static func getKingsView() -> KingsListViewController? {
        let kingsListView = KingsListViewController(nibName: "KingsListViewController", bundle: Bundle.main)
        return kingsListView
    }
    
    static func getKingDetailsView() -> KingDetailsViewController? {
        let kingsListView = KingDetailsViewController(nibName: "KingDetailsViewController", bundle: Bundle.main)
        return kingsListView
    }
}
