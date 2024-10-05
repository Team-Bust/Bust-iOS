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
    
    let beforeBottomSheetView = {
        let view = BeforBottomSheetView()
        view.bottomSheetColor = .white
        view.barViewColor = .gray200
        return view
    }()
    
    let afterBottomSheetView = {
        let view = AfterBottomSheetView()
        view.bottomSheetColor = .white
        view.barViewColor = .gray200
        return view
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MapView {
    
    func setUI(hasMissionStart: Bool) {
        beforeBottomSheetView.removeFromSuperview()
        afterBottomSheetView.removeFromSuperview()
        
        if hasMissionStart {
            addSubview(afterBottomSheetView)
            afterBottomSheetView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        } else {
            addSubview(beforeBottomSheetView)
            beforeBottomSheetView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
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
