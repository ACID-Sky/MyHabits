//
//  Constant.swift
//  Habit_Nebesnyi
//
//  Created by Лёха Небесный on 26.01.2023.
//

import UIKit

enum Constants {
    static let colorGray = UIColor(red: 242.0 / 255.0 , green: 242.0 / 255.0 , blue: 247.0 / 255.0 , alpha: 1.0)
    static let colorPurple = UIColor(red: 161.0 / 255.0 , green: 22.0 / 255.0 , blue: 204.0 / 255.0 , alpha: 1.0)
    static let colorBlue = UIColor(red: 41.0 / 255.0 , green: 109.0 / 255.0 , blue: 255.0 / 255.0 , alpha: 1.0)
    static let colorGreen = UIColor(red: 29.0 / 255.0 , green: 179.0 / 255.0 , blue: 34.0 / 255.0 , alpha: 1.0)
    static let colorDarkPurple = UIColor(red: 98.0 / 255.0 , green: 54.0 / 255.0 , blue: 255.0 / 255.0 , alpha: 1.0)
    static let colorOrenge = UIColor(red: 255.0 / 255.0 , green: 159.0 / 255.0 , blue: 79.0 / 255.0 , alpha: 1.0)

    static let title3 = UIFont.systemFont(ofSize: 20, weight: .semibold)
    static let headline = UIFont.systemFont(ofSize: 17, weight: .semibold)
    static let body = UIFont.systemFont(ofSize: 17, weight: .regular)
    static let footnote = UIFont.systemFont(ofSize: 13, weight: .semibold)
    static let footnoteStatus = UIFont.systemFont(ofSize: 13, weight: .semibold)
    static let footnoteLight = UIFont.systemFont(ofSize: 13, weight: .regular)
    static let caption = UIFont.systemFont(ofSize: 12, weight: .regular)

    static let spacing: CGFloat = 8
    static let spacingX2: CGFloat = 16
    static let spacingX3: CGFloat = 32

    static let cornRadius: CGFloat = 8

    static let habitCellID = "HabitCellID"
    static let progressCellID = "ProgressCellID"
    static let defaultCellID = "DefaultCellID"
}
