//
//  PinterestLayout.swift
//  TestMultipleDirectionCollectionView
//
//  Created by Shantaram K on 04/02/20.
//  Copyright © 2020 Razorpay. All rights reserved.
//

import UIKit

class PinterestLayout: UICollectionViewLayout {

    var numberOfColumns: CGFloat = 2
    
    var cellPadding: CGFloat = 5.0
    
    private var contentHeight: CGFloat = 0.0
    
    private var contentWidht: CGFloat {
        let insect = collectionView!.contentInset
        return (collectionView!.bounds.width) - (insect.left + insect.right)
    }
    
    
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
            
            let columnWidth  = contentWidht / numberOfColumns
            
            //We have to columns to maintain x 0ffset
            
            var xOffsets = [CGFloat]()
            
            for column in 0..<Int(numberOfColumns) {
                
                xOffsets.append(CGFloat(column) * columnWidth)
            }
            
            //maintain y-offst of each columns
            
            var column = 0
            
            var yOffsets = [CGFloat](repeating: 0, count: Int(numberOfColumns))
            
            //enumerate the each item in section
            
            for item in 0..<collectionView!.numberOfItems(inSection: 0) {
                
                //get index path of item in section
                
                let indexPath = IndexPath(item: item, section: 0)
                
                
                //calcuate the frame of attribute of cell
                
                let photoHeight: CGFloat = 50.0
                
                let captionHeight: CGFloat = 30.0
                
                
                let width = columnWidth - cellPadding * 2
   
                let height = cellPadding + photoHeight + captionHeight + cellPadding
                
                
                let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
                
                
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                
                //create cell layout attribute
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                
                //assgin the frame to attribute
                
                attribute.frame = insetFrame
                
                //stote in cahce
                attributeCache.append(attribute)
                //
                
                
                //update the column and y offset
                
                contentHeight = max(contentHeight, frame.maxY)
                
                yOffsets[column] = yOffsets[column] + height
                
                
                if column >= Int(numberOfColumns) - 1 {
                    column = 0
                } else {
                    column += 1
                }
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


