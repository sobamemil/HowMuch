//
//  ImageRecognizeViewController.swift
//  HowMuch
//
//  Created by 심찬영 on 2021/11/03.
//

import UIKit
import Alamofire

class ImageRecognizeViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imgV1: UIImageView!
    @IBOutlet weak var btnSend: UIButton!
    
    var imagePicker : UIImagePickerController!
//    let imageServerURL = "https://ptsv2.com/t/6ezif-1634703985/post"
    
    // postman test server
//    let imageServerURL = "https://33873788-78a5-4fd2-94f5-f26bd168ebdb.mock.pstmn.io"
    
//    let imageServerURL = "http://9637-121-158-10-61.ngrok.io/image"
    
    // 플라스크 서버 ip주소
    let imageServerURL = "http://121.158.10.61:5000/image"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(takePhoto(_:)))
        imgV1.addGestureRecognizer(tapGesture)
        imgV1.isUserInteractionEnabled = true
    }
    
    @objc func takePhoto(_ sender: UITapGestureRecognizer? = nil) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        imgV1.image = info[.originalImage] as? UIImage
    }
    
    @IBAction func imageSendClicked(_ sender: Any) {
        print("눌렸습니다")
        uploadPhoto(msg: "test1", imgV1.image!, url: imageServerURL)
    }
    
    func uploadPhoto(msg: String, _ photo : UIImage, url: String){
        //함수 매개변수는 POST할 데이터, url
        
        let headers: HTTPHeaders = [
                            "Content-Type": "multipart/form-data"
                        ]//HTTP 헤더

        let body : Parameters = [
            "msg" : msg
        ]    //POST 함수로 전달할 String 데이터, 이미지 데이터는 제외하고 구성

        //multipart 업로드
        AF.upload(multipartFormData: { (multipart) in
//            for (key, value) in body {
//                multipart.append("\(value)".data(using: .utf8, allowLossyConversion: false)!, withName: "\(key)")
//                // 이미지 데이터 외에 같이 전달할 데이터 (여기서는 user, emoji, date, content 등)
//            }
            
            // 사진 전송
            if let imageData = photo.jpegData(compressionQuality: 1) {
                multipart.append(imageData, withName: "file", fileName: "\(imageData).jpg", mimeType: "image/jpg")
                //이미지 데이터를 POST할 데이터에 덧붙임
                print("이미지 추가 성공")
            }
        }, to: url    //전달할 url
        ,method: .post        //전달 방식
                  ,headers: headers).responseString(completionHandler: {
            response in
            print(response)

             // 길이 측정 화면으로 이동
            self.performSegue(withIdentifier: "showCameraMeasure", sender: self)

        })
//        ,headers: headers).responseJSON(completionHandler: { (response) in    //헤더와 응답 처리
//            print(response)
//
//            if let err = response.error{    //응답 에러
//                print(err)
//                return
//            }
//            print("success")        //응답 성공
//
//            let json = response.data
//
//            if (json != nil){
//                print(json)
//            }
//        })

    }
}
