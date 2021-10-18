//
//  emailLoginViewController.swift
//  HowMuch
//
//  Created by 심찬영 on 2021/10/18.
//

import UIKit
import Alamofire
import SwiftUI

class emailLoginViewController : UIViewController {
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPwd: UITextField!
    
    // 다음 누르면 입력창 넘어가기, 완료 누르면 키보드 내려가기
    @objc func didEndOnExit(_ sender: UITextField) {
        if tfEmail.isFirstResponder {
            tfPwd.becomeFirstResponder()
        }
    }
    
    override func viewDidLoad() {
        // 다크모드 미적용.
        overrideUserInterfaceStyle = .light
        
        // 키보드 내리기
        tfEmail.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        tfPwd.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
            
        // textfield에 underline을 생성하기 위한 코드
        tfEmail.setUnderLine()
        tfPwd.setUnderLine()
        
    }
    
    
    @IBAction func emailLoginClicked(_ sender: UIButton) {
        let url = "https://jsonplaceholder.typicode.com/todos/1"
                AF.request(url,
                           method: .get,
                           parameters: nil,
                           encoding: URLEncoding.default,
                           headers: ["Content-Type":"application/json", "Accept":"application/json"])
                    .validate(statusCode: 200..<300)
                    .responseJSON { (json) in
                        //여기서 가져온 데이터를 자유롭게 활용하세요.
                        print(json)
                }
    }
    
    
}

// 사용자 로그인 계정 정보
final class UserModel {
    struct User {
        var email: String
        var password: String
    }
    
    var users: [User] = [
        User(email: "abc1234@naver.com", password: "qwerty1234"),
        User(email: "dazzlynnnn@gmail.com", password: "asdfasdf5678")
    ]
    
    // 아이디 형식 검사
    func isValidEmail(id: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: id)
    }
    
    // 비밀번호 형식 검사
    func isValidPassword(pwd: String) -> Bool {
        let passwordRegEx = "^[a-zA-Z0-9]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: pwd)
    }
} // end of UserModel

