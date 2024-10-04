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
    @UserDefaultWrapper<Bool>(key: "doOnboarding") private(set) var doOnboarding
    
    var getSocialToken: String { return self.socialToken ?? "" }
    var hasAccessToken: Bool { return self.accessToken != nil }
    var getAccessToken: String { return self.accessToken ?? "" }
    var getOnboarding: Bool { return self.doOnboarding ?? false }
    
    private init() {}
}

extension UserManager {
    
    func updateSocialToken(_ socialToken: String) {
        self.socialToken = socialToken
    }
    
    func updateToken(_ accessToken: String) {
        self.accessToken = accessToken
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
