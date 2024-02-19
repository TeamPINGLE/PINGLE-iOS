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
                       manualTitle: "우리의 모임, PINGLE",
                       manualSubTitle: "원하는 장소에서 사람들과 갖는\n나만의 모임을 뜻해요"),
        ManualDummyDTO(manualImage: UIImage(resource: .imgManual2),
                       manualTitle: "속해있는 단체를 선택하거나\n직접 개설해봐요!",
                       manualSubTitle: nil),
        ManualDummyDTO(manualImage: UIImage(resource: .imgManual3),
                       manualTitle: "내 주변에서 열리는 핑글을\n간편하게 찾고 참여해봐요!",
                       manualSubTitle: nil),
        ManualDummyDTO(manualImage: UIImage(resource: .imgManual4),
                       manualTitle: "원하는 테마로 간편하게\n핑글을 개최할 수 있어요!",
                       manualSubTitle: nil)
    ]
    
    // MARK: Property
    private let skipButton = UIButton()
    private let manualCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let manualPageControl = UIPageControl()
    private let nextCTAButton = PINGLECTAButton(
        title: StringLiterals.CTAButton.buttonTitle,
        buttonColor: .grayscaleG01,
        textColor: .black
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRegister()
        setTarget()
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
    }
    
    override func setLayout() {
        view.addSubviews(manualCollectionView,
                         manualPageControl,
                         nextCTAButton)
        
        manualCollectionView.snp.makeConstraints {
            let topOffest = (self.safeAreaHeight - 623) / 2
            $0.top.equalToSuperview().offset(topOffest)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(nextCTAButton.snp.top).offset(-48)
        }
        
        manualPageControl.snp.makeConstraints {
            $0.bottom.equalTo(nextCTAButton.snp.top).offset(-40)
            $0.centerX.equalToSuperview()
        }
        
        nextCTAButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(69)
            $0.centerX.equalToSuperview()
        }
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
    }
    
    // MARK: objc Function
    /// pageControl을 통한 Cell 이동함수
    @objc func pageControlDidChange(sender: UIPageControl) {
        manualCollectionView.isPagingEnabled = false
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        manualCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        manualCollectionView.isPagingEnabled = true
    }
}

// MARK: UICollectionViewDelegate
extension ManualViewController: UICollectionViewDelegate {
}

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
