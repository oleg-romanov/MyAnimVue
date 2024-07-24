//
//  APIConstants.swift
//  MyAnimVue
//
//  Created by Олег Романов on 13.10.2023.
//
import Foundation

enum APIConstants {
    static let hostShikimori = "https://shikimori.one/api"
    static let hostAnilibria = "https://api.anilibria.tv/v3"
    static let responseType = "token"
    
    static func obtainClientId() -> String {
        var myDict: [String:String]?
        let url = obtainUrlPathToConfigPlist()
        
        myDict = NSDictionary(contentsOf: url) as? [String:String]
        
        if let clientId = myDict?["CLIENT_ID"] {
            return clientId
        } else {
            fatalError("Error getting Client ID value")
        }
    }
    
    static func obtainClientSecret() -> String {
        var myDict: [String:String]?
        let url = obtainUrlPathToConfigPlist()
        
        myDict = NSDictionary(contentsOf: url) as? [String:String]
        
        if let clientId = myDict?["CLIENT_SECRET"] {
            return clientId
        } else {
            fatalError("Error getting Client Secret value")
        }
    }
    
    private static func obtainUrlPathToConfigPlist() -> URL {
        guard let url = Bundle.main.url(forResource: "Config", withExtension: "plist") 
        else {
            fatalError("Couldn't find Config.plist in app bundle.")
        }
        
        return url
    }
}
