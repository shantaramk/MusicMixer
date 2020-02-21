//
//  ViewController+Delegate.swift
//  TestMultipleDirectionCollectionView
//
//  Created by Shantaram K on 05/02/20.
//  Copyright © 2020 Razorpay. All rights reserved.
//

import UIKit

extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.musicList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.musicList[section].musics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        let musicBaseModel = viewModel.musicList[indexPath.section]
        detailCell.setData(musicBaseModel.musics[indexPath.row])
        return detailCell
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let musicBaseModel = viewModel.musicList[sourceIndexPath.section]
        
        let musicItem = musicBaseModel.musics.remove(at: sourceIndexPath.item)
        
        let destinationMusicBaseModel = viewModel.musicList[destinationIndexPath.section]
        
        destinationMusicBaseModel.musics.insert(musicItem, at: destinationIndexPath.item)
        
        collectionView.reloadData()
    }
}

extension ViewController: MultiDirectionLayoutV2Delegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForMusicAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func collectionView(_ collectionView: UICollectionView, widthForMusicAt indexPath: IndexPath) -> CGFloat {
        
       return 120
        
    }
    
}
