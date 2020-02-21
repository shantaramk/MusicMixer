//
//  MusicServiceManager.swift
//  TestMultipleDirectionCollectionView
//
//  Created by Shantaram K on 05/02/20.
//  Copyright © 2020 Razorpay. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MusicServiceManager: NSObject {

    func duration(for resource: String) -> Double {
        let asset = AVURLAsset(url: URL(fileURLWithPath: resource))
        return Double(CMTimeGetSeconds(asset.duration))
    }
}
