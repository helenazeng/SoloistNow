//
//  ViewController.swift
//  soloist
//
//  Created by Helena Zeng on 2/2/16.
//  Copyright © 2016 Helena Zeng. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    var playerItem: AVPlayerItem?
    var player:AVPlayer?

    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string: "https://s3.amazonaws.com/soloistsnow/Shostakovich.wav")
        playerItem = AVPlayerItem(URL:url!)
        player = AVPlayer(playerItem: playerItem!)
        let playerLayer = AVPlayerLayer(player: player!)
        playerLayer.frame=CGRectMake(0, 0, 10, 50)
        self.view.layer.addSublayer(playerLayer)
        
        playButton.addTarget(self, action: "playButtonTapped:", forControlEvents: .TouchUpInside)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func playButtonTapped(sender: AnyObject) {
        if player?.rate == 0
        {
            player!.play()
            playButton.setImage(UIImage(named: "Pause Filled-50.png"), forState: UIControlState.Normal)
        } else {
            player!.pause()
            playButton.setImage(UIImage(named: "Play Filled-50.png"), forState: UIControlState.Normal)
        }
    }
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "finishedPlaying:", name: AVPlayerItemDidPlayToEndTimeNotification, object: playerItem)
    }
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func finishedPlaying(myNotification:NSNotification) {
        playButton.setImage(UIImage(named: "Play Filled-50.png"), forState: UIControlState.Normal)
        
        let stopedPlayerItem: AVPlayerItem = myNotification.object as! AVPlayerItem
        stopedPlayerItem.seekToTime(kCMTimeZero)
    }
    
    
    // video development
    
//    private var firstAppear = true
//    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        if firstAppear {
//            do {
//                try playVideo()
//                firstAppear = false
//            } catch AppError.InvalidResource(let name, let type) {
//                debugPrint("Could not find resource \(name).\(type)")
//            } catch {
//                debugPrint("Generic error")
//            }
//            
//        }
//    }
//    
//    private func playVideo() throws {
//        guard let path = NSBundle.mainBundle().pathForResource("video", ofType:"mov") else {
//            throw AppError.InvalidResource("video", "mov")
//        }
//        let player = AVPlayer(URL: NSURL(fileURLWithPath: path))
//        let playerController = AVPlayerViewController()
//        playerController.player = player
//        self.presentViewController(playerController, animated: true) {
//            player.play()
//        }
//    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject?) {
            let destination = segue.destinationViewController as!
            AVPlayerViewController
            
            let url = NSURL(string:
                "https://s3.amazonaws.com/soloistsnow/video.mov")
            destination.player = AVPlayer(URL: url!)
            
    }
    
}

enum AppError : ErrorType {
    case InvalidResource(String, String)
}





