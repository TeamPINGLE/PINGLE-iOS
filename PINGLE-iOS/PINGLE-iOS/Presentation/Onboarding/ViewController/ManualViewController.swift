//
//  ManualViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 2/13/24.
//

import UIKit

import SnapKit
import Then

final class ManualViewController: BaseViewController {
    
    // MARK: Dummy Data
    let manualDummyData: [ManualDummyDTO] = [
        ManualDummyDTO(manualImage: UIImage(resource: .imgManual1),
                       manualTitle: StringLiterals.Onboarding.ExplainTitle.manualTitle1,
                       manualSubTitle: StringLiterals.Onboarding.ExplainTitle.manualSubTitle1),
        ManualDummyDTO(manualImage: UIImage(resource: .imgManual2),
                       manualTitle: StringLiterals.Onboarding.ExplainTitle.manualTitle2,
                       manualSubTitle: nil),
        ManualDummyDTO(manualImage: UIImage(resource: .imgManual3),
                       manualTitle: StringLiterals.Onboarding.ExplainTitle.manualTitle3,
                       manualSubTitle: nil),
        ManualDummyDTO(manualImage: UIImage(resource: .imgManual4),
                       manualTitle: StringLiterals.Onboarding.ExplainTitle.manualTitle4,
                       manualSubTitle: nil)
    ]
    
    // MARK: Property
    private let skipButton = UIButton()
    private let manualCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let manualPageControl = UIPageControl()
    private let bottomCTAButton = PINGLECTAButton(
        title: StringLiterals.CTAButton.buttonTitle,
        buttonColor: .grayscaleG01,
        textColor: .black
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setRegister()
        setTarget()
        changeButton()
    }
    
    // MARK: UI
    override func setStyle() {
        view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        manualCollectionView.do {
            $0.backgroundColor = .grayscaleG11
            $0.showsHorizontalScrollIndicator = false
            $0.isPagingEnabled = true
            if let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
                $0.collectionViewLayout = layout
            }
        }
        
        manualPageControl.do {
            $0.currentPage = 0
            $0.numberOfPages = manualDummyData.count
        }
        
        skipButton.do {
            $0.setTitle(StringLiterals.Onboarding.ButtonTitle.skipButtonTitle, for: .normal)
            $0.titleLabel?.font = .bodyBodyMed14
            $0.titleLabel?.textColor = .white
        }
    }
    
    override func setLayout() {
        view.addSubviews(manualCollectionView,
                         skipButton,
                         manualPageControl,
                         bottomCTAButton)
        
        manualCollectionView.snp.makeConstraints {
            let topOffest = (self.safeAreaHeight - 623) / 2
            $0.top.equalToSuperview().offset(topOffest)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomCTAButton.snp.top).offset(-48)
        }
        
        skipButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(13)
            $0.trailing.equalToSuperview().inset(22)
        }
        
        manualPageControl.snp.makeConstraints {
            $0.centerY.equalTo(bottomCTAButton.snp.top).offset(-44)
            $0.centerX.equalToSuperview()
        }
        
        bottomCTAButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(69)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: Navigation Function
    private func setNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: Delegate
    override func setDelegate() {
        manualCollectionView.delegate = self
        manualCollectionView.dataSource = self
    }
    
    // MARK: Register
    func setRegister() {
        manualCollectionView.register(ManualCollectionViewCell.self, 
                                      forCellWithReuseIdentifier: ManualCollectionViewCell.identifier)
    }
    
    // MARK: Target Function
    private func setTarget() {
        manualPageControl.addTarget(self,
                                    action: #selector(pageControlDidChange),
                                    for: .valueChanged)
        bottomCTAButton.addTarget(self,
                                  action: #selector(bottomCTAButtonTapped),
                                  for: .touchUpInside)
        skipButton.addTarget(self,
                             action: #selector(skipButtonTapped),
                             for: .touchUpInside)
    }
    
    // MARK: objc Function
    /// pageControl을 통한 Cell 이동함수
    @objc func pageControlDidChange(sender: UIPageControl) {
        manualCollectionView.isPagingEnabled = false
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        manualCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        manualCollectionView.isPagingEnabled = true
    }
    
    /// 마지막 페이지인 경우 로그인 화면으로 이동, 아닐 경우 다음페이지 이동
    @objc func bottomCTAButtonTapped() {
        if manualPageControl.currentPage == 3 {
            changeRootViewController()
        } else {
            manualPageControl.currentPage += 1
            manualCollectionView.isPagingEnabled = false
            let indexPath = IndexPath(item: manualPageControl.currentPage, section: 0)
            manualCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            manualCollectionView.isPagingEnabled = true
        }
    }
    
    @objc func skipButtonTapped() {
        changeRootViewController()
    }
    
    // MARK: ChangeRootViewController
    func changeRootViewController() {
        UserDefaults.standard.set(true, forKey: "isFirstTime")
        let loginViewController = LoginViewController()
        loginViewController.view.alpha = 0.0

        self.view.window?.rootViewController = loginViewController
        self.view.window?.makeKeyAndVisible()

        UIView.animate(withDuration: 0.5) {
            loginViewController.view.alpha = 1.0
        }
    }
    
    // MARK: SetButton
    func changeButton() {
        self.bottomCTAButton.activateButton()
    }
}

// MARK: UICollectionViewDelegate
extension ManualViewController: UICollectionViewDelegate {}

// MARK: UICollectionViewDataSource
extension ManualViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manualDummyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ManualCollectionViewCell.identifier,
            for: indexPath
        ) as? ManualCollectionViewCell else { return UICollectionViewCell() }
        
        cell.bindData(data: manualDummyData[indexPath.row])
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ManualViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return manualCollectionView.bounds.size
    }
}

// MARK: UIScrollViewDelegate
extension ManualViewController: UIScrollViewDelegate {
    /// 스크롤을 통한 cell 이동시 pageControl의 현재 페이지 나타내는 함수
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        manualPageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
    }
}
