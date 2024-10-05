//
//  AddLocationViewController.swift
//  Bust-iOS
//
//  Created by KJ on 10/5/24.
//

import UIKit

import Moya
import SnapKit

final class AddLocationViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let backButton = {
        let button = UIButton()
        button.setImage(.icArrowBackTouch, for: .normal)
        return button
    }()
    
    private let addLocationLabel = {
        let label = UILabel()
        label.text = "나만의위치를\n공유해봐요."
        label.textColor = .black
        label.numberOfLines = 2
        label.font = .fontBust(.heading3)
        return label
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.text = "장소를 등록할 경우 티켓 3개가 소요됩니다."
        label.textColor = .gray400
        label.font = .fontBust(.body11)
        return label
    }()
    
    private let addressLabel = {
        let label = UILabel()
        label.text = "주소"
        label.textColor = .gray1000
        label.font = .fontBust(.body21)
        return label
    }()
    
    private let addressTextField = {
        let textField = UITextField()
        textField.placeholder = "주소를 입력해주세요."
        textField.font = .fontBust(.body11)
        textField.textColor = .gray300
        textField.backgroundColor = .gray100
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.setLeftPaddingPoints(16)
        return textField
    }()
    
    private let detailLabel = {
        let label = UILabel()
        label.text = "상세 설명"
        label.textColor = .gray1000
        label.font = .fontBust(.body21)
        return label
    }()
    
    private let detailTextView = {
        let textView = UITextView()
        textView.text = "장소에 대한 상세설명을 작성해주세요."
        textView.textColor = .gray300
        textView.font = .fontBust(.body11)
        textView.backgroundColor = .gray100
        textView.layer.cornerRadius = 8
        textView.layer.masksToBounds = true
        textView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return textView
    }()
    
    private let addButton = {
        let button = CheckButton()
        button.setTitle("장소 등록", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .fontBust(.body1)
        button.layer.cornerRadius = 8
        button.backgroundColor = .gray200
        button.setState(.notAllow)
        return button
    }()
    
    // MARK: - Properties
    
    private let textViewPlaceholder = "장소에 대한 상세설명을 작성해주세요."
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setDelegate()
        setTapScreen()
        setAddTarget()
        
        navigationController?.navigationBar.isHidden = true
    }
}

extension AddLocationViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        self.view.backgroundColor = .white
        
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        self.view.addSubviews(backButton, addLocationLabel, descriptionLabel,
                              addressLabel, addressTextField, detailLabel,
                              detailTextView, addButton)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.leading.equalToSuperview()
        }
        
        addLocationLabel.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(addLocationLabel.snp.bottom).offset(16)
            $0.leading.equalTo(addLocationLabel)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(36)
            $0.leading.equalTo(addLocationLabel)
        }
        
        addressTextField.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(54)
        }
        
        detailLabel.snp.makeConstraints {
            $0.top.equalTo(addressTextField.snp.bottom).offset(20)
            $0.leading.equalTo(addLocationLabel)
        }
        
        detailTextView.snp.makeConstraints {
            $0.top.equalTo(detailLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(152)
        }
        
        addButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(36)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
    }
    
    // MARK: - Methods
    
    func setDelegate() {
        detailTextView.delegate = self
        addressTextField.delegate = self
    }
    
    private func setTapScreen() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
            tapGestureRecognizer.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func validateFields() {
        let isAddressValid = !(addressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        let isDetailValid = detailTextView.text != textViewPlaceholder && !detailTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        if isAddressValid && isDetailValid {
            addButton.setState(.allow)  // 버튼 활성화
        } else {
            addButton.setState(.notAllow)  // 버튼 비활성화
        }
    }
    
    private func setAddTarget() {
        addButton.addTarget(self, action: #selector(addButtonTap), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func didTapScreen(_ gesture: UITapGestureRecognizer) {
        gesture.location(in: self.view)
        self.view.endEditing(true)
    }
    
    @objc
    private func addButtonTap() {
        print("addButtonTap")
    }
    
    @objc
    private func backButtonTap() {
        print("backButtonTap")
    }
}

extension AddLocationViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = nil
        textView.textColor = .black
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.mainBlue.cgColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderWidth = 0

        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceholder
            textView.textColor = UIColor.gray300
            textView.layer.borderWidth = 0
        }
        validateFields()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        validateFields()
    }
}

extension AddLocationViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.mainBlue.cgColor
        textField.textColor = .black
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        validateFields()  // 텍스트 변경 시 유효성 검사 호출
    }
}
