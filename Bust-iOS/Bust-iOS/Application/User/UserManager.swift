//
//  UserManager.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/4/24.
//


import Foundation

final class UserManager {
    
    static let shared = UserManager()
    
    @UserDefaultWrapper<String>(key: "socialToken") private(set) var socialToken
    @UserDefaultWrapper<String>(key: "accessToken") private(set) var accessToken
    @UserDefaultWrapper<String>(key: "userName") private(set) var userName
    @UserDefaultWrapper<Bool>(key: "doOnboarding") private(set) var doOnboarding
    
    var getSocialToken: String { return self.socialToken ?? "" }
    var hasAccessToken: Bool { return self.accessToken != nil }
    var getAccessToken: String { return self.accessToken ?? "" }
    var getUsername: String { return self.userName ?? "" }
    var getOnboarding: Bool { return self.doOnboarding ?? false }
    
    private init() {}
}

extension UserManager {
    
    func updateSocialToken(_ socialToken: String) {
        self.socialToken = socialToken
    }
    
    func updateToken(_ accessToken: String,
                     _ username: String) {
        self.accessToken = accessToken
    }
    
    func updateUsername(_ username: String) {
        self.userName = username
    }
    
    func updateOnboarding() {
        self.doOnboarding = true
    }
    
    func logout() {
        self.accessToken = nil
    }
    
    func withdraw() {
        self.accessToken = nil
    }
}
