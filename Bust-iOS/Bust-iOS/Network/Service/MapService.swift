//
//  MapService.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

import Foundation

import Moya

final class MapService {
    
    static let shared: MapService = MapService()
    
    private let mapProvider = MoyaProvider<MapTarget>(plugins: [NetworkLoggerPlugin()])
    private init() {}
    
    public private(set) var mapGameData: GeneralResponse<MapGameResponseDto>?
    public private(set) var mapCheckData: GeneralResponse<MapCheckResponseDto>?
    public private(set) var mapTicketData: GeneralResponse<MapCheckResponseDto>?
    
    // MARK: - GET
    
    func getMapGame(completion: @escaping(GeneralResponse<MapGameResponseDto>?) -> Void) {
        mapProvider.request(.getMapGame) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.mapGameData = try response.map(GeneralResponse<MapGameResponseDto>.self)
                    guard let mapGameData = self.mapGameData else { return }
                    completion(mapGameData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getMapCheck (completion: @escaping(GeneralResponse<MapCheckResponseDto>?) -> Void) {
        mapProvider.request(.getMapCheck) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.mapCheckData = try response.map(GeneralResponse<MapCheckResponseDto>.self)
                    guard let mapCheckData = self.mapCheckData else { return }
                    completion(mapCheckData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getMapTicket (completion: @escaping(GeneralResponse<MapCheckResponseDto>?) -> Void) {
        mapProvider.request(.getMapTicket) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    self.mapTicketData = try response.map(GeneralResponse<MapCheckResponseDto>.self)
                    guard let mapTicketData = self.mapTicketData else { return }
                    completion(mapTicketData)
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
