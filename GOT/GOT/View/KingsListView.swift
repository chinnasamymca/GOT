//
//  KingsListView.swift
//  GOT
//
//  Created by Chinnasamy ChinnaRaj on 06/05/18.
//  Copyright © 2018 Chinnasamy ChinnaRaj. All rights reserved.
//

import Foundation
import UIKit

protocol KingsListView: class {
    func updateKingsList(viewModel: KingsListViewModel)
    
    func moveToNextScreen(view: UIViewController)
    func showErrorMessage() 
}
