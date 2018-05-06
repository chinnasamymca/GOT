//
//  KingsListBuilder.swift
//  GOT
//
//  Created by Chinnasamy ChinnaRaj on 06/05/18.
//  Copyright © 2018 Chinnasamy ChinnaRaj. All rights reserved.
//

import Foundation
import UIKit

class KingsListBuilder: BaseBuilder {
   
    func assembleModule() -> UIViewController {
        let view = XIBMapper.getKingsView()
        
        let presenter = KingsListPresenter()
        let interactor = KingsListInteractor()
        
        view?.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        
        return view!
    }
}
