//
//  MultiDirectionLayoutV2.swift
//  TestMultipleDirectionCollectionView
//
//  Created by Shantaram K on 21/02/20.
//  Copyright © 2020 Razorpay. All rights reserved.
//

import UIKit


import UIKit

protocol MultiDirectionLayoutV2Delegate: class {
    
    func collectionView(_ collectionView: UICollectionView, heightForMusicAt indexPath: IndexPath) -> CGFloat

    func collectionView(_ collectionView: UICollectionView,widthForMusicAt indexPath: IndexPath) -> CGFloat

    
}

class MultiDirectionLayoutV2: UICollectionViewLayout {
    
    var numberOfColumns: CGFloat = 1
    
    var numberOfRow: CGFloat = 0

    var cellPadding: CGFloat = 5.0
    
    var cellWidth: CGFloat = 5.0

    
    private var contentWidht: CGFloat = 0.0
    
    private var contentHeight: CGFloat = 0.0
    
    private var contentHeightNew: CGFloat = 0.0

    var delegate: MultiDirectionLayoutV2Delegate?
    
    private var attributeCache = [UICollectionViewLayoutAttributes]()
    
    /***
     1. Called whenever collectionview change: i.e rotaion
     2. Intent to change the collectinview layout attribute
     
     */
    
    
    override func prepare() {
        
        /***
         1. we are goint to calculate the x -offset (horizontal) of each coloumns or cell componetn.
         */
        
        //check to dont have to re reacte
        if attributeCache.isEmpty {
            
            let columnWidth  = 120.0
            
            numberOfRow = CGFloat(collectionView!.numberOfSections)
            
            //We have to columns to maintain x 0ffset
            
            var xOffsets = [CGFloat]()
            
            //maintain y-offst of each columns
            
            let column = 0
            
            let row = 0

            let collectionViewCenter = collectionView!.frame.midX
            
            xOffsets = [CGFloat](repeating: 0, count: Int(numberOfColumns))
            
            var yOffsets = [CGFloat](repeating: 0, count: 1)
            
            var height: CGFloat = 0
            //enumerate the each item in section
            
            for section in 0..<collectionView!.numberOfSections {
                
                yOffsets[row] = yOffsets[row] + height

                for item in 0..<collectionView!.numberOfItems(inSection: section) {
                    
                    //get index path of item in section
                    
                    let indexPath = IndexPath(item: item, section: section)
                    
                    //calcuate the frame of attribute of cell
                    
                    //calcualte Height

                    
                    let photoHeight: CGFloat = self.delegate?.collectionView(collectionView!, heightForMusicAt: indexPath) ?? 40.0
                    
                    let width: CGFloat = self.delegate?.collectionView(collectionView!, widthForMusicAt: indexPath) ?? 50
                    
                    self.cellWidth = width
                    
                    height = cellPadding + photoHeight + cellPadding
                    
                    let frame = CGRect(x: xOffsets[column], y: yOffsets[row], width: CGFloat(width), height: height)
                    
                    let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                    
                    //create cell layout attribute
                    let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                    
                    //assgin the frame to attribute
                    
                    attribute.frame = insetFrame
                    
                    //stote in cahce
                    attributeCache.append(attribute)
                    //
                    
                    //update the column and y offset
                    
                    contentWidht = max(contentWidht, frame.maxX)
                    
                    contentHeight = max(contentHeight, frame.maxY)

                    
                    //yOffsets[column] = yOffsets[column] + height
                    
                    xOffsets[column] = xOffsets[column] + CGFloat(width)
                   
                }
                


                xOffsets = [CGFloat](repeating: cellWidth / 2 , count: Int(numberOfColumns))

            }
        }
    }
    
    override var collectionViewContentSize: CGSize {
        
        return CGSize(width: contentWidht, height: contentHeight)
        
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        
        var layoutAttribute = [UICollectionViewLayoutAttributes]()
        
        for attribute in attributeCache {
            
            if attribute.frame.intersects(rect) {
                
                layoutAttribute.append(attribute)
                
            }
        }
        return layoutAttribute
    }
}


