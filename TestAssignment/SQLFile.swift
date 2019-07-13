//
//  SQLFile.swift
//  TestAssignment
//
//  Created by Вячеслав Горлов on 13/07/2019.
//  Copyright © 2019 Вячеслав Горлов. All rights reserved.
//

import Foundation

struct SQLFile {
    
    let url: URL
    let content: String
    
    init(path: String) {
        guard FileManager.default.fileExists(atPath: path) else {
            fatalError("File at path `\(path)` doesn't exist")
        }
        
        let url = URL(fileURLWithPath: path)
        self.url = url
        
        print(url.absoluteString)
        
        let data: Data
        do {
            data = try Data(contentsOf: url)
        } catch {
            fatalError("Cannot get content of .sql file at `\(url.path)` due to error \(error)")
        }
        
        guard let content = String(data: data, encoding: .utf8) else {
            fatalError("Invalid encoding of .sql file at `\(url.path)`")
        }
        self.content = content
    }
    
}
