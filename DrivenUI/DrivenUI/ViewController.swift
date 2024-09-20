//
//  ViewController.swift
//  DrivenUI
//
//  Created by MEGA_Mac on 9/20/24.
//

import Combine
import UIKit

import SnapKit


final class ViewController: UIViewController {
    private var jsonService: JSONServiceProtocol
       private var previousView: UIView?

       init(jsonService: JSONServiceProtocol) {
           self.jsonService = jsonService
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

       override func viewDidLoad() {
           super.viewDidLoad()
           view.backgroundColor = .white

           loadLocalJSONDataAndSetupUI()
       }

       func loadLocalJSONDataAndSetupUI() {
           guard let data = jsonService.loadJSONData() else {
               print("Failed to load JSON data")
               return
           }
           
           setupDynamicUI(with: data)
       }

       func setupDynamicUI(with data: UIData) {
           for viewComponent in data.views {
               let newView = UIFactory.createView(for: viewComponent)
               view.addSubview(newView)
               applyConstraints(for: newView, with: viewComponent.constraints)
               previousView = newView
           }
       }

       func applyConstraints(for view: UIView, with constraints: Constraints) {
           view.snp.makeConstraints { make in
               if let top = constraints.top {
                   if top.toItem == "superview" {
                       make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(top.constant)
                   } else if top.toItem == "previousView", let previousView = previousView {
                       make.top.equalTo(previousView.snp.bottom).offset(top.constant)
                   }
               }
               if let leading = constraints.leading {
                   make.leading.equalToSuperview().offset(leading.constant)
               }
               if let trailing = constraints.trailing {
                   make.trailing.equalToSuperview().offset(trailing.constant)
               }
               if let width = constraints.width {
                   make.width.equalTo(width.constant)
               }
               if let height = constraints.height {
                   make.height.equalTo(height.constant)
               }
           }
       }
  
}

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        let r = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let g = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let b = CGFloat(rgb & 0xFF) / 255.0
        let a = hexSanitized.count == 8 ? CGFloat((rgb >> 24) & 0xFF) / 255.0 : 1.0
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
