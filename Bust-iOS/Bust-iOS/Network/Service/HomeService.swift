//
//  HomeService.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

import Foundation

import Moya

final class HomeService {
    
    static let shared: HomeService = HomeService()
    
    private let homeProvider = MoyaProvider<HomeTarget>(plugins: [NetworkLoggerPlugin()])
    private init() {}
    
    public private(set) var homeInfoData: GeneralResponse<HomeInfoResponseDto>?
    public private(set) var homeGameData: GeneralResponse<HomeGameResponseDto>?
    
    // MARK: - GET
    
    func getHomeInfo(completion: @escaping(GeneralResponse<HomeInfoResponseDto>?) -> Void) {
        homeProvider.request(.getHomeInfo) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.homeInfoData = try response.map(GeneralResponse<HomeInfoResponseDto>.self)
                    guard let homeInfoData = self.homeInfoData else { return }
                    completion(homeInfoData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getHomeGame(completion: @escaping(GeneralResponse<HomeGameResponseDto>?) -> Void) {
        homeProvider.request(.getUserGame) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.homeGameData = try response.map(GeneralResponse<HomeGameResponseDto>.self)
                    guard let homeGameData = self.homeGameData else { return }
                    completion(homeGameData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
}
