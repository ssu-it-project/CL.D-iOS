//
//  PlayerView.swift
//  CLD
//
//  Created by 김규철 on 2023/08/09.
//

import UIKit
import AVKit

final class PlayerView: UIView {
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = self.bounds
    }
    
    private func initialSetup() {
        player = AVPlayer()
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = .resizeAspectFill
        self.layer.addSublayer(playerLayer!)
    }
}

extension PlayerView {
    func setupPlayerItem(with assetURL: URL) {
        let playerItem = AVPlayerItem(url: assetURL)
        player?.replaceCurrentItem(with: playerItem)
    }
}
