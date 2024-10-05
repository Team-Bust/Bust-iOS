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
        map.maxZoomLevel = 14.5
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
    
    let wrongAnswerToast = {
        let label = UILabel()
        label.text = "위치가 맞지 않아요. 다시 시도해주세요."
        label.textColor = .white
        label.font = .fontBust(.body1)
        label.backgroundColor = .bustError.withAlphaComponent(0.8)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 8
        label.isHidden = true
        return label
    }()
    
    let noTicketToast = {
        let label = UILabel()
        label.text = "티켓이 부족해요. 다시 시도해주세요."
        label.textColor = .white
        label.font = .fontBust(.body1)
        label.backgroundColor = .bustError.withAlphaComponent(0.8)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 8
        label.isHidden = true
        return label
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
        addSubviews(mapView,
                    wrongAnswerToast,
                    noTicketToast)
    }
    
    func setLayout() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        wrongAnswerToast.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 71)
            $0.height.equalTo(40)
        }
        
        noTicketToast.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 89)
            $0.height.equalTo(40)
        }
    }
}
