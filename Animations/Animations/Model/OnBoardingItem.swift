//
//  OnBoardingItem.swift
//  Animations
//
//  Created by joshua on 12/19/22.
//

import SwiftUI
import Lottie 

//Mark OnBoardi Item Model

struct OnBoardingItem: Identifiable, Equatable{
    var id: UUID = .init()
    var title : String
    var subTitle : String
    var lottieView : LottieAnimationView = .init()
}
