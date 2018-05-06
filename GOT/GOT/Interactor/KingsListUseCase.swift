//
//  KingsListUseCase.swift
//  GOT
//
//  Created by Chinnasamy ChinnaRaj on 06/05/18.
//  Copyright © 2018 Chinnasamy ChinnaRaj. All rights reserved.
//

import Foundation

protocol KingsListUseCase {
    func loadKingsList(completion: @escaping (KingsListResult) -> (Void))
}
