//
//  ViewController.swift
//  TestMultipleDirectionCollectionView
//
//  Created by N.A Shashank on 18/10/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var playButton: UIButton!

    var viewModel = MusicMixerViewModel()
    fileprivate var longPressGesture: UILongPressGestureRecognizer!
    private var lastContentOffset: CGFloat = 0
    
    var isPlaying: Bool? {
        didSet {
            if isPlaying == true {
                collectionView.isUserInteractionEnabled =  false
            } else {
                collectionView.isUserInteractionEnabled =  true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureGesture()
        configureCollectionViewFlowLayout()
        
        viewModel.initMusicList()

    }
   
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func configureCollectionViewFlowLayout() {
        
        if let layout = collectionView?.collectionViewLayout as? MultiDirectionLayout {
            
            layout.delegate = self
            
        }
     }
    
    
    func configureGesture() {
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
        collectionView.addGestureRecognizer(longPressGesture)
        
    }
    

}


extension ViewController {
    
    @IBAction func playButtonClicked(_ sender: Any) {
        UIView.animate(withDuration: 1) {
            self.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        
        GSAudio.sharedInstance.playSounds(soundFileNames:["song1", "song2"])
        isPlaying = true
    }
    
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
            
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.lastContentOffset > scrollView.contentOffset.x {
            // move up
        }
        else if (self.lastContentOffset < scrollView.contentOffset.x) {
            // move down
        }
        
        // update the new position acquired
        self.lastContentOffset = scrollView.contentOffset.x
        
        getSubComponet(scrollView)
        
       // print(self.lastContentOffset)
    }
    
    func getSubComponet(_ scrollView: UIScrollView) {
        
        let centerFrame = CGRect(x: collectionView.frame.midX, y: 2, width: 50, height: collectionView.frame.height)
        
        let viewList = scrollView.subviews
        
        for view in viewList {
            
            if let collectionCell = view as? CustomCell {
                
                if collectionCell.frame.intersects(centerFrame) {
                    
                    if let music = collectionCell.music as? MusicModel {

                        print(music.title ?? "")
                        
                        self.viewModel.activeMusicList.append(music)
                        
                        if self.viewModel.activeCollectionList.contains((collectionCell)) {
                            

                        } else {
                            
                            self.viewModel.activeCollectionList.append(collectionCell)
                        }
                        
                        print("Fount")
                        
                    }
                  
                }
                //print(collectionView.frame.origin.x)

            }
        }
    }
  
}
