//
//  MenuVC.swift
//  DemoZomato
//
//  Created by Moin Shaikh on 25/03/21.
//

import UIKit

class MenuVC: BaseVC {
    
    @IBOutlet weak var cltnMenu: UICollectionView!
    
    private let spacing:CGFloat = 12.0
    var arrMenu = ["dish1","dish2","dish3","dish4","dish5","dish6","dish7","dish1","dish2","dish3","dish4","dish5","dish6","dish7","dish1","dish2","dish3","dish4","dish5","dish6","dish7","dish1","dish2","dish3","dish4","dish5","dish6","dish7","dish1","dish2","dish3","dish4","dish5","dish6","dish7","dish1","dish2","dish3","dish4","dish5","dish6","dish7","dish1","dish2","dish3","dish4","dish5","dish6","dish7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationbarleft(false,.customIcon(.menu), nil, #selector(self.buttonSideMenu(_:)), .customIcon(.setting), nil, #selector(self.buttonSideMenu(_:)), false, .white, title: "Menu")
        
        runOnAfterTime(afterTime: 0.5) {
            self.setupUI()
        }
    }
    
    //MARK:- Setup UI
    func setupUI() {
        self.cltnMenu.register(UINib(nibName: ID_MENU_COLLECTION_CELL, bundle: nil), forCellWithReuseIdentifier: ID_MENU_COLLECTION_CELL)
        
        let cellSize = (cltnMenu.frame.size.width / 2) - 10
        let menuLayout: UICollectionViewFlowLayout = (cltnMenu.collectionViewLayout as! UICollectionViewFlowLayout)
        menuLayout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        menuLayout.minimumLineSpacing = spacing //Every cell bottom spacing
        menuLayout.minimumInteritemSpacing = spacing
        
        menuLayout.itemSize = CGSize(width: cellSize, height: cellSize) //same as sizeForItemAt
        menuLayout.scrollDirection = .vertical
        
        cltnMenu.delegate = self
        cltnMenu.dataSource = self
        cltnMenu.showsHorizontalScrollIndicator = false
        cltnMenu.showsVerticalScrollIndicator = false
    }
}

//MARK:- Collection view delegate
extension MenuVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let settingVCObj = self.storyboard?.instantiateViewController(withIdentifier: "idMenuDetailsVC") as! MenuDetailsVC
        //wishlistVCObj.isFromMenu = true
        self.navigationController?.pushViewController(settingVCObj, animated: true)
    }
}

//MARK:- Collection view flow layout
extension MenuVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfItemsPerRow: CGFloat = 2
        let spacingBetweenCells: CGFloat = self.spacing
        
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        
        if collectionView == cltnMenu {
            let width = (cltnMenu.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width - 50)
        }
        return CGSize.zero
    }
}

//MARK:- Collection view datasource
extension MenuVC : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMenu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID_MENU_COLLECTION_CELL,for:indexPath) as! MenuCollectionViewCell
        
        cell.imgMenu.image = UIImage(named: arrMenu[indexPath.row])
        
        return cell
    }
}
