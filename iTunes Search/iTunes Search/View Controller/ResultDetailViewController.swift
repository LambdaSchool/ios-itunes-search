//
//  ResultDetailViewController.swift
//  iTunes Search
//
//  Created by Kat Milton on 7/9/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ResultDetailViewController: UIViewController {
    
    @IBOutlet var kindLabel: UILabel!
    @IBOutlet var creatorLabel: UILabel!
    @IBOutlet var trackTimeLabel: UILabel!
    @IBOutlet var artworkDisplay: UIImageView!
    @IBOutlet var mediaPreview: UIButton!
   
    
    
    var searchResult: SearchResult? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        self.title = searchResult?.title
        adjustLargeTitleSize()
        
        mediaPreview.layer.cornerRadius = 6.0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateViews()
    }
    
    @IBAction func playVideo(_ sender: UIButton) {
        guard let url = URL(string: searchResult?.preview ?? " ") else {
            return
        }
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        let player = AVPlayer(url: url)
        
        // Create a new AVPlayerViewController and pass it a reference to the player.
        let controller = AVPlayerViewController()
        controller.player = player
        
        // Modally present the player and call the player's play() method when complete.
        present(controller, animated: true) {
            player.play()
        }
    }
    
//    func createThumbnailOfVideoFromFileURL(videoURL: String) -> UIImage? {
//        let asset = AVAsset(url: URL(string: videoURL)!)
//        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
//        assetImgGenerate.appliesPreferredTrackTransform = true
//        let time = CMTimeMakeWithSeconds(Float64(1), preferredTimescale: 100)
//        do {
//            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
//            let thumbnail = UIImage(cgImage: img)
//            return thumbnail
//        } catch {
//            return UIImage(named: "ico_placeholder")
//        }
//    }
//
    
    

    
    func updateViews() {
        creatorLabel.text = searchResult?.creator
        kindLabel.text = searchResult?.kind
        
        let runTime = searchResult?.trackTime
        if let runTime = runTime {
        
        let time = NSDate(timeIntervalSince1970: Double(runTime) / 1000)
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        formatter.dateFormat = "HH mm ss SSS"
            let trackTime = formatter.string(from: time as Date)
            var timeArray = trackTime.components(separatedBy: " ")
            
                if Int(timeArray[0]) == 0 {
                    
                    trackTimeLabel.text = "\(timeArray[1]) min \(timeArray[2]) sec"
                } else if Int(timeArray[0]) == 1 {
                    trackTimeLabel.text = "\(timeArray[0]) hr \(timeArray[1]) min \(timeArray[2]) sec"
                } else {
                    trackTimeLabel.text = "\(timeArray[0]) hrs \(timeArray[1]) min \(timeArray[2]) sec"
                }
            
    }
//        let ms = searchResult?.trackTime
//        let runTime = ms?.msToSeconds.minuteSecondMS
//
//        if let runTime = runTime {
//            if runTime.isEmpty {
//                trackTimeLabel.isHidden = true
//            } else {
//            trackTimeLabel.text = runTime
//            }
//        }
        
       
        if searchResult?.artwork == nil {
            artworkDisplay.isHidden = true
        } else {
            
            guard let url = URL(string:searchResult?.artwork ?? " "),
                let artworkData = try? Data(contentsOf: url) else { return }
            artworkDisplay.image = UIImage(data: artworkData)
            artworkDisplay.layer.cornerRadius = 6.0
            artworkDisplay.clipsToBounds = true
        }
        
        if searchResult?.preview == nil {
            mediaPreview.isHidden = true
        } else {
            mediaPreview.isHidden = false
            
            
            
            
        }
        
        
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



extension UIViewController {
    func adjustLargeTitleSize() {
        guard let title = title, #available(iOS 11.0, *) else { return }
        
        let maxWidth = UIScreen.main.bounds.size.width - 60
        var fontSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        var width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
        
        while width > maxWidth {
            fontSize -= 1
            width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
        }
        
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)
        ]
    }
}
