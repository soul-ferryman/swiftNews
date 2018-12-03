//
//  MyFirstScetionCell.swift
//  News
//
//  Created by 经纬泰和 on 2018/11/30.
//  Copyright © 2018 经纬泰和. All rights reserved.
//

import UIKit

class MyFirstScetionCell: UITableViewCell ,RegisterCellOrNib {
    
    //标题
    @IBOutlet weak var leftLabel: UILabel!
    //副标题
    @IBOutlet weak var rightLabel: UILabel!
    //右边箭头
    @IBOutlet weak var rightImageview: UIImageView!

    @IBOutlet weak var collectionView: UICollectionView!
    
    var myConcerns = [MyConcern]() {
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    var myCellModel :MyCellModel? {
          didSet{
    
            self.setNeedsLayout()
            
        }
    }
    
    var myConcern :MyConcern? {
        didSet {
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.leftLabel.text = myCellModel?.text
        self.rightLabel.text = myCellModel?.grey_text
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.collectionViewLayout = MyConcernsFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.lwn_registerCell(cell: MyConcernCell.self)
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MyFirstScetionCell: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myConcerns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.lwn_dequeueReusableCell(indexPath: indexPath) as MyConcernCell
        
        cell.myConcern = myConcerns[indexPath.item]
        
        return cell
    }
    
}

class MyConcernsFlowLayout:UICollectionViewFlowLayout {
    override func prepare() {
        //每一个cell的大小
        itemSize = CGSize(width: 58, height: 74)
        //横向间距
        minimumLineSpacing = 0
        //纵向间距
        minimumInteritemSpacing = 0
        //cell上下左右的间距
        sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        //设置水平滚动
        scrollDirection = .horizontal
        
    }
}
