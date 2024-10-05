//
//  MapViewController.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

import UIKit

import NMapsMap

final class MapViewController: UIViewController {
    
    // MARK: - Properties
    
    private let mapView = MapView()
    private lazy var map = mapView.mapView
    private var locationManager = CLLocationManager()
    
    private var hasMissionStart: Bool = false
    private var inScope: Bool = false
    private var hasTicket: Bool = false
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = mapView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getMapGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        setAddTarget()
    }
}

extension MapViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.mapView.afterBottomSheetView.bindAfterBS(data: "아 부산해커톤 힘들어여 졸린거 같아여 하지만 오늘이 마지막이니까 버텨는 볼게여?ㅋㅋ")
    }
    
    func setDelegate() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    // 사용자 위치로 카메라 이동
    @discardableResult
    func moveToUserLocation() -> Self {
        let userLatLng = getUserLocation()
        let cameraUpdate = NMFCameraUpdate(scrollTo: userLatLng)
        
        DispatchQueue.main.async { [weak self] in
            cameraUpdate.animation = .easeIn
            self?.map.moveCamera(cameraUpdate)
        }
        return self
    }
    
    // 사용자 위치 가져오기
    func getUserLocation() -> NMGLatLng {
        let userLocation = locationManager.location?.coordinate
        let userLatLng = userLocation?.toNMGLatLng() ?? NMGLatLng(lat: 0,lng: 0)
        return userLatLng
    }
    
    // 지정 위치로 카메라 이동
    @discardableResult
    func moveToLocation(location: NMGLatLng) -> Self {
        let cameraUpdate = NMFCameraUpdate(scrollTo: location)
        DispatchQueue.main.async { [weak self] in
            cameraUpdate.animation = .easeIn
            self?.map.moveCamera(cameraUpdate)
        }
        return self
    }
    
    // 두 지점 간 거리 계산 함수
    func haversine(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {
        let R = 6371.0
        
        let lat1Rad = lat1 * .pi / 180
        let lon1Rad = lon1 * .pi / 180
        let lat2Rad = lat2 * .pi / 180
        let lon2Rad = lon2 * .pi / 180
        
        let dlat = lat2Rad - lat1Rad
        let dlon = lon2Rad - lon1Rad
        
        let a = sin(dlat / 2) * sin(dlat / 2) +
        cos(lat1Rad) * cos(lat2Rad) *
        sin(dlon / 2) * sin(dlon / 2)
        
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))
        
        let distance = R * c // 두 지점 사이의 거리 (단위: km)
        
        return distance
    }
    
    // 특정 위치가 오차 범위 내에 있는지 확인하는 함수
    func isWithinRange(lat1: Double, lon1: Double, lat2: Double, lon2: Double, range: Double) -> Bool {
        let distance = haversine(lat1: lat1, lon1: lon1, lat2: lat2, lon2: lon2)
        return distance <= range
    }
    
    func setAddTarget() {
        mapView.afterBottomSheetView.checkAnswerButton.addTarget(self, action: #selector(checkAnswerButtonTapped), for: .touchUpInside)
        mapView.afterBottomSheetView.useTicketButton.addTarget(self, action: #selector(useTicketButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func checkAnswerButtonTapped() {
        if inScope { // 정답이슈
            let nav = CheckAnswerViewController()
            self.navigationController?.pushViewController(nav, animated: true)
        } else { // 틀림이슈
            self.mapView.wrongAnswerToast.isHidden = false
            UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseOut, animations: {
                self.mapView.wrongAnswerToast.alpha = 0.0
            }, completion: {_ in
                self.mapView.wrongAnswerToast.isHidden = true
                self.mapView.wrongAnswerToast.alpha = 1.0
            })
        }
    }
    
    @objc
    func useTicketButtonTapped() {
        if hasTicket {
            let nav = CheckAnswerViewController()
            self.navigationController?.pushViewController(nav, animated: true)
        } else {
            self.mapView.noTicketToast.isHidden = false
            UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseOut, animations: {
                self.mapView.noTicketToast.alpha = 0.0
            }, completion: {_ in
                self.mapView.noTicketToast.isHidden = true
                self.mapView.noTicketToast.alpha = 1.0
            })
        }
    }
}

extension CLLocationCoordinate2D {
    func toNMGLatLng() -> NMGLatLng {
        return NMGLatLng(lat: self.latitude, lng: self.longitude)
    }
}

extension MapViewController {
    
    func getMapGame() {
        MapService.shared.getMapGame {  response in
            guard let data = response?.data else { return }
            self.hasMissionStart = data.gameStarted
            self.mapView.setUI(hasMissionStart: data.gameStarted)
            self.hasTicket = data.tickets > 0
            if data.gameStarted {
                let marker = NMFMarker()
                marker.position = NMGLatLng(lat: Double(data.place.위도) ?? 0.0,
                                            lng: Double(data.place.경도) ?? 0.0)
                let image = UIImage(named: "graphic_pick_place")
                marker.iconImage = NMFOverlayImage(image: image ?? UIImage())
                marker.mapView = self.map
                self.moveToLocation(location: NMGLatLng(lat: Double(data.place.위도) ?? 0.0,
                                                        lng: Double(data.place.경도) ?? 0.0))
                
                if self.isWithinRange(lat1: Double(data.place.위도) ?? 0.0,
                                      lon1: Double(data.place.경도) ?? 0.0,
                                      lat2: self.getUserLocation().lat,
                                      lon2: self.getUserLocation().lng,
                                      range: 0.3) {
                    print("범위 안에 있음")
                    self.inScope = true
                } else {
                    print("범위 밖에 있음")
                    self.inScope = false
                }
            } else {
                let marker = NMFMarker()
                marker.position = NMGLatLng(lat: Double(data.place.위도) ?? 0.0,
                                            lng: Double(data.place.경도) ?? 0.0)
                let image = UIImage(named: "ic_location")
                marker.iconImage = NMFOverlayImage(image: image ?? UIImage())
                marker.mapView = self.map
                self.moveToUserLocation()
            }
        }
    }
}
