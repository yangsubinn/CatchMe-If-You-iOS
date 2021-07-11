//
//  UserData.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/11.
//

import Foundation

enum DataKeys: String {
    case accessToken = "accessToken"
    case userName = "userName"
    case setKeyword = "setKeyword"
}

class UserDefaultStorage {
    static var accessToken: String {
        return UserData<String>.value(forKey: .accessToken) ?? "err"
    }
    
    static var userName: String {
        return UserData<String>.value(forKey: .userName) ?? "err"
    }
    
    static var setKeyword: Bool {
        return UserData<Bool>.value(forKey: .setKeyword) ?? false
    }
}

class UserData<T> {
    class func value(forKey key: DataKeys) -> T? {
        if let data = UserDefaults.standard.value(forKey : key.rawValue) as? T {
            return data
        } else {
            return nil
        }
    }
    
    class func set(_ value: T, forKey key: DataKeys) {
        UserDefaults.standard.set(value, forKey : key.rawValue)
    }
    
    class func addObserver(_ observer: NSObject, forKey key: DataKeys, options: NSKeyValueObservingOptions) {
        addObserver(observer, forKeyPath: key.rawValue, options: options)
    }
    
    class func addObserver(_ observer: NSObject, forKeyPath keyPath: String, options: NSKeyValueObservingOptions) {
        UserDefaults.standard.addObserver(observer, forKeyPath: keyPath, options: options, context: nil)
    }
    
    class func removeObserver(_ observer: NSObject, forKey key: DataKeys) {
        removeObserver(observer, forKeyPath: key.rawValue)
    }
    
    class func removeObserver(_ observer: NSObject, forKeyPath keyPath: String) {
        UserDefaults.standard.removeObserver(observer, forKeyPath: keyPath)
    }
    
    class func clearAll() {
        UserDefaults.standard.dictionaryRepresentation().keys.forEach { key in
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
}
