//
//  WebService.swift
//  YLChallenge
//
//  Created by Jacob Martin on 6/3/17.
//  Copyright © 2017 Jacob Martin. All rights reserved.
//

import Foundation
import UIKit


struct Auth {
    static let clientID = "272a4ad9bbc8f745589d"
    static let clientSecret = "2e0f9affa7ec8b949d12c93f96964012d03bb70a"
    
    
    //append credentials to URL
    static func wrap(_ urlString:String) -> String {
        return urlString + "?client_id=\(clientID)&client_secret=\(clientSecret)"
    }
}


struct WebConfig {
    static let resultsPerPage = 100
}

struct Resource<T> {
    let url: URL
    let build: (Data) -> T?
}



typealias JSON = [String: AnyObject]



final class WebService{
    
    private init() {
        avatarCache.countLimit = 50
    }
    
    //MARK: Shared Instance
    
    static let shared: WebService = WebService()
    
    
    var avatarCache = LRUCache<NSURL,UIImage>()
    
    
    func loadResource<T>(resource: Resource<T>, completion: @escaping (T?) -> ()){
        
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            
            if error != nil {
                print(error)
                return
            }
            let result = data.flatMap(resource.build)
            completion(result)
            }.resume()
    }
}

extension WebService {
    
    func getUserData(user: String, completion: @escaping (User) -> ()) {
        let urlString = "https://api.github.com/users/\(user)"
        if let url = URL(string: Auth.wrap(urlString)) {
            let userResource = Resource<JSON>(url: url, build: { data in
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                return json as? JSON
                
            })
            
            loadResource(resource: userResource, completion: { data in
                if let data = data {
                    if let user = User(dictionary:data) {
                        completion(user)
                    }
                }
            })
        }
    }
    
    func getFollowers(user: String, atPage page: Int, completion: @escaping ([Follower]) -> ()) {
        let urlString = "https://api.github.com/users/\(user)/followers"
        if let url = URL(string: Auth.wrap(urlString)+"&per_page=\(WebConfig.resultsPerPage)&page=\(page)") {
            let followersResource = Resource<[JSON]>(url: url, build: { data in
                let result = try? JSONSerialization.jsonObject(with: data, options: [])
                return result as? [JSON]
                
            })
            
            loadResource(resource: followersResource, completion: { data in
                print(data)
                if let data = data {
                    var followers = [Follower]()
                    for json in data {
                        if let follower = Follower(dictionary:json) {
                            followers.append(follower)
                        }
                    }
                    completion(followers)
                }
            })
        }
    }
    
    
}


extension WebService {
    
    func retrieveAvatarFromUrl(_ url: URL, completion: @escaping (UIImage) -> ()) {
        
        getCache(url: url, completion: completion)
    }
    
    
    func setCache(url:URL, image: UIImage) {
        avatarCache[url as NSURL] = image
    }
    
    func getCache(url:URL, completion: @escaping (UIImage) -> ()) {
        
        if let image = avatarCache[url as NSURL] {
            completion(image)
        }
        else {
            let imageResource = Resource<UIImage>(url: url, build: { data in
                
                return UIImage(data: data)
                
            })
            
            loadResource(resource: imageResource, completion: { image in
                if let image = image {
                    self.setCache(url: url, image: image)
                    completion(image)
                }
            })
        }
    }
}
