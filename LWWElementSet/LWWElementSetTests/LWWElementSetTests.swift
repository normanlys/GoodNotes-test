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
        resetSUT()
    }
    
    private func resetSUT(bias: LWWElementSet<AnyHashable>.Bias = .remove) {
        sut = LWWElementSet<AnyHashable>(bias: bias)
    }

    func testInsertElements() {
        let element = ""
        let test: () -> Void = {
            self.sut.insert(element)
            XCTAssert(self.sut.contains(element))
        }
        
        test()
        resetSUT(bias: .add)
        test()
    }
    
    func testRemoveElements() {
        let element = ""
        let test: () -> Void = {
            self.sut.insert(element)
            self.sut.remove(element)
            XCTAssert(!self.sut.contains(element))
        }
        
        test()
        resetSUT(bias: .add)
        test()
    }
    
    func testInsertingElementsAfterRemoval() {
        let element = ""
        let test: () -> Void = {
            self.sut.insert(element)
            self.sut.remove(element)
            self.sut.insert(element)
            XCTAssert(self.sut.contains(element))
        }
        
        test()
        resetSUT(bias: .add)
        test()
    }
    
    func testMergeEmptySet() {
        let element = ""
        
        sut.insert(element)
        let emptySet = LWWElementSet<AnyHashable>(bias: .remove)
        sut.merge(emptySet)
        XCTAssert(sut.contains(element))
    }
    
    func testMergeSetWithElementRemoved() {
        let element = ""
        let test: () -> Void = {
            self.sut.insert(element)
            var removedElementSet = LWWElementSet<AnyHashable>(bias: .remove)
            removedElementSet.remove(element)
            self.sut.merge(removedElementSet)
            XCTAssert(!self.sut.contains(element))
        }
        
        test()
        resetSUT(bias: .add)
        test()
    }
    
    func testMergeSetWithElementAdded() {
        let element = ""
        let test: () -> Void = {
            self.sut.remove(element)
            var addedElementSet = LWWElementSet<AnyHashable>(bias: .remove)
            addedElementSet.insert(element)
            self.sut.merge(addedElementSet)
            XCTAssert(self.sut.contains(element))
        }
        
        test()
        resetSUT(bias: .add)
        test()
    }
}
