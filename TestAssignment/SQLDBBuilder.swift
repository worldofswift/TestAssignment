//
//  SQLDBBuilder.swift
//  TestAssignment
//
//  Created by Вячеслав Горлов on 13/07/2019.
//  Copyright © 2019 Вячеслав Горлов. All rights reserved.
//

import Foundation

final
class SQLDBBuilder {
    
    private init() {
        
    }
    
    static let shared = SQLDBBuilder()
    
    private let maxIterations = 10000
    
    #warning("Replace returning Bool for error handling")
    func makeDatabase(with files: [SQLFile]) -> Bool {
        var filesStash = files
        var backStash = Queue<SQLFile>()
        var iterations = 0
        
        while !(backStash.isEmpty && filesStash.isEmpty) && maxIterations >= iterations {
            let file: SQLFile
            if !filesStash.isEmpty {
                file = filesStash.removeLast()
            } else {
                file = backStash.pop()!
            }
            
            let result = SQLCommandExecutor.shared.execute(command: "\(file.content)")
            if let errorString = result.error, !errorString.isEmpty {
                backStash.push(element: file)
            }
            
            iterations += 1
        }
        
        return iterations <= maxIterations
    }
    
}
