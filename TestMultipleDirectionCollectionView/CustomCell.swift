//
//  CustomCell.swift
//  TestMultipleDirectionCollectionView
//
//  Created by N.A Shashank on 18/10/18.
 
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    var music: MusicModel?
    
    
    override func awakeFromNib() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.lightGray
    }
    
    func setData(_ music:MusicModel) {
        
        self.music = music
        
        self.lblTitle.text = music.title ?? ""
    }
    
}
