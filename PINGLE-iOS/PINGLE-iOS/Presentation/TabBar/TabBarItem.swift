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
        case .home:            return ImageLiterals.TabBar.imgHome
        case .recommend:       return ImageLiterals.TabBar.imgHome
        case .addPingle:       return ImageLiterals.TabBar.imgAddPingle
        case .myPingle:        return ImageLiterals.TabBar.imgHome
        case .setting:         return ImageLiterals.TabBar.imgSetting
        }
    }
    
    var selectedIcon: UIImage? {
        switch self {
        case .home:            return ImageLiterals.TabBar.imgHomeSelected.withRenderingMode(.alwaysOriginal)
        case .recommend:       return ImageLiterals.TabBar.imgHomeSelected.withRenderingMode(.alwaysOriginal)
        case .addPingle:       return ImageLiterals.TabBar.imgAddPingleSelected.withRenderingMode(.alwaysOriginal)
        case .myPingle:        return ImageLiterals.TabBar.imgHomeSelected.withRenderingMode(.alwaysOriginal)
        case .setting:         return ImageLiterals.TabBar.imgSettingSelected.withRenderingMode(.alwaysOriginal)
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
