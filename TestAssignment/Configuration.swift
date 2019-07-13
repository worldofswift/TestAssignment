//
//  Configuration.swift
//  TestAssignment
//
//  Created by Вячеслав Горлов on 13/07/2019.
//  Copyright © 2019 Вячеслав Горлов. All rights reserved.
//

import Foundation

struct Configuration {
    
    let type: SQLType
    let path: URL
    let cliPath: URL
    let user: String
    let password: String
    let databaseName = "__" + UUID().uuidString.replacingOccurrences(of: "-", with: "_")
    
    private
    enum Argument: String, CaseIterable {
        case type = "-type"
        case cliPath = "-cli-path"
        case path = "-path"
        case user = "-user"
        case password = "-password"
    }
    
    static var shared: Configuration?
    
    static func make(from processInfo: ProcessInfo) -> Configuration {
        if let shared = shared {
            return shared
        }
        
        let arguments = processInfo.arguments
        var rawConfiguration = [Argument: Any]()
        
        for argument in arguments {
            for argumentCase in Argument.allCases {
                if argument.hasPrefix(argumentCase.rawValue) {
                    switch argumentCase {
                    case .type:
                        guard
                            let typeStringValue = argument.split(separator: "=", maxSplits: 1).last,
                            let type = SQLType(rawValue: String(typeStringValue))
                        else {
                            fatalError("Cannot get the correct sql type")
                        }
                        rawConfiguration[.type] = type
                    case .path:
                        guard
                            let pathStringValue = argument.split(separator: "=", maxSplits: 1).last,
                            let url = URL(string: String(pathStringValue)),
                            FileManager.default.fileExists(atPath: url.path)
                        else {
                            fatalError("Cannot get the correct url to directory")
                        }
                        
                        rawConfiguration[.path] = url
                    case .cliPath:
                        guard
                            let cliPathStringValue = argument.split(separator: "=", maxSplits: 1).last,
                            let url = URL(string: String(cliPathStringValue))
                        else {
                            fatalError("Cannot get the correct url to sql cli")
                        }
                        
                        rawConfiguration[.cliPath] = url
                    case .user:
                        guard
                            let user = argument.split(separator: "=", maxSplits: 1).last
                        else {
                            fatalError("Cannot get the user string")
                        }
                        
                        rawConfiguration[.user] = String(user)
                    case .password:
                        guard
                            let password = argument.split(separator: "=", maxSplits: 1).last
                        else {
                            fatalError("Cannot get the password string")
                        }
                        
                        rawConfiguration[.password] = String(password)
                    }
                }
            }
        }
        
        let configuration = Configuration(
            type: rawConfiguration[.type] as! SQLType,
            path: rawConfiguration[.path] as! URL,
            cliPath: rawConfiguration[.cliPath] as! URL,
            user: rawConfiguration[.user] as! String,
            password: rawConfiguration[.password] as! String
        )
        shared = configuration
        
        return configuration
    }
}
