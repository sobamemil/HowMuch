//
//  LastViewController.swift
//  HowMuch
//
//  Created by 심찬영 on 2021/11/28.
//

import UIKit
import Alamofire
import SwiftSMTP

class LastViewController : UIViewController {
    
    @IBOutlet weak var curItem: UILabel!
    @IBOutlet weak var tfLength: UITextField!
    @IBOutlet weak var lblCost: UILabel!
    
    var selectedItem : String? = nil
    var flushDate = ""
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var address: UITextField!
    
    lazy var activityIndicator: UIActivityIndicatorView = {
            // Create an indicator.
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.center = self.view.center
            activityIndicator.color = UIColor.red
        
            // Also show the indicator even when the animation is stopped.
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = UIActivityIndicatorView.Style.medium
        
            // Start animation.
            activityIndicator.stopAnimating()
            return activityIndicator }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        curItem.text = selectedItem
         
        // DateFormatter 클래스 상수 선언
        let formatter = DateFormatter()
        
        // formatter의 dateFormat 속성을 설정
        formatter.dateFormat = "yyyy-MM-dd"
        flushDate = formatter.string(from: Date())
        
        self.view.addSubview(self.activityIndicator)

        
    }
    
    @IBAction func changeFlushDate(_ sender: Any) {
        let datePickerView = sender as! UIDatePicker
        
        // DateFormatter 클래스 상수 선언
        let formatter = DateFormatter()
        
        // formatter의 dateFormat 속성을 설정
        formatter.dateFormat = "yyyy-MM-dd"
        self.flushDate = formatter.string(from: datePickerView.date)
        
        // 데이트 피커에서 선택한 날짜를 format에서 설정한 포맷대로 string 메서드를 사용하여 문자열(String)로 변환
        print("선택시간 :  + \(formatter.string(from: datePickerView.date))")
        
        
        
    }
    
    @IBAction func lengthMeasureClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "showLengthMeasure", sender: self)
    }
    
    @IBAction func priceCalClicked(_ sender: Any) {
        let url = "http://49.161.233.189:8080/cost"

        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        let ad = UIApplication.shared.delegate as? AppDelegate
        request.headers = ["Authorization" : (ad?.token)!]
        
        

        // POST 로 보낼 정보
        let params = ["name" : curItem.text!, "width" : Double(tfLength.text!)!] as Dictionary
        
        //  signup parameter : id, pw, name, addres, email, phonenumber

        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
    
        AF.request(request).responseJSON { (response) in
            // self.activityIndicator.stopAnimating()

            // 터치 이벤트 풀기
            self.view.isUserInteractionEnabled = true
            
            switch response.result {
            case .success:
//                self.lblCost.text = response.value ?? "없음"
//                print(response.value!)
                
                guard let data = response.data else { return }
                
                // data
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                        
                        if let userName = json["username"] as? String {
                            self.name.text = userName
                        }
                        
                        if let phoneNumber = json["phonenumber"] as? String {
                            self.phoneNumber.text = phoneNumber
                        }
                        
                        if let cost = json["cost"] as? String {
                            self.lblCost.text = "\(cost) 원"
                        }
                    }
                
            case .failure(let error):
                let alert = UIAlertController(title: "Request Error", message: "관리자에게 문의하세요.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .destructive))
                self.present(alert, animated: true, completion: nil)

                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
        
    }
    
    
    @IBAction func submitClicked(_ sender: Any) {

        let mail_from = Mail.User(name: "test_from", email: "sieh96@gmail.com")
        let mail_to = Mail.User(name: "test_to", email: "sieh96@naver.com")

        let mail = Mail(from: mail_from, to: [mail_to], subject: "대형 폐기물 처리 요청", text: "대형 폐기물 처리 요청\n신청인 : \(self.name.text!)\n전화전호 : \(self.phoneNumber.text!)\n주소 : \(self.address.text!)\n배출일자 : \(self.flushDate)\n품목 : \(self.curItem.text!)\n")

        
        smtp.send(mail) { _ in
            print("send")
        }
        
        let alert = UIAlertController(title: "신청완료", message: "신청이 완료되었습니다.\n폐기물 처리 업체에서 별도의 연락이 갈 수도 있습니다. 감사합니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true) {
            
        }
        

    }
    
    
    
    
    // unwind segue 사용하기 위한 메소드
    @IBAction func unwindLastView(_ segue: UIStoryboardSegue) {
        
        if let from = segue.source as? ARViewController { tfLength.text = from.length }
    }
    
    // 여백 터치 시 키보드 내려가도록 하는 코드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
