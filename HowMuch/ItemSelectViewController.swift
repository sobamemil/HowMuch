//
//  ItemSelectViewController.swift
//  HowMuch
//
//  Created by 심찬영 on 2021/11/09.
//

import UIKit

class ItemSelectViewController : UIViewController {
    @IBOutlet weak var tfItemSearch: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let furniture = ["의자"]
    let kitchen = ["쌀통(예정)"]
    let life = ["액자", "벽시계(예정)", "이불(예정)"]
    let air = ["선풍기(예정)"]
    let etc = ["청소기(예정)", "냉장고(예정)"]
    
    var curKind = "" {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    
    var willSearchItem : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tfItemSearch.text = willSearchItem
    }
    
    @IBAction func furnitureClicked(_ sender: Any) {
        curKind = "가구"
    }
    
    @IBAction func kitchenClicked(_ sender: Any) {
        curKind = "주방용품"
    }
    
    @IBAction func lifeClicked(_ sender: Any) {
        curKind = "생활용품"
    }
    
    @IBAction func airClicked(_ sender: Any) {
        curKind = "냉난방용품"
    }
    
    @IBAction func etcClicked(_ sender: Any) {
        curKind = "기타제품"
    }
    
    
    
    
}

// cell data
extension ItemSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch(curKind) {
        case "가구" :
            return self.furniture.count
        case "주방용품" :
            return self.kitchen.count
        case "생활용품" :
            print("생활용품 카운트")
            return self.life.count
        case "냉난방용품" :
            print("냉난방용품 카운트")
            return self.air.count
        case "기타제품" :
            return etc.count
        default:
            print(curKind)
            print("default")
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CSCollectionViewCell
        
        cell.backgroundColor = .lightGray
        
        switch(curKind) {
        case "가구" :
            cell.lbl.text = self.furniture[indexPath.row]
        case "주방용품" :
            cell.lbl.text = self.kitchen[indexPath.row]
        case "생활용품" :
            cell.lbl.text = self.life[indexPath.row]
        case "냉난방용품" :
            cell.lbl.text = self.air[indexPath.row]
        case "기타제품" :
            cell.lbl.text = etc[indexPath.row]
        default:
            print("curKind -> defalut")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch(curKind) {
        case "가구" :
            print(String( self.furniture[indexPath.item] ) + " 클릭됨")
        case "주방용품" :
            print(String( self.kitchen[indexPath.item] ) + " 클릭됨")
        case "생활용품" :
            print(String( life[indexPath.item] ) + " 클릭됨")
        case "냉난방용품" :
            print(String( air[indexPath.item] ) + " 클릭됨")
        case "기타제품" :
            print(String( etc[indexPath.item] ) + " 클릭됨")
        default:
            print("curKind -> defalut")
        }
    }
}

// cell layout
extension ItemSelectViewController: UICollectionViewDelegateFlowLayout {

    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width / 3 - 1 ///  3등분하여 배치, 옆 간격이 1이므로 1을 빼줌
        print("collectionView width=\(collectionView.frame.width)")
        print("cell하나당 width=\(width)")
        print("root view width = \(self.view.frame.width)")

        let size = CGSize(width: width, height: width)
        return size
    }
}

// custom cell
class CSCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet var lbl: UILabel!
}
