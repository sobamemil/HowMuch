//
//  ViewController.swift
//  HowMuch
//
//  Created by 심찬영 on 2021/10/14.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    // 첫 화면(로그인 화면) 로그인 버튼 (이메일, 카카오, 애플 로그인)
    @IBOutlet weak var btnEmailLogin: UIButton!
    @IBOutlet weak var btnKakaoLogin: UIButton!
    @IBOutlet weak var btnAppleLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // 다크모드 미적용.
        overrideUserInterfaceStyle = .light

        if let userId = UserDefaults.standard.string(forKey: "id") {
            if let userPwd = UserDefaults.standard.string(forKey: "pwd") {
                print("자동로그인 정보 존재. 메인 화면으로 이동")
                
                self.performSegue(withIdentifier: "showMain", sender: self)
            }
        }
        
        // navigationBar back button image change
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.backward")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward")
        // navigationBar backItem title change
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: nil, action: nil)

        
//        let safeArea = view.safeAreaLayoutGuide
//        btnEmailLogin.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
//        btnEmailLogin.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
//        btnEmailLogin.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
//
//        btnEmailLogin.translatesAutoresizingMaskIntoConstraints = false
//
        
        
    }
    
    @IBAction func emailLoginClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "segueEmailLogin", sender: sender)
    }
    
    // unwind segue 사용하기 위한 메소드
    @IBAction func unwindFirstVC(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func buttonClick(_ sender: Any) {
        postTest()
    }
    
    func postTest() {
            let url = "https://ptsv2.com/t/6ezif-1634703985/post"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 10
            
            // POST 로 보낼 정보
            let params = ["id":"아이디", "pw":"비밀번호"] as Dictionary
        
//          parameter : id, pw, name, addres, email, phonenumber
        
            // httpBody 에 parameters 추가
            do {
                try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                print("http Body Error")
            }
            
            AF.request(request).responseString { (response) in
                switch response.result {
                case .success:
                    print("POST 성공")
                case .failure(let error):
                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            }
        }
}
