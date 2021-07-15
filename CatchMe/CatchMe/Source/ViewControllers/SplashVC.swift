//
//  SplashVC.swift
//  CatchMe
//
//  Created by 양수빈 on 2021/07/16.
//

import UIKit
import Lottie

class SplashVC: UIViewController {
    
    private var animationView: AnimationView?

    override func viewDidLoad() {
        print("로티 시작")
        setupLottieView()
        print("로티 끝남")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [self] in
            if Login.shared.isLogin() {
                /// 로그인이 되어있는 상태 == mainVC로 이동
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let dvc = storyboard.instantiateViewController(identifier: "MainVC") as? MainVC else { return }
                dvc.modalPresentationStyle = .fullScreen
                self.present(dvc, animated: true, completion: nil)
            } else {
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                let dvc = storyboard.instantiateViewController(identifier: "LoginNavi")
                dvc.modalPresentationStyle = .fullScreen
                self.present(dvc, animated: true, completion: nil)
            }
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        print(viewWillAppear)
    }
    func setupLottieView() {
        view.backgroundColor = .black100
        animationView = .init(name: "splash")
        animationView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        animationView!.contentMode = .scaleAspectFit
        animationView!.animationSpeed = 1
        animationView!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView!)
        NSLayoutConstraint.activate([
            animationView!.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -30),
            animationView!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            animationView!.widthAnchor.constraint(equalToConstant: 297),
            animationView!.heightAnchor.constraint(equalToConstant: 87),
        ])
        animationView!.play()
        print("애니메이션 끝남")
    }
}
