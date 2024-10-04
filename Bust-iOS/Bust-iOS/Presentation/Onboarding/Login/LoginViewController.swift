//
//  LoginViewController.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//


import UIKit

import SnapKit

import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices

final class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setAddTarget()
    }
}

extension LoginViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setAddTarget() {
        loginView.kakaoButton.addTarget(self,
                                        action: #selector(checkHasKakaoApp),
                                        for: .touchUpInside)
    }
    
    @objc
    func checkHasKakaoApp() {
        if UserApi.isKakaoTalkLoginAvailable() {
            kakaoAppLogin()
        } else {
            kakaoLogin()
        }
    }
    
    func kakaoLogin() {
        UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
            if error != nil {
                self.showKakaoLoginFailMessage()
            } else if let socialToken = oauthToken?.accessToken {
                print("💭💭💭💭")
                UserApi.shared.me { (user, error) in
                    if let error = error {
                        print("사용자 정보를 가져오는 데 실패했습니다: \(error.localizedDescription)")
                    } else {
                        if let nickname = user?.kakaoAccount?.profile?.nickname {
                            print("사용자 닉네임: \(nickname)")
                        }
                    }
                }
                UserManager.shared.updateSocialToken(socialToken)
                print("💭💭💭💭")
                print(socialToken)
                self.postLogin()
            }
        }
    }
    
    func kakaoAppLogin() {
        UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
            if error != nil {
                self.showKakaoLoginFailMessage()
            } else if let socialToken = oauthToken?.accessToken {
                UserManager.shared.updateSocialToken(socialToken)
                print("💭💭💭💭")
                UserApi.shared.me { (user, error) in
                    if let error = error {
                        print("사용자 정보를 가져오는 데 실패했습니다: \(error.localizedDescription)")
                    } else {
                        if let nickname = user?.kakaoAccount?.profile?.nickname {
                            print("사용자 닉네임: \(nickname)")
                        }
                    }
                }
                print("💭💭💭💭")
                print(socialToken)
                self.postLogin()
            }
        }
    }
    
    func showKakaoLoginFailMessage() {
        print("카카오 로그인 실패")
    }
}

extension LoginViewController {
    
    func postLogin() {
        print("로그인 통신")
    }
}
