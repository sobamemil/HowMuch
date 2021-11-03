//
//  ImageRecognizeViewController.swift
//  HowMuch
//
//  Created by 심찬영 on 2021/11/03.
//

import UIKit

class ImageRecognizeViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imgV1: UIImageView!
    @IBOutlet weak var btnSend: UIButton!
    
    var imagePicker : UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sendImage(_:)))
        imgV1.addGestureRecognizer(tapGesture)
        imgV1.isUserInteractionEnabled = true
        
    }
    
    
    @objc func sendImage(_ sender: UITapGestureRecognizer? = nil) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        imgV1.image = info[.originalImage] as? UIImage
    }
}
