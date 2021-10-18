//
//  MainViewController.swift
//  HowMuch
//
//  Created by 심찬영 on 2021/10/19.
//

import UIKit

class MainViewController : UIViewController {
    override func viewDidLoad() {
        // 다크모드 미적용.
        overrideUserInterfaceStyle = .light
        // 내비게이션 백버튼 숨김
        navigationItem.hidesBackButton = true
    }
}
