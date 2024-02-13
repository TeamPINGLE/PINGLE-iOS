//
//  MyPINGLEViewController.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/6/24.
//

import UIKit

import SnapKit
import Then

final class MyPINGLEViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Component
    private let titleLabel = UILabel()
    private let segmentedControl = MyPINGLESegmentControl(items: [StringLiterals.MyPingle.SegmentControl.soon, StringLiterals.MyPingle.SegmentControl.complete])
    private let separateView = UIView()
    private lazy var pageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal,
        options: nil)
    let soonViewController = SoonViewController()
    let completeViewController = CompleteViewController()
    
    // MARK: Property
    private var dataViewControllers: [UIViewController] {
        [soonViewController,
         completeViewController]
    }
    
    private var currentPage: Int = 0 {
        didSet {
            let direction: UIPageViewController.NavigationDirection = oldValue <= currentPage ? .forward : .reverse
            pageViewController.setViewControllers(
                [dataViewControllers[currentPage]],
                direction: direction,
                animated: true,
                completion: nil
            )
        }
    }
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setSegmentedControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = true
    }
    
    override func setStyle() {
        view.backgroundColor = .grayscaleG11
        titleLabel.do {
            $0.text = StringLiterals.MyPingle.Title.myPingleTitle
            $0.font = .subtitleSubSemi18
            $0.textColor = .white
        }
        
        separateView.do {
            $0.backgroundColor = .grayscaleG09
        }
        
        pageViewController.do {
            $0.setViewControllers([dataViewControllers[0]],
                                  direction: .forward,
                                  animated: true)
        }
    }
    
    override func setLayout() {
        let safeAreaHeight = view.safeAreaInsets.bottom
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 60
        
        view.addSubviews(
            titleLabel,
            segmentedControl,
            separateView,
            pageViewController.view
        )
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(54)
            $0.leading.equalToSuperview().inset(20)
        }
        
        segmentedControl.snp.makeConstraints {
            $0.height.equalTo(41)
            $0.leading.trailing.equalToSuperview().inset(19.5)
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        separateView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
            $0.top.equalTo(segmentedControl.snp.bottom)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(separateView.snp.bottom)
            $0.width.equalToSuperview()
            $0.bottom.equalTo(safeAreaHeight).offset(-tabBarHeight)
        }
    }
    
    // MARK: Custom Function
    override func setDelegate() {
        pageViewController.delegate = self
        pageViewController.dataSource = self
        soonViewController.pushToMemberAction = { meetingId in
            let participantsListViewController = ParticipantsListViewController()
            participantsListViewController.meetingIdentifier = meetingId
            self.navigationController?.pushViewController(participantsListViewController, animated: true)
        }
        completeViewController.pushToCompleteMemberAction = { meetingId in
            let participantsListViewController = ParticipantsListViewController()
            participantsListViewController.meetingIdentifier = meetingId
            self.navigationController?.pushViewController(participantsListViewController, animated: true)
        }
    }
    
    private func setSegmentedControl() {
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.grayscaleG07,
             .font: UIFont.bodyBodyMed16],
            for: .normal
        )
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             .font: UIFont.bodyBodyMed16],
            for: .selected
        )
        segmentedControl.addTarget(
            self,
            action: #selector(changeValue(control:)),
            for: .valueChanged
        )
        segmentedControl.selectedSegmentIndex = 0
        changeValue(control: self.segmentedControl)
    }
    
    // MARK: Objc Function
    @objc private func changeValue(control: UISegmentedControl) {
        currentPage = control.selectedSegmentIndex
    }
}

// MARK: UIPageViewControllerDelegate
extension MyPINGLEViewController: UIPageViewControllerDelegate { }

// MARK: UIPageViewControllerDataSource
extension MyPINGLEViewController: UIPageViewControllerDataSource {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController),
              index - 1 >= 0
        else { return nil }
        return dataViewControllers[index - 1]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController),
              index + 1 < dataViewControllers.count
        else { return nil }
        return dataViewControllers[index + 1]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard let viewController = pageViewController.viewControllers?[0],
              let index = dataViewControllers.firstIndex(of: viewController)
        else { return }
        currentPage = index
        segmentedControl.selectedSegmentIndex = index
    }
}
