//
//  KingsListPresenter.swift
//  GOT
//
//  Created by Chinnasamy ChinnaRaj on 06/05/18.
//  Copyright © 2018 Chinnasamy ChinnaRaj. All rights reserved.
//

import Foundation

enum KingsListResult {
    case Success(kingsList: [KingsModel])
    case Failiur(errorCode: Int)
}

class KingsListPresenter: KingsListPresentation {
    
    weak var view:KingsListView?
    var interactor: KingsListUseCase?
    
    func viewDidLoad() {
        self.interactor?.loadKingsList(completion: { (result) -> (Void) in
            switch result {
            case .Success(let kingsList):
                self.updateUIKingsList(kingsList: kingsList)
                break
            case .Failiur(let errorCode):
                print(errorCode)
                self.view?.showErrorMessage()
                break
            }
        })
    }
    
    func updateUIKingsList(kingsList: [KingsModel]) {
        // Create ViewModel and ask View to update it
        // Need to Update UI in Main thread.
        let newViewModel = KingsListViewModel()
        newViewModel.title = "Game of Thrones | Kings"
        newViewModel.masterList = kingsList
        self.view?.updateKingsList(viewModel: newViewModel)
    }
    
    func showKingDetailsScreen(kingModel: KingsModel) {
        let view = KingDetailsBuilder().assembleModule(kingModel: kingModel)
        self.view?.moveToNextScreen(view: view)
    }
}
