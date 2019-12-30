//
//  LWWElementSetTests.swift
//  LWWElementSetTests
//
//  Created by Norman Lim on 30/12/2019.
//  Copyright © 2019 Norman Lim. All rights reserved.
//

import XCTest
@testable import LWWElementSet

class LWWElementSetTests: XCTestCase {
    
    var stringSUT: LWWElementSet<String>!
    var intSUT: LWWElementSet<Int>!

    override func setUp() {
        stringSUT = LWWElementSet<String>(bias: .add)
        intSUT = LWWElementSet<Int>(bias: .add)
    }

    func testInsertElements() {
        ["", "a", "awe4f32ewsfd"].forEach {
            stringSUT.insert($0)
            XCTAssert(stringSUT.contains($0))
        }
        
        [0, -1, 2931293].forEach {
            intSUT.insert($0)
            XCTAssert(intSUT.contains($0))
        }
    }
}
