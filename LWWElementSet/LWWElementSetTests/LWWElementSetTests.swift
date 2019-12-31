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
        resetTest()
    }
    
    private func resetTest(bias: LWWElementSet<AnyHashable>.Bias = .remove) {
        sut = LWWElementSet<AnyHashable>(bias: bias)
    }

    func testInsertElements() {
        let element = ""
        sut.insert(element)
        XCTAssert(sut.contains(element))
        
        resetTest(bias: .add)
        sut.insert(element)
        XCTAssert(sut.contains(element))
    }
    
    func testRemoveElements() {
        let element = ""
        sut.insert(element)
        sut.remove(element)
        XCTAssert(!sut.contains(element))
        
        resetTest(bias: .add)
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
        
        resetTest(bias: .add)
        sut.insert(element)
        usleep(1)
        sut.remove(element)
        usleep(1)
        sut.insert(element)
        XCTAssert(sut.contains(element))
    }
    
    func testMerge() {
        let element = ""
        
        sut.insert(element)
        let emptySet = LWWElementSet<AnyHashable>(bias: .remove)
        sut.merge(emptySet)
        XCTAssert(sut.contains(element))
        
        resetTest()
        sut.insert(element)
        var removedElementSet = LWWElementSet<AnyHashable>(bias: .remove)
        removedElementSet.remove(element)
        sut.merge(removedElementSet)
        XCTAssert(!sut.contains(element))
        
        resetTest(bias: .add)
        sut.remove(element)
        usleep(1)
        var addedElementSet = LWWElementSet<AnyHashable>(bias: .remove)
        addedElementSet.insert(element)
        sut.merge(addedElementSet)
        XCTAssert(sut.contains(element))
    }
}
