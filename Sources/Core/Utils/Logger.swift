//
//  Logger.swift
//  
//
//  Created by xuanbach on 03/08/2022.
//

import Foundation

public class Logger {
    public static func log(_ item: Any, prefix: String = "🇻🇳🇻🇳🇻🇳", separator: String = " ", terminator: String = "\n") {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        print(formatter.string(from: Date()), prefix, item, separator: separator, terminator: terminator)
    }

    public static func `deinit`<T>(_ value: T) {
        log("\(type(of:value))", prefix: "🌋🌋🌋 [deinit]")
    }
    
    public static func `init`<T>(_ value: T) {
        log("\(type(of:value))", prefix: "🚀🚀🚀 [init]")
    }
}

public func debugLog(_ item: Any, prefix: String = "🇻🇳🇻🇳🇻🇳", separator: String = " ", terminator: String = "\n") {
    Logger.log(item, prefix: prefix, separator: separator, terminator: terminator)
}

public func errorLog(_ item: Any) {
    Logger.log(item, prefix: "🤬🤬🤬 [error]")
}

public func warningLog(_ item: Any) {
    Logger.log(item, prefix: "⚠️⚠️⚠️ [warning]")
}
