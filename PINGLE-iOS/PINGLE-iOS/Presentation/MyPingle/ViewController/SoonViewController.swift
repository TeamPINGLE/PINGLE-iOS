//
//  SoonViewController.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/17/24.
//

import UIKit

import SnapKit
import Then

final class SoonViewController: BaseViewController {
    
    lazy var myPINGLECollectionView = UICollectionView(frame: .zero, collectionViewLayout: myPINGLEFlowLayout)
    let myPINGLEFlowLayout = UICollectionViewFlowLayout()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
    }
    
    override func setDelegate() {
        self.myPINGLECollectionView.delegate = self
        self.myPINGLECollectionView.dataSource = self
    }
    
    private func setCollectionView() {
        self.myPINGLECollectionView.register(MyPINGLECollectionViewCell.self, forCellWithReuseIdentifier: MyPINGLECollectionViewCell.identifier)
    }
    
    override func setStyle() {
        view.backgroundColor = .grayscaleG11
        
        myPINGLEFlowLayout.do {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 16
            $0.itemSize = CGSize(width: UIScreen.main.bounds.width - 48, height: 229)
        }
        
        myPINGLECollectionView.do {
            $0.backgroundColor = .grayscaleG11
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 40, right: 0)

        }
    }
    
    override func setLayout() {
        let safeAreaHeight = view.safeAreaInsets.bottom
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 60
        
        view.addSubview(myPINGLECollectionView)
        
        myPINGLECollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension SoonViewController: UICollectionViewDelegate { }

extension SoonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPINGLECollectionViewCell.identifier, for: indexPath) as? MyPINGLECollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}
