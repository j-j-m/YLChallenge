//
//  FollowerSource.swift
//  YLChallenge
//
//  Created by Jacob Martin on 6/4/17.
//  Copyright © 2017 Jacob Martin. All rights reserved.
//

import Foundation

//protocol DataSource<T> {
//    func fetch(completion: @escaping ([T]) -> ())
//    func itemAt(index: Int) -> T
//}
//
//class followerSource: DataSource {
//    var pageSize = WebConfig.resultsPerPage
//    var data = [Follower]()
//    
//    var searchTerm:String = "" {
//        willSet {
//           data.removeAll()
//        }
//     
//    }
//    var page = 1 // to keep track of the currently fetched page
//    
//    var count:Int {
//        return data.count
//    }
//    
//    func itemAt(index: Int) {
//        
//    }
//    
//    func fetch(completion: @escaping ([Follower]) -> ()) {
//        WebService.shared.getFollowers(user: searchTerm, atPage: page) { followers in
//           self.data.append(contentsOf: followers)
//            completion(followers)
//        }
//        
//    }
//}
