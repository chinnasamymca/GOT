//
//  GTOTestingExample.swift
//  GOTTests
//
//  Created by Chinnasamy ChinnaRaj on 06/05/18.
//  Copyright © 2018 Chinnasamy ChinnaRaj. All rights reserved.
//

import XCTest
@testable import GOT

class GTOTestingExample: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNewKingCreationWithInitialPoints() {
        let king = KingsModel(name: "Chinna")
        XCTAssertEqual(king.points, 1000)
    }
    
}
