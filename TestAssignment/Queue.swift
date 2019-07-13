//
//  Stack.swift
//  TestAssignment
//
//  Created by Вячеслав Горлов on 13/07/2019.
//  Copyright © 2019 Вячеслав Горлов. All rights reserved.
//

import Foundation

struct Queue<T> {
    
    private var storage = [T]()
    
    mutating func pop() -> T? {
        guard !storage.isEmpty else {
            return nil
        }
        
        return storage.removeFirst()
    }
    
    func peek() -> T? {
        return storage.first
    }
    
    mutating func push(element: T) {
        storage.append(element)
    }
    
    var isEmpty: Bool {
        return storage.isEmpty
    }
    
}
