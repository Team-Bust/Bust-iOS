//
//  HintService.swift
//  Bust-iOS
//
//  Created by KJ on 10/6/24.
//

import Foundation

import Moya

final class HintService {
    
    static let shared: HintService = HintService()
    
    private let mapProvider = MoyaProvider<HintTarget>(plugins: [NetworkLoggerPlugin()])
    private init() {}
    
    public private(set) var mapCompleteData: GeneralResponse<EmptyDto>?
    
    // MARK: - POST
    
    func postMapCheck(dto: HintRequestDto,
                      completion: @escaping(GeneralResponse<EmptyDto>?) -> Void) {
        mapProvider.request(.postMapComplete(dto: dto)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.mapCompleteData = try response.map(GeneralResponse<EmptyDto>.self)
                    guard let mapCompleteData = self.mapCompleteData else { return }
                    completion(mapCompleteData)
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
