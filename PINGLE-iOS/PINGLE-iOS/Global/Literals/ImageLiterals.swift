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
        static var imgApplelogo: UIImage { .load(named: "imgApplelogo")}
        static var imgSample: UIImage { .load(named: "imgSample")}
    }
    
    enum TabBar {
        static var imgHome: UIImage { .load(named: "imgHome")}
        static var imgHomeSelected: UIImage { .load(named: "imgHomeSelected")}
        static var imgAddPingle: UIImage { .load(named: "imgAddPingle")}
        static var imgAddPingleSelected: UIImage { .load(named: "imgAddPingleSelected")}
        static var imgSetting: UIImage { .load(named: "imgSetting")}
        static var imgSettingSelected: UIImage { .load(named: "imgSettingSelected")}
    }
    
    enum Metting {
        enum Icon {
            static var icBack: UIImage { .load(named: "icBackButton")}
        }
        
        enum Guide {
            static var imgExitButton: UIImage { .load(named: "imgExitButton")}
            static var imgMettingGraphic: UIImage { .load(named: "imgMettingGraphic")}
        }
        
        enum Category {
            static var categoryPlayImage: UIImage { .load(named: "imgSample")}
            static var categoryStudyImage: UIImage { .load(named: "imgSample")}
            static var categoryMultiImage: UIImage { .load(named: "imgSample")}
            static var categoryOthersImage: UIImage { .load(named: "imgSample")}
        }
        
        enum ProgressBar {
            static var progressBarImage1: UIImage { .load(named: "imgProgressBar1")}
            static var progressBarImage2: UIImage { .load(named: "imgProgressBar2")}
            static var progressBarImage3: UIImage { .load(named: "imgProgressBar3")}
            static var progressBarImage4: UIImage { .load(named: "imgProgressBar4")}
            static var progressBarImage5: UIImage { .load(named: "imgProgressBar5")}
            static var progressBarImage6: UIImage { .load(named: "imgProgressBar6")}
            static var progressBarImage7: UIImage { .load(named: "imgProgressBar7")}
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
