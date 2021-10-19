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
    
    var userModel = UserModel() // 사용자 계정 인스턴스 생성

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPwd: UITextField!
    @IBOutlet weak var cbAutoLogin: CheckBox!
    
    // 다음 누르면 입력창 넘어가기, 완료 누르면 키보드 내려가기
    @objc func didEndOnExit(_ sender: UITextField) {
        if tfEmail.isFirstResponder {
            tfPwd.becomeFirstResponder()
        }
    }
    
    // TextField 흔들기 애니메이션
    func shakeTextField(textField: UITextField) -> Void{
        UIView.animate(withDuration: 0.2, animations: {
            textField.frame.origin.x -= 10
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                textField.frame.origin.x += 20
             }, completion: { _ in
                 UIView.animate(withDuration: 0.2, animations: {
                    textField.frame.origin.x -= 10
                })
            })
        })
    }
    
    // 로그인 method
    func loginCheck(id: String, pwd: String) -> Bool {
        for user in userModel.users {
            if user.email == id && user.password == pwd {
                return true // 로그인 성공
            }
        }
        return false
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
    
    // "이메일로 로그인" 버튼 클릭
    @IBAction func emailLoginClicked(_ sender: UIButton) {
        // 옵셔널 바인딩 & 예외 처리 : Textfield가 빈문자열이 아니고, nil이 아닐 때
            guard let email = tfEmail.text, !email.isEmpty else { return }
            guard let password = tfPwd.text, !password.isEmpty else { return }
        
        if userModel.isValidEmail(id: email){
                if let removable = self.view.viewWithTag(100) {
                    removable.removeFromSuperview()
                }
            }
            else {
                shakeTextField(textField: tfEmail)
                let emailLabel = UILabel(frame: CGRect(x: 68, y: 350, width: 279, height: 45))
                emailLabel.text = "이메일 형식을 확인해 주세요"
                emailLabel.textColor = UIColor.red
                emailLabel.tag = 100
                    
                self.view.addSubview(emailLabel)
            } // 이메일 형식 오류
        
        if userModel.isValidPassword(pwd: password){
                if let removable = self.view.viewWithTag(101) {
                    removable.removeFromSuperview()
                }
            }
            else{
                shakeTextField(textField: tfPwd)
                let passwordLabel = UILabel(frame: CGRect(x: 68, y: 435, width: 279, height: 45))
                passwordLabel.text = "비밀번호 형식을 확인해 주세요"
                passwordLabel.textColor = UIColor.red
                passwordLabel.tag = 101
                    
                self.view.addSubview(passwordLabel)
            } // 비밀번호 형식 오류
        
        if userModel.isValidEmail(id: email) && userModel.isValidPassword(pwd: password) {
                let loginSuccess: Bool = loginCheck(id: email, pwd: password)
                if loginSuccess {
                    print("로그인 성공")
                    
                    if (cbAutoLogin.isChecked) {
                        UserDefaults.standard.setValue(email, forKey: "id")
                        UserDefaults.standard.setValue(password, forKey: "pwd")
                        print("자동로그인 계정 정보 저장")
                    }
                    
                    if let removable = self.view.viewWithTag(102) {
                        removable.removeFromSuperview()
                    }
                    self.performSegue(withIdentifier: "showMain", sender: self)
                }
                else {
                    print("로그인 실패")
                    shakeTextField(textField: tfEmail)
                    shakeTextField(textField: tfPwd)
                    let loginFailLabel = UILabel(frame: CGRect(x: 68, y: 510, width: 279, height: 45))
                    loginFailLabel.text = "아이디나 비밀번호가 다릅니다."
                    loginFailLabel.textColor = UIColor.red
                    loginFailLabel.tag = 102
                        
                    self.view.addSubview(loginFailLabel)
                }
            }
        
        
        
//        let url = "https://jsonplaceholder.typicode.com/todos/1"
//                AF.request(url,
//                           method: .get,
//                           parameters: nil,
//                           encoding: URLEncoding.default,
//                           headers: ["Content-Type":"application/json", "Accept":"application/json"])
//                    .validate(statusCode: 200..<300)
//                    .responseJSON { (json) in
//                        //여기서 가져온 데이터를 자유롭게 활용하세요.
//                        print(json)
//                }
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
        User(email: "test@naver.com", password: "12341234")
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

