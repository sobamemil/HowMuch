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
    
    @IBOutlet weak var btnFurniture: UIButton!
    @IBOutlet weak var btnKitchen: UIButton!
    @IBOutlet weak var btnLife: UIButton!
    @IBOutlet weak var btnAir: UIButton!
    @IBOutlet weak var btnETC: UIButton!
    
    
    private let furniture = ["의자"]
    private let kitchen = ["쌀통(예정)"]
    private let life = ["액자", "벽시계(예정)", "이불(예정)"]
    private let air = ["선풍기(예정)"]
    private let etc = ["청소기(예정)", "냉장고(예정)"]
    
    private var curItem : String?
    
    var curKind = "" {
        didSet {
            btnColorReset()
            btnColorSet(curKind)
            self.collectionView?.reloadData()
        }
    }
    
    
    
    var willSearchItem : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        (self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = .zero
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: nil, action: nil)
        
        self.navigationItem.title = "품목선택"
        
        if(tfItemSearch.text == "") {
            
        }

        btnColorSet(curKind)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tfItemSearch.text = willSearchItem
    }
    
    @IBAction func doneClicked(_ sender: Any) {
        
        if (curItem != nil) {
            if( (curItem!.hasSuffix("(예정)")) != true ) {
                let alert = UIAlertController(title: nil, message: "선택하신 폐기물이 \(curItem!)이(가) 맞나요?", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default) { UIAlertAction in
                    self.performSegue(withIdentifier: "showLastView", sender: self)
                    
                }
                let cancel = UIAlertAction(title: "취소", style: .default, handler: nil)
                alert.addAction(ok)
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: nil, message: "아직 지원하지 않는 품목입니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            }
        } else {
            let alert = UIAlertController(title: "오류", message: "품목이 선택되지 않았습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
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
    
    func btnColorReset() {
        btnFurniture?.tintColor = .tintColor
        btnKitchen?.tintColor = .tintColor
        btnLife?.tintColor = .tintColor
        btnAir?.tintColor = .tintColor
        btnETC?.tintColor = .tintColor
    }
    
    func btnColorSet(_ btn : String) {
        if(btn == "가구") {
            btnFurniture?.tintColor = .purple
        } else if(btn == "주방용품") {
            btnKitchen?.tintColor = .purple
        } else if(btn == "생활용품") {
            btnLife?.tintColor = .purple
        } else if(btn == "냉난방용품") {
            btnAir?.tintColor = .purple
        } else if(btn == "기타제품") {
            btnETC?.tintColor = .purple
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        guard let nextViewController : LastViewController = segue.destination as? LastViewController else {
            print("3")
            return
        }
        
        guard let sender = sender as? ItemSelectViewController else {
            print("4")
            return
        }

        nextViewController.selectedItem = sender.curItem
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
            return self.life.count
        case "냉난방용품" :
            return self.air.count
        case "기타제품" :
            return etc.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CSCollectionViewCell
        
        cellBackColorReset(cell)
        
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
        
        var cell = collectionView.cellForItem(at: indexPath)
        
//        cell?.contentView.backgroundColor = .purple
        if indexPath.item == 0 {
            cell?.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
          }
        
        switch(curKind) {
        case "가구" :
            curItem = self.furniture[indexPath.item]
        case "주방용품" :
            curItem = self.kitchen[indexPath.item]
        case "생활용품" :
            curItem = self.life[indexPath.item]
        case "냉난방용품" :
            curItem = self.air[indexPath.item]
        case "기타제품" :
            curItem = self.etc[indexPath.item]
        default:
            print("curKind -> defalut")
        }
    }
    
    func cellBackColorReset(_ cell : UICollectionViewCell) {
        cell.backgroundColor = .systemGray6
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
//        print("collectionView width=\(collectionView.frame.width)")
//        print("cell하나당 width=\(width)")
//        print("root view width = \(self.view.frame.width)")

        let size = CGSize(width: width, height: width)
        return size
    }
}

// custom cell
class CSCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet var lbl: UILabel!
    
    override var isSelected: Bool {
      didSet {
        if isSelected {
            backgroundColor = .systemIndigo
        } else {
            backgroundColor = .systemGray6
        }
      }
    }
}
