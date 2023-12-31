//
//  PlaceSelectionViewController.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/7/24.
//

import UIKit

import SnapKit
import Then

class PlaceSelectionViewController: BaseViewController {
    
    // MARK: - Variables
    var selectedPlace: IndexPath?
    
    // MARK: Property
    private let backButton = UIButton()
    private let progressBar4 = UIImageView()
    private let placeSelectionTitle = UILabel()
    private let searchPlaceView = SearchPlaceView()
    private let nextButton = PINGLECTAButton(title: StringLiterals.CTAButton.buttonTitle, buttonColor: .grayscaleG08, textColor: .grayscaleG10)
    private let exitLabel = UILabel()
    private let exitButton = MeetingExitButton()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTarget()
        setRegister()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: UI
    override func setStyle() {
        self.view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        self.backButton.do {
            $0.setImage(ImageLiterals.Metting.Icon.icBack, for: .normal)
        }
        
        progressBar4.do {
            $0.image = ImageLiterals.Metting.ProgressBar.progressBarImage4
            $0.contentMode = .scaleAspectFill
        }
        
        placeSelectionTitle.do {
            $0.text = StringLiterals.Meeting.SearhPlace.searchPlaceTitle
            $0.font = .titleTitleSemi24
            $0.numberOfLines = 0
            $0.textColor = .white
        }
        
        exitLabel.do {
            $0.text = StringLiterals.Meeting.MeetingCategory.ExitButton.exitLabel
            $0.font = .captionCapSemi12
            $0.textColor = .grayscaleG06
        }
    }
    
    override func setLayout() {
        self.view.addSubviews(backButton, progressBar4, placeSelectionTitle, searchPlaceView, nextButton, exitLabel, exitButton)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(16.adjusted)
            $0.leading.equalToSuperview().inset(18.adjusted)
            $0.trailing.equalToSuperview().inset(333.adjusted)
        }
        
        progressBar4.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(60.adjusted)
            $0.height.equalTo(19)
            $0.leading.trailing.equalToSuperview()
        }
        
        placeSelectionTitle.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(107.adjusted)
            $0.leading.equalToSuperview().inset(26.adjusted)
        }
        
        searchPlaceView.snp.makeConstraints {
            $0.top.equalTo(self.placeSelectionTitle.snp.bottom).offset(24.adjusted)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(130.adjusted)
        }

        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.snp.bottom).inset(54.adjusted)
            $0.leading.equalToSuperview().inset(16.adjusted)
        }
        
        exitLabel.snp.makeConstraints {
            $0.top.equalTo(nextButton.snp.bottom).offset(14.adjusted)
            $0.leading.equalToSuperview().inset(118.adjusted)
            $0.trailing.equalToSuperview().inset(153.adjusted)
        }
        
        exitButton.snp.makeConstraints {
            $0.top.equalTo(nextButton.snp.bottom).offset(14.adjusted)
            $0.leading.equalTo(exitLabel.snp.trailing).offset(4.adjusted)
            $0.centerY.equalTo(exitLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(117.adjusted)
        }
    }
    
    // MARK: - Func
    // MARK: Delegate
    override func setDelegate() {
        self.searchPlaceView.searchTextField.delegate = self
        self.searchPlaceView.searchPlaceCollectionView.delegate = self
        self.searchPlaceView.searchPlaceCollectionView.dataSource = self
    }
    
    // MARK: Register
    func setRegister() {
        self.searchPlaceView.searchPlaceCollectionView.register(PlaceSelectionCollectionViewCell.self,
                                                                  forCellWithReuseIdentifier: PlaceSelectionCollectionViewCell.identifier)
    }
    
    // MARK: Navigation Function
    private func setNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: Target Function
    private func setTarget() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        searchPlaceView.searchTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        searchPlaceView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped),
                             for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func searchButtonTapped() {
        self.view.endEditing(true)
    }
    
    @objc func nextButtonTapped() {
        print("다음 화면 연결 !")
        }
    
    @objc func exitButtonTapped() {
        print("여기다가 나가기 모달 띄우기")
    }
}

// MARK: - extension
// MARK: UITextFieldDelegate
extension PlaceSelectionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Objc Function
    @objc func textFieldDidChange(_ textField: UITextField) {
        print("Text changed: \(textField.text ?? "")")
    }
}

// MARK: UICollectionViewDelegate
extension PlaceSelectionViewController: UICollectionViewDelegate {}

// MARK: UICollectionViewDataSource
extension PlaceSelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceSelectionCollectionViewCell.identifier,
                                                            for: indexPath) as? PlaceSelectionCollectionViewCell else {return UICollectionViewCell()}
        if indexPath == selectedPlace {
            cell.changeSelectedImage()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedPlace == indexPath {
            selectedPlace = nil
            nextButton.disabledButton()
        } else {
            selectedPlace = indexPath
            nextButton.activateButton()
        }
        searchPlaceView.searchPlaceCollectionView.reloadData()
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension PlaceSelectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 325, height: 106)
    }
}
