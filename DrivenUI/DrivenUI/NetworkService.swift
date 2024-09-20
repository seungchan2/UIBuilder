//
//  NetworkService.swift
//  DrivenUI
//
//  Created by MEGA_Mac on 9/20/24.
//

import Combine
import UIKit

protocol JSONServiceProtocol {
    func loadJSONData() -> UIData?
}

final class JSONService: JSONServiceProtocol {
    func loadJSONData() -> UIData? {
        let jsonString = """
        {
          "title": "홈 화면",
          "views": [
            {
              "type": "label",
              "text": "출석하기!",
              "font": {
                "size": 24,
                "weight": "bold"
              },
              "textColor": "#000000",
              "constraints": {
                "top": {
                  "relation": "equal",
                  "toItem": "superview",
                  "constant": 100
                },
                "leading": {
                  "relation": "equal",
                  "toItem": "superview",
                  "constant": 20
                },
                "trailing": {
                  "relation": "equal",
                  "toItem": "superview",
                  "constant": -20
                }
              }
            },
            {
              "type": "button",
              "title": "시작하기",
              "titleColor": "#FFFFFF",
              "backgroundColor": "#007BFF",
              "font": {
                "size": 18,
                "weight": "medium"
              },
              "constraints": {
                "top": {
                  "relation": "equal",
                  "toItem": "previousView",
                  "constant": 20
                },
                "leading": {
                  "relation": "equal",
                  "toItem": "superview",
                  "constant": 20
                },
                "width": {
                   "relation": "equal",
                   "toItem": "superview",
                   "constant": 100
                },
                "height": {
                   "relation": "equal",
                   "toItem": "superview",
                   "constant": 100
                }
              }
            }
          ]
        }
        """
        
        // JSON 문자열을 Data로 변환
        guard let jsonData = jsonString.data(using: .utf8) else { return nil }
        
        // JSONDecoder로 디코딩
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(UIData.self, from: jsonData)
            return decodedData
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}
