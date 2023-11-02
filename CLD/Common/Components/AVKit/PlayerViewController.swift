//
//  PlayerViewController.swift
//  CLD
//
//  Created by 김규철 on 2023/09/17.
//

import UIKit
import AVKit

final class PlayerViewController: AVPlayerViewController {
    
    private var aplayer: AVPlayer?
    private var url: String
    
    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlayer()
    }
    
    func setPlayer() {
        if let url = URL(string: url) {
            self.player = AVPlayer(url: url)
            self.player?.play()
        }
    }
    
    deinit {
        self.aplayer?.pause()
        self.aplayer = nil
    }
}
