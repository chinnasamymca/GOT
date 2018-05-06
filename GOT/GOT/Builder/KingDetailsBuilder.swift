//
//  KingDetailsBuilder.swift
//  GOT
//
//  Created by Chinnasamy ChinnaRaj on 06/05/18.
//  Copyright © 2018 Chinnasamy ChinnaRaj. All rights reserved.
//

import Foundation
import UIKit

class KingDetailsBuilder: BaseBuilder {
    
    func assembleModule() -> UIViewController {
        // Dummy implementation, We can use protocol Segratation
        return UIViewController()
    }
    
    func assembleModule(kingModel: KingsModel) -> UIViewController {
        let view = XIBMapper.getKingDetailsView()
        
        let presenter = KingDetailsPresenter()
        presenter.kingModel = kingModel
        view?.presenter = presenter
        presenter.view = view
        
        return view!
    }
}
