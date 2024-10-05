//
//  CheckAnswerViewController.swift
//  Bust-iOS
//
//  Created by KJ on 10/5/24.
//

import UIKit

import Moya
import SnapKit

enum AnswerViewType {
    case correctAnswer
    case useTicket
}

final class CheckAnswerViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewType: AnswerViewType
    
    // MARK: - UI Components
    
    private let navigationBar = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let backButton = {
        let button = UIButton()
        button.setImage(.icArrowBackTouch, for: .normal)
        return button
    }()

    lazy var checkAnswerView = {
        let view = CheckAnswerView(self.viewType)
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = false  
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private let checkButton = {
        let button = CheckButton()
        button.setTitle("확인", for: .normal)
        button.setState(.allow)
        return button
    }()
    
    // MARK: - Initializer
    
    init(_ type: AnswerViewType) {
        self.viewType = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setDelegate()
        registerForKeyboardNotifications()
        setTapScreen()
        setAddTarget()
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterFromKeyboardNotifications()
    }
    
    deinit {
        unregisterFromKeyboardNotifications()
    }
}

extension CheckAnswerViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        self.view.backgroundColor = .white
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        navigationBar.addSubview(backButton)
        self.view.addSubviews(navigationBar, checkAnswerView, checkButton)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        backButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        checkAnswerView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.width.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(116)
        }
            
        checkButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top).inset(-36)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        checkAnswerView.hintView.hintTextField.delegate = self
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func unregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func setTapScreen() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
            tapGestureRecognizer.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setAddTarget() {
        backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        checkButton.addTarget(self, action: #selector(checkButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - @objc Methods
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        
        checkAnswerView.contentInset = contentInsets
        checkAnswerView.scrollIndicatorInsets = contentInsets
        
        // 현재 편집 중인 텍스트 필드가 키보드에 가려지지 않도록 스크롤
        let activeField = checkAnswerView.hintView.hintTextField
        let rect = activeField.convert(activeField.bounds, to: checkAnswerView)
        checkAnswerView.scrollRectToVisible(rect, animated: true)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        checkAnswerView.contentInset = contentInsets
        checkAnswerView.scrollIndicatorInsets = contentInsets
    }
    
    @objc
    private func didTapScreen(_ gesture: UITapGestureRecognizer) {
        gesture.location(in: self.view)
        self.view.endEditing(true)
    }
    
    @objc
    private func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func checkButtonDidTap() {
        print("checkButtonDidTap")
    }
}

extension CheckAnswerViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.mainBlue.cgColor
        textField.textColor = .black
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
    }
}
