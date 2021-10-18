//
//  checkBox.swift
//  HowMuch
//
//  Created by 심찬영 on 2021/10/18.
//

import UIKit

// 체크박스
class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(systemName: "checkmark.circle.fill")! as UIImage
    let uncheckedImage = UIImage(systemName: "circle")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
        
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
        
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
