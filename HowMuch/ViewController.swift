//
//  ViewController.swift
//  HowMuch
//
//  Created by 심찬영 on 2021/10/14.
//

import UIKit

class ViewController: UIViewController {

    // 첫 화면(로그인 화면) 로그인 버튼 (이메일, 카카오, 애플 로그인)
    @IBOutlet weak var btnEmailLogin: UIButton!
    @IBOutlet weak var btnKakaoLogin: UIButton!
    @IBOutlet weak var btnAppleLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
//        let safeArea = view.safeAreaLayoutGuide
//        btnEmailLogin.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
//        btnEmailLogin.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
//        btnEmailLogin.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
//
//        btnEmailLogin.translatesAutoresizingMaskIntoConstraints = false
//
        
        
    }
    
    @IBAction func emailLoginClicked(_ sender: Any) {
        
    }
    
}
