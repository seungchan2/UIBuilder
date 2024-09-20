//
//  UIFactory.swift
//  DrivenUI
//
//  Created by MEGA_Mac on 9/20/24.
//

import UIKit

class UIFactory {
    static func createView(for component: ViewComponent) -> UIView {
        switch component.type {
        case "label":
            return configureLabel(with: component)
        case "button":
            return configureButton(with: component)
        case "imageView":
            return configureImageView(with: component)
        default:
            return UIView()
        }
    }

    static func configureLabel(with component: ViewComponent) -> UILabel {
        let label = UILabel()
        label.text = component.text
        label.font = UIFont.systemFont(ofSize: component.font?.size ?? 16, weight: convertWeight(component.font?.weight ?? "regular"))
        label.textColor = UIColor(hex: component.textColor ?? "#000000")
        return label
    }

    static func configureButton(with component: ViewComponent) -> UIButton {
        let button = UIButton()
        button.setTitle(component.title, for: .normal)
        button.setTitleColor(UIColor(hex: component.textColor ?? "#FFFFFF"), for: .normal)
        button.backgroundColor = UIColor(hex: component.backgroundColor ?? "#007BFF")
        button.titleLabel?.font = UIFont.systemFont(ofSize: component.font?.size ?? 16, weight: convertWeight(component.font?.weight ?? "medium"))
        return button
    }

    static func configureImageView(with component: ViewComponent) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: component.image ?? "")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    static func convertWeight(_ weight: String) -> UIFont.Weight {
        switch weight {
        case "bold": return .bold
        case "medium": return .medium
        default: return .regular
        }
    }
}
