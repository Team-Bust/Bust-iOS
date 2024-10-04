//
//  ViewController.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/4/24.
//

import UIKit
import NMapsMap
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var mapView: NMFMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NMFMapView 초기화
        mapView = NMFMapView(frame: view.frame)
        mapView.minZoomLevel = 10.0
        mapView.maxZoomLevel = 15.0
        view.addSubview(mapView)
        
        // CLLocationManager 설정
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("현재 위치: \(location.coordinate)")
            
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude))
            cameraUpdate.animation = .easeIn
            mapView.moveCamera(cameraUpdate)
            
            let marker = NMFMarker()
            let image = UIImage(named: "ic_mark")
            marker.iconImage = NMFOverlayImage(image: image ?? UIImage())
            marker.position = NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0)
            marker.mapView = mapView
            
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치 업데이트 실패: \(error.localizedDescription)")
    }
}
