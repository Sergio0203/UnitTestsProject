//
//  Untitled.swift
//  AppUIKiTTeste
//
//  Created by Sérgio César Lira Júnior on 11/04/25.
//
import Foundation

enum DragonBallEndPoint: APIEndpoints {
    case getAllCharacters
    case getCharacterById(Int)
    
    var baseURL: URL {
        return URL(string:"https://www.dragonball-api.com/api")!
    }
    
    var path: String {
        switch self {
        case .getAllCharacters:
            return "/character"
        case .getCharacterById(let id):
            return "/character/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .getAllCharacters, .getCharacterById:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
            case .getAllCharacters, .getCharacterById:
            return ["Content-Type": "application/json"]
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getAllCharacters, .getCharacterById:
            return nil
        }
    }
    
}
