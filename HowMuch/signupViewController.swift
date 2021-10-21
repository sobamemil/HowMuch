//
//  signupViewController.swift
//  HowMuch
//
//  Created by 심찬영 on 2021/10/20.
//

import UIKit
import Alamofire

class signupViewController : UIViewController {
    @IBOutlet weak var tfID: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPW: UITextField!
    @IBOutlet weak var tfPW2: UITextField!
    @IBOutlet weak var tfPNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registClicked(_ sender: Any) {
        postTest(id: tfID.text, name: tfName.text, pw: tfPW.text, pw2: tfPW2.text, pnum: tfPNumber.text)
    }
    
    
    func postTest(id: String?, name: String?, pw: String?, pw2: String?, pnum: String?) {
//            let url = "https://ptsv2.com/t/6ezif-1634703985/post"
        
            let url = "http://49.161.233.189:8080/user/join"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 10
            
            // POST 로 보낼 정보
        let params = ["id":id, "name":name, "pw":pw, "phonenumber":pnum] as Dictionary
        
//          parameter : id, pw, name, addres, email, phonenumber
        
            // httpBody 에 parameters 추가
            do {
                try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                print("http Body Error")
            }
            
            AF.request(request).responseString { (response) in
                print(response)
                switch response.result {
                case .success:
                    let alert = UIAlertController(title: "회원가입 성공", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default) {_ in
                        self.performSegue(withIdentifier: "unwindFirstVC", sender: self)
                    })
                    self.present(alert, animated: true, completion: nil)
                case .failure(let error):
                    
                    let alert = UIAlertController(title: "Request Error", message: "관리자에게 문의하세요.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .destructive))
                    self.present(alert, animated: true, completion: nil)
                    
                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            }
        }
}
