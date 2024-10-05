//
//  MapView.swift
//  Bust-iOS
//
//  Created by 고아라 on 10/5/24.
//

import UIKit

import SnapKit
import NMapsMap

final class MapView: UIView {
    
    var mapView = {
        let map = NMFMapView()
        map.minZoomLevel = 10.0
        map.maxZoomLevel = 15.0
        return map
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MapView {
    
    func setUI() {
        
    }
    
    func setHierarchy() {
        addSubview(mapView)
    }
    
    func setLayout() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
