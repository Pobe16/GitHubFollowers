//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 16/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared           = NetworkManager()
    let baseURL                 = "https://api.github.com/"
    let perPageResults          = 100
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completed: @escaping(Result<[Follower], MLError>) ->Void) {
        let endpoint = baseURL + "users/\(username)/followers?per_page=\(perPageResults)"
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                //  guard followers.count > 0 else {
                //      completed(nil, "There are no followers for \(username)")
                //      return
                //  }
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
                return
            }
            
        }
        
        task.resume()
    }
}
