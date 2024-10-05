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
    
    private var hasMissionStart: Bool = true // 서버에서 받을 미션시작여부
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        setMap()
    }
}

extension MapViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.mapView.setUI(hasMissionStart: self.hasMissionStart)
        self.mapView.afterBottomSheetView.bindAfterBS(data: "아 부산해커톤 힘들어여 졸린거 같아여 하지만 오늘이 마지막이니까 버텨는 볼게여?ㅋㅋ")
    }
    
    func setDelegate() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func setMap() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                    self.locationManager.startUpdatingLocation()
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                print("현재 사용자의 authorization status: \(authorization)")
                
            } else {
                print("위치 권한 허용 꺼져있음")
            }
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("현재 위치: \(location.coordinate)")
            
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude))
            cameraUpdate.animation = .easeIn
            map.moveCamera(cameraUpdate)
            
            let marker = NMFMarker()
            let image = self.hasMissionStart ? UIImage(named: "graphic_pick_place") : UIImage(named: "ic_loaction")
            marker.iconImage = NMFOverlayImage(image: image ?? UIImage())
            marker.position = NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0)
            marker.mapView = map
            
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치 업데이트 실패: \(error.localizedDescription)")
    }
}
