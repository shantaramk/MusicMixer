//
//  MusicViewModel.swift
//  TestMultipleDirectionCollectionView
//
//  Created by Shantaram K on 05/02/20.
//  Copyright © 2020 Razorpay. All rights reserved.
//

import UIKit
enum MusicStatus {
    
    case playing
}
class MusicMixerViewModel: NSObject {
    
    var activeMusicList = [MusicModel]()

    var activeCollectionList = [CustomCell]()

    
    var musicList = [MusicBaseModel]()
    
    private var songList = ["song1", "song2"]
    
    func initMusicList() {
        
        var musicList = [MusicBaseModel]()
        
        let musicManager = MusicServiceManager()
        for song in songList {
            
            let musicBaseModel = MusicBaseModel()
            
            for i in 0 ..< 2 {
                
                let stringPath = Bundle.main.path(forResource: song, ofType: "mp3")
                
                let duration = musicManager.duration(for: stringPath!)
                
                musicBaseModel.musics.append(MusicModel(title: songList[i], size: duration))
            }
            
            musicList.append(musicBaseModel)
            
            self.musicList =  musicList
            
        }
      
    }
    
}

class MusicBaseModel {
    
    var musics = [MusicModel]()
}


class MusicModel {
    
    var title: String?
    var size: Double?
    var id: String?

    init(title: String, size: Double) {
        self.title = title
        self.size = size
    }
}
