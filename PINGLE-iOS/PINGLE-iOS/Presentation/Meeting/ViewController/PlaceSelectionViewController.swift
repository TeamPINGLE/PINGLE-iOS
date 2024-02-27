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
    var searchPlaceResponseDTO: [SearchPlaceResponseDTO] = []
    
    // MARK: Property
    private let backButton = UIButton()
    private let progressBar4 = UIImageView()
    private let placeSelectionTitle = UILabel()
    private let searchPlaceView = SearchPlaceView()
    private let nextButton = PINGLECTAButton(title: StringLiterals.CTAButton.buttonTitle, buttonColor: .grayscaleG08, textColor: .grayscaleG10)
    private let exitLabel = UILabel()
    private let exitButton = MeetingExitButton()
    private let exitModal = ExitModalView()
    private let dimmedView = UIView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTarget()
        setRegister()
        setUpLabel()
        setUpDimmedView()
        hideKeyboardWhenTappedAround()
        setGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setNavigation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setNavigation()
    }
    
    // MARK: UI
    override func setStyle() {
        self.view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        self.backButton.do {
            $0.setImage(UIImage(resource: .icArrowLeft), for: .normal)
        }
        
        progressBar4.do {
            $0.image = UIImage(resource: .imgProgressBar4)
            $0.contentMode = .scaleAspectFill
        }
        
        placeSelectionTitle.do {
            $0.text = StringLiterals.Meeting.SearhPlace.searchPlaceTitle
            $0.setLineSpacing(spacing: 4)
            $0.textAlignment = .left
            $0.font = .titleTitleSemi24
            $0.numberOfLines = 0
            $0.textColor = .white
        }
        
        exitLabel.do {
            $0.text = StringLiterals.Meeting.MeetingCategory.ExitButton.exitLabel
            $0.font = .captionCapSemi12
            $0.textColor = .grayscaleG06
        }
        
        exitModal.do {
            $0.isHidden = true
        }
        
        dimmedView.do {
            $0.backgroundColor = .grayscaleG11.withAlphaComponent(0.7)
            $0.isHidden = true
        }
    }
    
    override func setLayout() {
        self.view.addSubviews(backButton,
                              progressBar4,
                              placeSelectionTitle,
                              searchPlaceView,
                              nextButton,
                              exitLabel,
                              exitButton,
                              dimmedView)
        
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
            $0.bottom.equalTo(nextButton.snp.top).offset(-15.adjusted)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(exitLabel.snp.top).offset(-14.adjusted)
            $0.leading.equalToSuperview().inset(16.adjusted)
        }
        
        exitLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-23.adjusted)
            $0.leading.equalToSuperview().inset(118.adjusted)
            $0.trailing.equalToSuperview().inset(153.adjusted)
        }
        
        exitButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-23.adjusted)
            $0.leading.equalTo(exitLabel.snp.trailing).offset(4.adjusted)
            $0.centerY.equalTo(exitLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(117.adjusted)
        }
        
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
    
    private func setUpLabel() {
        searchPlaceView.isHiddenResultLabel(isEnabled: true)
    }
    
    // MARK: Target Function
    private func setTarget() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        searchPlaceView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        searchPlaceView.clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        searchPlaceView.searchTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        exitModal.exitButton.addTarget(self, action: #selector(exitModalExitButtonTapped), for: .touchUpInside)
        exitModal.keepMaking.addTarget(self, action: #selector(exitModalKeepButtonTapped), for: .touchUpInside)
    }
    
    private func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped))
        dimmedView.addGestureRecognizer(tapGesture)
        dimmedView.isUserInteractionEnabled = true
    }
    
    private func setUpDimmedView() {
        dimmedView.isHidden = true
    }
    
    // MARK: Objc Function
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func searchButtonTapped() {
        if let search = searchPlaceView.searchTextField.text {
            if !search.isEmpty {
                searchPlace(data: SearchPlaceRequestQueryDTO(search: search))
            }
            self.view.endEditing(true)
        }
    }
    
    @objc func clearButtonTapped() {
        searchPlaceView.searchTextField.text?.removeAll()
        searchPlaceView.clearButton.isHidden = true
        searchPlaceView.searchButton.isHidden = false
    }
    
    @objc func nextButtonTapped() {
        guard let selectedPlaceRow = selectedPlace?.row else { return }
        MeetingManager.shared.address = searchPlaceResponseDTO[selectedPlaceRow].address
        MeetingManager.shared.roadAddress = searchPlaceResponseDTO[selectedPlaceRow].roadAddress
        MeetingManager.shared.location = searchPlaceResponseDTO[selectedPlaceRow].location
        MeetingManager.shared.x = searchPlaceResponseDTO[selectedPlaceRow].x
        MeetingManager.shared.y = searchPlaceResponseDTO[selectedPlaceRow].y
        let recruitmentViewController = RecruitmentViewController()
        navigationController?.pushViewController(recruitmentViewController, animated: true)
    }
    
    @objc func exitButtonTapped() {
        self.view.addSubview(exitModal)
        exitModal.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        exitModal.isHidden = false
        dimmedView.isHidden = false
    }
    
    @objc func exitModalKeepButtonTapped() {
        exitModal.isHidden = true
        exitModal.removeFromSuperview()
        dimmedView.isHidden = true
    }
    
    @objc func exitModalExitButtonTapped() {
        exitModal.isHidden = true
        dimmedView.isHidden = true
        self.dismiss(animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        searchPlaceView.clearButton.isHidden = textField.text?.isEmpty ?? true
        searchPlaceView.searchButton.isHidden = !searchPlaceView.clearButton.isHidden
    }
    
    @objc func dimmedViewTapped() {
        hideDimmedViewWhenTapped()
    }
    
    // MARK: Network Function
    func searchPlace(data: SearchPlaceRequestQueryDTO) {
        NetworkService.shared.meetingService.searchPlace(queryDTO: data) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                if data.isEmpty {
                    searchPlaceView.isHiddenResultLabel(isEnabled: false)
                } else {
                    searchPlaceView.isHiddenResultLabel(isEnabled: true)
                }
                self.searchPlaceResponseDTO = data
                selectedPlace = nil
                nextButton.disabledButton()
                self.searchPlaceView.searchPlaceCollectionView.reloadData()
            default:
                return
            }
        }
    }
    
    private func hideDimmedViewWhenTapped() {
        UIView.animate(withDuration: 0.5, animations: {
            self.dimmedView.isHidden = true
        })
        exitModal.isHidden = true
    }
}

