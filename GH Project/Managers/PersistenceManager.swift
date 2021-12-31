//
//  PersistenceManager.swift
//  GH Project
//
//  Created by Andres Gutierrez on 12/30/21.
//

import Foundation

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Followers],GFError>) -> Void){
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else{
            completed(.success([]))
            return
        }
        
        do{
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Followers].self, from: favoritesData)
            completed(.success(favorites))
        }catch{
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Followers]) -> GFError? {
        do{
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch { return .unableToFavorite }
    }
}
