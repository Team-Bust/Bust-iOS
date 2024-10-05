//
//  MypageService.swift
//  Bust-iOS
//
//  Created by KJ on 10/6/24.
//

import Foundation

import Moya

final class MypageService {
    
    static let shared: MypageService = MypageService()
    
    private let mypageProvider = MoyaProvider<MypageTarget>(plugins: [NetworkLoggerPlugin()])
    private init() {}
    
    public private(set) var mypageData: GeneralResponse<MypageResponseDto>?
    public private(set) var mypageDetailData: GeneralResponse<MypageDetailResponseDto>?
    
    // MARK: - GET
    
    func getMypage(completion: @escaping(GeneralResponse<MypageResponseDto>?) -> Void) {
        mypageProvider.request(.getMypage) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.mypageData = try response.map(GeneralResponse<MypageResponseDto>.self)
                    guard let mypageData = self.mypageData else { return }
                    completion(mypageData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getMypageDetail(id: Int,
                         completion: @escaping(GeneralResponse<MypageDetailResponseDto>?) -> Void) {
        mypageProvider.request(.getMypageDetail(id: id)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.mypageDetailData = try response.map(GeneralResponse<MypageDetailResponseDto>.self)
                    guard let mypageDetailData = self.mypageDetailData else { return }
                    completion(mypageDetailData)
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
