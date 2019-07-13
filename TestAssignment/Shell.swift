//
//  Shell.swift
//  TestAssignment
//
//  Created by Вячеслав Горлов on 13/07/2019.
//  Copyright © 2019 Вячеслав Горлов. All rights reserved.
//

import Foundation

final
class Shell {
    
    static let shared = Shell()
    
    private init() {}
    
    let shellPath = "/bin/sh"
    
    func exec(command: String) -> (output: String?, error: String?) {
        let outputPipe = Pipe()
        let errorPipe = Pipe()
        let process = Process()
        process.launchPath = shellPath
        process.arguments = ["-c", String(format: "%@", command)]
        process.standardOutput = outputPipe
        process.standardError = errorPipe
        let outputFileHandle = outputPipe.fileHandleForReading
        let errorFileHandle = errorPipe.fileHandleForReading
        process.launch()
        return (
            output: String(data: outputFileHandle.readDataToEndOfFile(), encoding: .utf8),
            error: String(data: errorFileHandle.readDataToEndOfFile(), encoding: .utf8)
        )
    }
    
}
