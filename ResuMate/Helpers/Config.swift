//
//  Config.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 08/06/23.
//

import Foundation

struct Config {
    private static let configPlist = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Config", ofType: "plist")!)!
    
    static var openAIAuthorizationKey: String {
        return configPlist["AuthorizationKey"] as! String
    }
}
