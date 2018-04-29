//
//  PropertyStoring.swift
//  animatedTransitions
//
//  Created by Greg Szydlo on 28/04/2018.
//  Copyright © 2018 Greg Szydlo. All rights reserved.
//

import Foundation

protocol PropertyStoring {
    associatedtype T
    
    func getAssociatedObject(_ key: UnsafePointer<State>!, defaultValue: T) -> T
}

extension PropertyStoring {
    func getAssociatedObject(_ key: UnsafePointer<State>!, defaultValue: T) -> T {
        guard let value = objc_getAssociatedObject(self, key) as? T else {
            return defaultValue
        }
        
        return value
    }
}
