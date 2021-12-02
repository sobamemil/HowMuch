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
    
    // defalut -> 의자
    private var returnedItem = ""
    
    var imagePicker : UIImagePickerController!
//    let imageServerURL = "https://ptsv2.com/t/6ezif-1634703985/post"
    
    // postman test server
//    let imageServerURL = "https://33873788-78a5-4fd2-94f5-f26bd168ebdb.mock.pstmn.io"
    
//    let imageServerURL = "http://9637-121-158-10-61.ngrok.io/image"
    
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
    
    // 플라스크 서버 ip주소
    let imageServerURL = "http://121.158.10.61:5000/image"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: nil, action: nil)
        
        self.navigationItem.title = "이미지 인식"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(takePhoto(_:)))
        imgV1.addGestureRecognizer(tapGesture)
        imgV1.isUserInteractionEnabled = true
        
        self.view.addSubview(self.activityIndicator)

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
        //이미지 업로드 메소드
        uploadPhoto(msg: "test1", imgV1.image!, url: imageServerURL)

//        // for test
//        self.performSegue(withIdentifier: "showItemSelect2", sender: self)

    }
    
    func uploadPhoto(msg: String, _ photo : UIImage, url: String){
        
        self.activityIndicator.startAnimating()

        
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
                multipart.append(imageData, withName: "file", fileName: "\(String(imageData.description.filter { !" \n\t\r".contains($0) })).jpg", mimeType: "image/jpg")
                //이미지 데이터를 POST할 데이터에 덧붙임
            }
        }, to: url, method: .post, headers: headers).responseJSON(completionHandler: { response in
                
            switch response.result {
            case .success:
//                self.lblCost.text = response.value ?? "없음"
//                print(response.value!)
                
                guard let data = response.data else { return }
                
                // data
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                        
                        if let name = json["name"] as? String {
                            self.returnedItem = name
                            print("품목 인식 결과 : \(name)")
                        }
                    }
                
            case .failure(let error):
                let alert = UIAlertController(title: "Request Error", message: "관리자에게 문의하세요.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .destructive))
                self.present(alert, animated: true, completion: nil)

                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
            
//            // 길이 측정 화면으로 이동
//            self.performSegue(withIdentifier: "showCameraMeasure", sender: self)

            self.activityIndicator.stopAnimating()
            
            // 받은 품목을 다음 viewController로 넘겨주고
            // 품목 선택 화면으로 이동
            
            self.performSegue(withIdentifier: "showItemSelect2", sender: self)
            
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let nextViewController : ItemSelectViewController = segue.destination as? ItemSelectViewController else {
            print("nextViewController prepare failure")
            return
        }
        
        guard let sender = sender as? ImageRecognizeViewController else {
            print("sender prepare failrue")
            return
        }

        nextViewController.willSearchItem = sender.returnedItem
    }
    
    
}
