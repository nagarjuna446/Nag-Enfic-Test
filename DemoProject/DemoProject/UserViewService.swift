//
//  UserViewService.swift
//  DemoProject
//
//  Created by Nagarjuna on 5/10/24.
//

import Foundation

protocol ServiceDelegate: UserDelegate, PostDelegate {
    
}

protocol UserDelegate {
    func gerUsers(completion: @escaping(Result<[User], DemoError>) -> Void)
}

protocol PostDelegate {
    func getPosts(completion: @escaping(Result<[Post], DemoError>) -> Void)
}

class UserViewService:ServiceDelegate{
    
    
    func getPosts(completion: @escaping (Result<[Post], DemoError>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return completion(.failure(.BadURL))
        }
        NetworkHandler().fetchRequest(type: [Post].self, url: url, completion:completion)
    }
    
    func gerUsers(completion: @escaping (Result<[User], DemoError>) -> Void) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return completion(.failure(.BadURL))
        }
            NetworkHandler().fetchRequest(type: [User].self, url: url, completion: completion)
        
    }
    
    
    
    
}
