//
//  TabBarItem.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/1/24.
//

import UIKit

enum TabBarItem: Int, CaseIterable {
    case home
    case recommend
    case addPingle
    case myPingle
    case setting
}

extension TabBarItem {
    var title: String {
        switch self {
        case .home:            return StringLiterals.TabBar.ItemTitle.home
        case .recommend:       return StringLiterals.TabBar.ItemTitle.recommend
        case .addPingle:       return StringLiterals.TabBar.ItemTitle.addPingle
        case .myPingle:        return StringLiterals.TabBar.ItemTitle.myPingle
        case .setting:         return StringLiterals.TabBar.ItemTitle.setting
        }
    }
}

extension TabBarItem {
    var Icon: UIImage? {
        switch self {
        case .home:            return UIImage(resource: .icHome)
        case .recommend:       return UIImage(resource: .icRanking)
        case .addPingle:       return UIImage(resource: .icMeeting)
        case .myPingle:        return UIImage(resource: .icMyPingle)
        case .setting:         return UIImage(resource: .icMore)
        }
    }
    
    var selectedIcon: UIImage? {
        switch self {
        case .home:            return UIImage(resource: .icHomeSelected).withRenderingMode(.alwaysOriginal)
        case .recommend:       return UIImage(resource: .icRankingSelected).withRenderingMode(.alwaysOriginal)
        case .addPingle:       return UIImage(resource: .icMeetingSelected).withRenderingMode(.alwaysOriginal)
        case .myPingle:        return UIImage(resource: .icMyPingleSelected).withRenderingMode(.alwaysOriginal)
        case .setting:         return UIImage(resource: .icMoreSelected).withRenderingMode(.alwaysOriginal)
        }
    }
}

extension TabBarItem {
    public func asTabBarItem() -> UITabBarItem {
        let tabBarItem = UITabBarItem(
            title: title,
            image: Icon,
            selectedImage: selectedIcon
        )
        
        tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -5, right: 0)
        
        return tabBarItem
    }
}
