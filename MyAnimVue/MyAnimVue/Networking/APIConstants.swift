//
//  APIConstants.swift
//  MyAnimVue
//
//  Created by Олег Романов on 13.10.2023.
//
import Foundation

enum APIConstants {
    static let host = "https://api.anilibria.tv/v3/"
    static let responseType = "token"
    
    func obtainClientId() -> String {
        var myDict: [String:String]?
        let url = obtainUrlPathToConfigPlist()
        
        myDict = NSDictionary(contentsOf: url) as? [String:String]
        
        if let clientId = myDict?["CLIENT_ID"] {
            return clientId
        } else {
            fatalError("Error getting Client ID value")
        }
    }
    
    func obtainClientSecret() -> String {
        var myDict: [String:String]?
        let url = obtainUrlPathToConfigPlist()
        
        myDict = NSDictionary(contentsOf: url) as? [String:String]
        
        if let clientId = myDict?["CLIENT_SECRET"] {
            return clientId
        } else {
            fatalError("Error getting Client Secret value")
        }
    }
    
    private func obtainUrlPathToConfigPlist() -> URL {
        guard
            let pathString = Bundle.main.path(forResource: "Config", ofType: "plist"),
            let pathUrl = URL(string: pathString)
        else {
            fatalError("Couldn't find Config.plist in app bundle.")
        }
        return pathUrl
    }
}
