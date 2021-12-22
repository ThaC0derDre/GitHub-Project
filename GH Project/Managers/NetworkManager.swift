//
//  NetworkManager.swift
//  GH Project
//
//  Created by Andres Gutierrez on 12/22/21.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com/users/"
    
    private init(){}
    
    func getFollowers(for userName: String, page: Int, completed: @escaping(Result<[Followers], ErrorMessage>) -> Void){
        let endpoint = baseUrl + "\(userName)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint)else{
            completed(.failure(.invalidUsername))
            return
        }
        // Create task
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle errors first. Work backwards
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            // All good? Lets decode the data
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Followers].self, from: data)
                completed(.success(followers))
            }catch{
                completed(.failure(.invalidData))
            }
        }
                //Begin call
        task.resume()
    }
    
}
