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
    
    var sut: LWWElementSet<AnyHashable>!

    override func setUp() {
        sut = LWWElementSet<AnyHashable>(bias: .remove)
    }

    func testInsertElements() {
        sut.insert("")
        XCTAssert(sut.contains(""))
    }
    
    func testRemoveElements() {
        let element = ""
        sut.insert(element)
        sut.remove(element)
        XCTAssert(!sut.contains(element))
        
        sut = LWWElementSet<AnyHashable>(bias: .add)
        sut.insert(element)
        usleep(1)
        sut.remove(element)
        XCTAssert(!sut.contains(element))
    }
    
    func testInsertingElementsAfterRemoval() {
        let element = ""
        sut.insert(element)
        sut.remove(element)
        sut.insert(element)
        XCTAssert(sut.contains(element))
        
        sut = LWWElementSet<AnyHashable>(bias: .add)
        sut.insert(element)
        usleep(1)
        sut.remove(element)
        usleep(1)
        sut.insert(element)
        XCTAssert(sut.contains(element))
    }
}
