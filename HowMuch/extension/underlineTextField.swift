//
//  underlineTextField.swift
//  HowMuch
//
//  Created by 심찬영 on 2021/10/18.
//

import UIKit

// textfield에 underline을 생성하기 위한 코드 extension
extension UITextField {
    func setUnderLine() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width - 10, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
