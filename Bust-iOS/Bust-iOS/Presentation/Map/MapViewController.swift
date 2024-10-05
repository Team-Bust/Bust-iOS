//
//  MapViewController.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

import UIKit

import NMapsMap

final class MapViewController: UIViewController {
    
    private let mapView = MapView()
    private lazy var map = mapView.mapView
    private var locationManager = CLLocationManager()
    
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
            let image = UIImage(named: "ic_mark")
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
