//
//  RelationRecommendView.swift
//  News
//
//  Created by 经纬泰和 on 2019/1/4.
//  Copyright © 2019 经纬泰和. All rights reserved.
//

import UIKit

class RelationRecommendView: UIView , NibLoadable {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var userCards = [UserCard]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.collectionViewLayout = RelationRecommendFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.lwn_registerCell(cell: RelationRecommendCell.self)
    }
}

extension RelationRecommendView:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.lwn_dequeueReusableCell(indexPath: indexPath) as RelationRecommendCell
        
        cell.userCard = userCards[indexPath.row]
        
        return cell
        
    }
    
    
}

class RelationRecommendFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        itemSize = CGSize(width: 142, height: 185)
        minimumLineSpacing = 10
        sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 10)
        scrollDirection = .horizontal
        
    }
}
