//
//  Login.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/11.
//

import UIKit

class Login: NSObject {
    static let shared = Login()
    let login = "isLogin"
    let auto = "isAuto"
    
    // MARK: - LOGIN
    func isLogin() -> Bool {
        let def = UserDefaults.standard
        let flag = def.bool(forKey: login)
        
        return flag
    }
    
    func isAuto() -> Bool {
        let def = UserDefaults.standard
        let flag = def.bool(forKey: auto)
        
        return flag
    }
    
    func setLogin(token: String, nickname: String, isAuto: Bool) {
        let def = UserDefaults.standard
        UserData.set(token, forKey: .accessToken)
        UserData.set(nickname, forKey: .userName)
        
        def.set(true, forKey: login)
        def.set(isAuto, forKey: auto)
        def.synchronize()
    }
    
    func setLoginOut() {
        let def = UserDefaults.standard
        
        UserData<Any>.clearAll()
        
        def.set(false, forKey: login)
        def.synchronize()
        
////        let rootVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(identifier: "LoginNavi")
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = rootVC        
    }
    
    func changeNickname(nickname: String) {
        UserData.set(nickname, forKey: .userName)
    }
}
