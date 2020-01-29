//
//  PersistenceManager.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 29/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favourites = "favourites"
    }
    
    static func updateWith(favourite: Follower, actionType: PersistenceActionType, completed: @escaping (MLError?) -> Void) {
        retrieveFavourites { (result) in
            switch result {
            case .success(let favourites):
                var retrievedFavourites = favourites
                
                switch actionType {
                case .add:
                    guard !retrievedFavourites.contains(favourite) else {
                        completed(.alreadyInFavourites)
                        return
                    }
                    
                    retrievedFavourites.append(favourite)
                case .remove:
                    retrievedFavourites.removeAll { $0.login == favourite.login }
                }
                
                completed(save(favourites: retrievedFavourites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavourites(completed: @escaping (Result<[Follower], MLError>) -> Void) {
        guard let favouritesData = defaults.object(forKey: Keys.favourites) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let followers = try decoder.decode([Follower].self, from: favouritesData)
            
            completed(.success(followers))
            
        } catch {
            completed(.failure(.unableToFavourite))
            return
        }
    }
    
    static func save(favourites: [Follower]) -> MLError? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavourites = try encoder.encode(favourites)
            
            defaults.set(encodedFavourites, forKey: Keys.favourites)
            
            return nil
            
        } catch {
            return .unableToFavourite
        }
        
    }
}
