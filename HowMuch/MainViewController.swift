//
//  MainViewController.swift
//  HowMuch
//
//  Created by 심찬영 on 2021/10/19.
//

import UIKit
import Alamofire

class MainViewController : UIViewController {
    // 검색 버튼
    @IBOutlet weak var btnImageSearch: UIButton!
    @IBOutlet weak var btnVoiceSearch: UIButton!
    
    // 품목 버튼
    @IBOutlet weak var btnFurniture: UIButton!
    @IBOutlet weak var btnKitchen: UIButton!
    @IBOutlet weak var btnLife: UIButton!
    @IBOutlet weak var btnAir: UIButton!
    @IBOutlet weak var btnWorkout: UIButton!
    @IBOutlet weak var btnBaby: UIButton!
    @IBOutlet weak var btnElectonic: UIButton!
    @IBOutlet weak var btnETC: UIButton!
    
    
    override func viewDidLoad() {
        // 내비게이션 백버튼 숨김
        navigationItem.hidesBackButton = true
  
    }
    
    
    @IBAction func imageSearchClicked(_ sender: Any) {
//        performSegue(withIdentifier: "showCamera", sender: self)
        performSegue(withIdentifier: "showImageRecognize", sender: self)
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "pwd")
        
        print("로그아웃 되었습니다.")
        print("UserDefault Account Data Removed!!!")
    }
//    @IBAction func imageSendClicked(_ sender: Any) {
//        func uploadDiary(date: String, emoji: String, content: String, _ photo : UIImage, url: String){
//                    //함수 매개변수는 POST할 데이터, url
//
//                    let body : Parameters = [
//                        "date" : date,
//                        "emoji" : emoji,
//                        "content" : content,
//                        "user" : 2
//                    ]    //POST 함수로 전달할 String 데이터, 이미지 데이터는 제외하고 구성
//
//                    //multipart 업로드
//                    AF.upload(multipartFormData: { (multipart) in
//                        if let imageData = photo.jpegData(compressionQuality: 1) {
//                            multipart.append(imageData, withName: "photo", fileName: "photo.jpg", mimeType: "image/jpeg")
//                            //이미지 데이터를 POST할 데이터에 덧붙임
//                        }
//                        for (key, value) in body {
//                            multipart.append("\(value)".data(using: .utf8, allowLossyConversion: false)!, withName: "\(key)")
//                            //이미지 데이터 외에 같이 전달할 데이터 (여기서는 user, emoji, date, content 등)
//                        }
//                    }, to: url    //전달할 url
//                    ,method: .post        //전달 방식
//                    ,headers: headers).responseJSON(completionHandler: { (response) in    //헤더와 응답 처리
//                        print(response)
//
//                        if let err = response.error{    //응답 에러
//                            print(err)
//                            return
//                        }
//                        print("success")        //응답 성공
//
//                        let json = response.data
//
//                        if (json != nil){
//                            print(json)
//                        }
//                    })
//
//                }
//    }
    
}
