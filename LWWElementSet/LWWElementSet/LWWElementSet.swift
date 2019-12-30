//
//  LWWElementSet.swift
//  LWWElementSet
//
//  Created by Norman Lim on 30/12/2019.
//  Copyright © 2019 Norman Lim. All rights reserved.
//

import Foundation

struct LWWElementSet<T: Hashable> {
    enum Bias {
        case add
        case remove
    }
    
    private(set) var addSet: [T: Date] = [:]
    private(set) var removeSet: [T: Date] = [:]
    
    let bias: Bias
    
    init(bias: Bias) {
        self.bias = bias
    }
    
    mutating func insert(_ element: T) {
        addSet[element] = Date()
    }
    
    mutating func remove(_ element: T) {
        removeSet[element] = Date()
    }
    
    mutating func merge(_ lwwElementSet: LWWElementSet) {
        // use the latest inserted/removed pairs
        addSet.merge(lwwElementSet.addSet) { max($0, $1) }
        removeSet.merge(lwwElementSet.removeSet) { max($0, $1) }
    }
    
    func contains(_ element: T) -> Bool {
        guard let addDate = addSet[element] else { return false }
        guard let removeDate = removeSet[element] else { return true }
        
        switch bias {
        case .add:
            return addDate >= removeDate
        case .remove:
            return addDate > removeDate
        }
    }
}
