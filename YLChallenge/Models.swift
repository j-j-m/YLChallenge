//
//  Models.swift
//  YLChallenge
//
//  Created by Jacob Martin on 6/3/17.
//  Copyright © 2017 Jacob Martin. All rights reserved.
//

import Foundation

// scratch for user
//
//{
//    "login": "j-j-m",
//    "id": 5327798,
//    "avatar_url": "https://avatars1.githubusercontent.com/u/5327798?v=3",
//    "gravatar_id": "",
//    "url": "https://api.github.com/users/j-j-m",
//    "html_url": "https://github.com/j-j-m",
//    "followers_url": "https://api.github.com/users/j-j-m/followers",
//    "following_url": "https://api.github.com/users/j-j-m/following{/other_user}",
//    "gists_url": "https://api.github.com/users/j-j-m/gists{/gist_id}",
//    "starred_url": "https://api.github.com/users/j-j-m/starred{/owner}{/repo}",
//    "subscriptions_url": "https://api.github.com/users/j-j-m/subscriptions",
//    "organizations_url": "https://api.github.com/users/j-j-m/orgs",
//    "repos_url": "https://api.github.com/users/j-j-m/repos",
//    "events_url": "https://api.github.com/users/j-j-m/events{/privacy}",
//    "received_events_url": "https://api.github.com/users/j-j-m/received_events",
//    "type": "User",
//    "site_admin": false,
//    "name": "Jacob Martin",
//    "company": null,
//    "blog": "",
//    "location": "Detroit, MI",
//    "email": null,
//    "hireable": true,
//    "bio": null,
//    "public_repos": 9,
//    "public_gists": 2,
//    "followers": 4,
//    "following": 0,
//    "created_at": "2013-08-28T07:06:33Z",
//    "updated_at": "2017-05-16T10:28:04Z"
//}

struct User {
    let login: String
    let avatarURL: URL?
    let name: String?
    let location: String?
    var email: String?
    let publicRepos: Int
    let followers: Int
    let following: Int
    
    public init?(dictionary: JSON) {
        
        guard let login = dictionary["login"] as? String,
            let avatarURLString = dictionary["avatar_url"] as? String,
            let publicRepos = dictionary["public_repos"] as? Int,
            let followers = dictionary["followers"] as? Int,
            let following = dictionary["following"] as? Int
            else { return nil }
        self.login = login
        self.avatarURL = URL(string: avatarURLString)
        self.publicRepos = publicRepos
        self.followers = followers
        self.following = following
        
        //optional fields
        if let name = dictionary["name"] as? String { self.name = name }
        else { self.name = nil }
        if let email = dictionary["email"] as? String { self.email = email }
        else { self.email = nil }
        if let loc = dictionary["location"] as? String { self.location = loc }
        else { self.location = nil }
    }
}


struct Follower {
    let login: String
    let avatarURL: URL?
    let followersURL: URL?
    
    public init?(dictionary: JSON) {
        
        guard let login = dictionary["login"] as? String,
        let avatarURLString = dictionary["avatar_url"] as? String,
        let followersURLString = dictionary["followers_url"] as? String
        else { return nil }
        self.login = login
        self.avatarURL = URL(string: avatarURLString)
        self.followersURL = URL(string: followersURLString)
        
    }
}

