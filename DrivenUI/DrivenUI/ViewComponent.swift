//
//  ViewComponent.swift
//  DrivenUI
//
//  Created by MEGA_Mac on 9/20/24.
//

import Foundation

struct ViewComponent: Codable {
    let type: String
    let text: String?
    let image: String?
    let title: String?
    let font: FontAttributes?
    let textColor: String?
    let backgroundColor: String?
    let constraints: Constraints
}

struct FontAttributes: Codable {
    let size: CGFloat
    let weight: String
}

struct Constraints: Codable {
    let top: ConstraintRelation?
    let leading: ConstraintRelation?
    let trailing: ConstraintRelation?
    let centerX: ConstraintRelation?
    let width: ConstraintRelation?
    let height: ConstraintRelation?
}

struct ConstraintRelation: Codable {
    let relation: String
    let toItem: String
    let constant: CGFloat
}

struct UIData: Codable {
    let title: String
    let views: [ViewComponent]
}
