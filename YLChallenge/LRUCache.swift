//
//  LRUCache.swift
//  YLChallenge
//
//  Created by Jacob Martin on 6/3/17.
//  Copyright © 2017 Jacob Martin. All rights reserved.
//

import Foundation

struct LRUCache<K:AnyObject, V:AnyObject> {
    
    private let _cache = NSCache<AnyObject, AnyObject>()
    
    var countLimit:Int {
        get {
            return _cache.countLimit
        }
        nonmutating set(countLimit) {
            _cache.countLimit = countLimit
        }
    }
    subscript(key:K!) -> V? {
        get {
            let obj:AnyObject? = _cache.object(forKey: key)
            return obj as! V?
        }
        nonmutating set(obj) {
            if(obj == nil) {
                _cache.removeObject(forKey: key)
            }
            else {
                _cache.setObject(obj!, forKey: key)
            }
        }
    }
}
