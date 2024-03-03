//
//  SearchListViewController.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 3/3/24.
//

import UIKit

import SnapKit
import Then

final class SearchListViewController: BaseViewController {
    
    // MARK: Property
    private let backButton = UIButton()
    private let searchMapView = UIView()
    private let searchListTextField = UITextField()
    private let searchButton = UIButton()
    private let clearButton = UIButton()
    private let searchMapGraphic = PINGLESearchView(searchExplainLabel: StringLiterals.Home.Search.searchListExplain)
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
        setNavigation()
        clearTabBar()
        setDelegate()
        hideKeyboardWhenTappedAround()
        setKeyBoard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setKeyBoard()
        clearTextField()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: UI
    override func setStyle() {
        self.view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        backButton.do {
            $0.setImage(UIImage(resource: .icArrowLeft), for: .normal)
        }
        
        searchMapView.do {
            $0.backgroundColor = .grayscaleG10
            $0.layer.cornerRadius = 8
        }
        
        searchListTextField.do {
            $0.font = .bodyBodySemi14
            $0.textColor = .white
            $0.tintColor = .mainPingleGreen
            $0.returnKeyType = .search
            $0.enablesReturnKeyAutomatically = true
            $0.attributedPlaceholder = NSAttributedString(
                string: StringLiterals.Home.Search.searchListPlaceHolder,
                attributes: [
                    .font: UIFont.bodyBodyMed14,
                    .foregroundColor: UIColor.grayscaleG07
                ]
            )
        }
        
        searchButton.do {
            $0.setImage(UIImage(resource: .icSearch), for: .normal)
        }
        
        clearButton.do {
            $0.setImage(UIImage(resource: .btnClear), for: .normal)
            $0.isHidden = true
        }
    }
    
    override func setLayout() {
        self.view.addSubviews(backButton, searchMapView, searchMapGraphic)
        searchMapView.addSubviews(searchListTextField, searchButton, clearButton)
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(60)
            $0.leading.equalToSuperview().inset(18.adjusted)
            $0.trailing.equalToSuperview().inset(333.adjusted)
        }
        
        searchMapView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalToSuperview().inset(49.adjusted)
            $0.trailing.equalToSuperview().inset(24.adjusted)
        }
        
        searchListTextField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(13.adjusted)
            $0.trailing.equalToSuperview().inset(53.adjusted)
        }
        
        searchMapGraphic.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(68.adjusted)
            $0.trailing.equalToSuperview().inset(67.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(13.adjusted)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(24.adjusted)
        }
        
        clearButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(13.adjusted)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(24.adjusted)
        }
    }
    
    // MARK: ObjFunction
    @objc private func keyboardWillChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrameEnd = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let keyboardY = keyboardFrameEnd.origin.y
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.25
        
        UIView.animate(withDuration: duration) {
            if keyboardY == self.view.frame.height {
                ///키보드가 다시 내려갔을때 그래픽 위치 조정
                self.searchMapGraphic.snp.updateConstraints {
                    $0.centerY.equalToSuperview()
                }
            } else {
                let keyboardHeight = self.view.frame.height - keyboardY
                let remainingHeight = self.view.frame.height - self.searchMapView.frame.maxY
                let centerYOffset = remainingHeight / 2
                
                self.searchMapGraphic.snp.updateConstraints {
                    $0.centerY.equalToSuperview().offset(-centerYOffset + keyboardHeight)
                }
            }
            
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func backToListViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func clearButtonTapped() {
        searchListTextField.text?.removeAll()
        clearButton.isHidden = true
        searchButton.isHidden = false
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        clearButton.isHidden = textField.text?.isEmpty ?? true
        searchButton.isHidden = !clearButton.isHidden
    }
    
    // MARK: - Func
    // MARK: Delegate
    override func setDelegate() {
        searchListTextField.delegate = self
    }
    
    // MARK: Function
    private func setTarget() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        searchListTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        backButton.addTarget(self, action: #selector(backToListViewController), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
    }
    
    private func setNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func clearTabBar() {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func clearTextField() {
        self.searchListTextField.text?.removeAll()
    }
    
    private func setKeyBoard() {
        self.searchListTextField.becomeFirstResponder()
    }
}

// MARK: - extension
// MARK: UITextFieldDelegate
extension SearchListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let search = textField.text, !search.isEmpty {
            let homeViewController = HomeViewController()
            let homeMapViewController = homeViewController.getHomeMapViewController()
            let homeListViewController = homeViewController.getHomeListViewController()
            homeMapViewController.searchText = search
            homeListViewController.searchText = search
            homeViewController.isSearchResult = true
            homeListViewController.isSearchResult = true
            homeViewController.isHomeMap = false
            navigationController?.pushViewController(homeViewController, animated: true)
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        clearButton.isHidden = textField.text?.isEmpty ?? true
        searchButton.isHidden = !clearButton.isHidden
        return true
    }
}