// MARK: - extension
// MARK: UITextFieldDelegate
extension PlaceSelectionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let search = textField.text {
            if search.isEmpty {
                searchPlaceResponseDTO = []
                searchPlaceView.searchPlaceCollectionView.reloadData()
                searchPlaceView.isHiddenResultLabel(isEnabled: false)
            } else {
                searchPlace(data: SearchPlaceRequestQueryDTO(search: search))
            }
        }
        selectedPlace = nil
        nextButton.disabledButton()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        searchPlaceView.clearButton.isHidden = textField.text?.isEmpty ?? true
        searchPlaceView.searchButton.isHidden = !searchPlaceView.clearButton.isHidden
        return true
    }
}

// MARK: UICollectionViewDelegate
extension PlaceSelectionViewController: UICollectionViewDelegate {}

// MARK: UICollectionViewDataSource
extension PlaceSelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchPlaceResponseDTO.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceSelectionCollectionViewCell.identifier,
                                                            for: indexPath) as? PlaceSelectionCollectionViewCell else {return UICollectionViewCell()}
        cell.bindData(data: searchPlaceResponseDTO[indexPath.row])
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
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let labelHeight = calculateDynamicHeight(placeNameText: searchPlaceResponseDTO[indexPath.row].location, placeAddresText: searchPlaceResponseDTO[indexPath.row].address)
        return CGSize(width: 325.adjusted, height: labelHeight + 67)
    }
    
    func calculateDynamicHeight(placeNameText: String, placeAddresText: String) -> CGFloat {
        let placeName = UILabel()
        placeName.text = placeNameText
        placeName.numberOfLines = 2
        placeName.preferredMaxLayoutWidth = 252.adjusted
        placeName.font = .subtitleSubSemi16
        
        let placeAddress = UILabel()
        placeAddress.text = placeAddresText
        placeAddress.numberOfLines = 2
        placeAddress.preferredMaxLayoutWidth = 252.adjusted
        placeAddress.font = .captionCapMed12
        
        let placeNameSize = placeName.sizeThatFits(CGSize(width: 252.adjusted, height: CGFloat.greatestFiniteMagnitude))
        let placeAddressSize = placeAddress.sizeThatFits(CGSize(width: 252.adjusted, height: CGFloat.greatestFiniteMagnitude))
        
        return placeNameSize.height + placeAddressSize.height
    }
    
}
