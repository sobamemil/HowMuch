//
//  emailLoginViewController.swift
//  HowMuch
//
//  Created by 심찬영 on 2021/10/18.
//

import UIKit
import Alamofire

class emailLoginViewController : UIViewController {
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPwd: UITextField!
    
    
    override func viewDidLoad() {
        // 다크모드 미적용.
        overrideUserInterfaceStyle = .light
        
        // textfield에 underline을 생성하기 위한 코드
        tfEmail.setUnderLine()
        tfPwd.setUnderLine()
        
    }
    
    
}

