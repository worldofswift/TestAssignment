//
//  SQLCommandExecutor.swift
//  TestAssignment
//
//  Created by Вячеслав Горлов on 13/07/2019.
//  Copyright © 2019 Вячеслав Горлов. All rights reserved.
//

import Foundation

final
class SQLCommandExecutor {
    
    static let shared = SQLCommandExecutor()
    
    let configuration: Configuration
    let baseCommand: String
    
    private init() {
        self.configuration = Configuration.make(from: ProcessInfo.processInfo)
        self.baseCommand = """
        \(configuration.cliPath) -u \(configuration.user) -p\(configuration.password) <<OMG
        BEGIN;
        
        %@
        USE \(configuration.databaseName);
        %@
        
        COMMIT;
        OMG
        """
    }
    
    func execute(command: String, isInitial: Bool = false) -> (output: String?, error: String?) {
        var result = Shell.shared.exec(command: String(format: self.baseCommand, isInitial ? command : "", isInitial ? "" : command))
        result.error = result.error?.replacingOccurrences(of: "mysql: [Warning] Using a password on the command line interface can be insecure.\n", with: "") // This fixes trash output for MySQL and some other engines
        return result
    }
    
}
