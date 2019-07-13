//
//  main.swift
//  TestAssignment
//
//  Created by Вячеслав Горлов on 13/07/2019.
//  Copyright © 2019 Вячеслав Горлов. All rights reserved.
//

import Foundation

// MARK: - Configuration
let configuration = Configuration.make(from: ProcessInfo.processInfo)

// MARK: - Connect to mysql and make the base datavase
print("Creating database with result", SQLCommandExecutor.shared.execute(command: "CREATE DATABASE IF NOT EXISTS \(configuration.databaseName);", isInitial: true))

// MARK: - Get files
guard let enumerator = FileManager.default.enumerator(at: configuration.path, includingPropertiesForKeys: []) else {
    fatalError("Cannot get the enumerator for provided directory")
}

var files = [SQLFile]()
for case let file as URL in enumerator {
    if file.pathExtension == "sql" {
        files.append(SQLFile(path: file.path))
    }
}

// MARK: - Build the database
print(SQLDBBuilder.shared.makeDatabase(with: files))

