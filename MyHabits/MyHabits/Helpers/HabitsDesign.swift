//
//  Design.swift
//  MyHabits
//
//  Created by Александр Глазков on 18.12.2020.
//

import UIKit

enum DesignFontStyle {
    case Title
    case Headline
    case Body
    case Footnote1
    case Footnote2
    case Caption
}

enum DesignColorStyle {
    case Gray
    case LightGray
    case White
    case Magenta
    case Blue
    case Green
    case DarkBlue
    case Orange
}

func getFontStyle(style: DesignFontStyle) -> UIFont {

    switch style {
        case .Title:
            return UIFont.systemFont(ofSize: 20, weight: .semibold)
        case .Headline:
            return UIFont.systemFont(ofSize: 17, weight: .semibold)
        case .Body:
            return UIFont.systemFont(ofSize: 17, weight: .regular)
        case .Footnote1:
            return UIFont.systemFont(ofSize: 13, weight: .semibold)
        case .Footnote2:
            return UIFont.systemFont(ofSize: 13, weight: .regular)
        case .Caption:
            return UIFont.systemFont(ofSize: 12, weight: .regular)
    }
}

func getColorStyle(style: DesignColorStyle) -> UIColor {
    switch style {
        case .Gray:
            return UIColor.systemGray
        case .LightGray:
            return UIColor.systemGray2
        case .White:
            return getColor(red: 242, green: 242, blue: 247)
        case .Magenta:
            return getColor(red: 161, green: 22, blue: 204)
        case .Blue:
            return getColor(red: 41, green: 109, blue: 255)
        case .Green:
            return getColor(red: 29, green: 179, blue: 34)
        case .DarkBlue:
            return getColor(red: 98, green: 54, blue: 255)
        case .Orange:
            return getColor(red: 255, green: 159, blue: 79)
    }
}

private func getColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
    let colorMax: CGFloat = 255
    return UIColor(red: red/colorMax, green: green/colorMax, blue: blue/colorMax, alpha: alpha)
}
