//
//  Global.swift
//  FootballStatsTestApp
//
//  Created by MacBook on 02.10.2023.
//

import UIKit

enum GlobalConstants {
    enum Images {
        static let leftArrow = "arrow-left"
        static let rightArrow = "arrow-right"
        static let ball = "ball"
        static let chelseaLogo = "ChelseaLogo"
        static let detailVCHeader = "DetailVCHeader"
        static let mainVCHeader = "MainVCHeader"
        static let headerVector = "path125"
        static let dots = "dots"
        static let firstOnboardingBackground = "FirstOnboarding"
        static let secondOnboardingBackground = "SecondOnboarding"
        static let thirdOnboardingBackground = "ThirdOnboarding"
        static let loading = "LoadingSpiral"
        static let preloaderBackground = "Preloader"
        static let redCard = "redCard"
        static let yellowCard = "yellowCard"
        static let replace = "switch"
        static let ellipse = "Ellipse"
    }
    enum Colors {
        static let green = UIColor(red: 0.211, green: 0.667, blue: 0.482, alpha: 1)
        static let greenTransparent = UIColor(red: 0.211, green: 0.667, blue: 0.482, alpha: 0.1)
        static let onboardingGreen = UIColor(red: 0.169, green: 0.542, blue: 0.391, alpha: 1)
        static let whiteTransparent05 = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        static let whiteTransparent02 = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        static let border = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1).cgColor
        static let dark = UIColor(red: 0.184, green: 0.184, blue: 0.184, alpha: 1)
        static let red = UIColor(red: 0.93, green: 0.21, blue: 0.21, alpha: 1)
        static let black = UIColor(red: 0.141, green: 0.141, blue: 0.141, alpha: 1)
        static let blackTransparent = UIColor(red: 0.141, green: 0.141, blue: 0.141, alpha: 0.5)
    }
    enum Fonts {
        static let medium14 = UIFont(name: "SFProDisplay-Medium", size: 14)
        static let condensedMedium16 = UIFont(name: "SFPro-CondensedMedium", size: 16)
        static let medium17 = UIFont(name: "SFProDisplay-Medium", size: 17)
        static let heavy32 = UIFont(name: "SFProDisplay-Heavy", size: 32)
        static let semibold17 = UIFont(name: "SFProDisplay-Semibold", size: 17)
        static let bold12 = UIFont(name: "SFProDisplay-Bold", size: 12)
        static let bold13 = UIFont(name: "SFProDisplay-Bold", size: 13)
        static let bold17 = UIFont(name: "SFProDisplay-Bold", size: 17)
        static let bold34 = UIFont(name: "SFProDisplay-Bold", size: 34)
        static let regular12 = UIFont(name: "SFProText-Regular", size: 12)
        static let regular14 = UIFont(name: "SFProText-Regular", size: 14)
        static let regular16 = UIFont(name: "SFProText-Regular", size: 16)
        static let black48 = UIFont(name: "SFProDisplay-Black", size: 48)
        
    }
}
