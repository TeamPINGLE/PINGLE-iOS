//
//  ImageLiterals.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 12/27/23.
//

import UIKit

enum ImageLiterals {
    
    // 필요한 enum을 만들어서 사용해주세요
    // 사용예시: imageView.image = ImageLiterals.OnBoarding.imgExample
    
    enum OnBoarding {
        static var imgExample: UIImage { .load(named: "예시이미지이름")}
    }
    
    enum TabBar {
        static var imgHome: UIImage { .load(named: "imgHome")}
        static var imgHomeSelected: UIImage { .load(named: "imgHomeSelected")}
        static var imgAddPingle: UIImage { .load(named: "imgAddPingle")}
        static var imgAddPingleSelected: UIImage { .load(named: "imgAddPingleSelected")}
        static var imgSetting: UIImage { .load(named: "imgSetting")}
        static var imgSettingSelected: UIImage { .load(named: "imgSettingSelected")}
    }
    
    enum Home {
        enum Chips {
            static var btnMultiChip: UIImage { .load(named: "btnMultiChip")}
            static var btnMultiChipSelected: UIImage { .load(named: "btnMultiChipSelected")}
            static var btnOtherChip: UIImage { .load(named: "btnOtherChip")}
            static var btnOthersChipSelected: UIImage { .load(named: "btnOthersChipSelected")}
            static var btnPlayChip: UIImage { .load(named: "btnPlayChip")}
            static var btnPlayChipSelected: UIImage { .load(named: "btnPlayChipSelected")}
            static var btnStudyChip: UIImage { .load(named: "btnStudyChip")}
            static var btnStudyChipSelected: UIImage { .load(named: "btnStudyChipSelected")}
        }
        
        enum Button {
            static var icMapHere: UIImage { .load(named: "icMapHere")}
            static var icMapList: UIImage { .load(named: "icMapList")}
            static var icMapMap: UIImage { .load(named: "icMapMap")}
        }
    }
}

extension UIImage {
    static func load(named imageName: String) -> UIImage {
        guard let image = UIImage(named: imageName, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        return image
    }
    
    func resize(to size: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
        return image
    }
}
