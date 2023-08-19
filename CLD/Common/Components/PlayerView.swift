//
//  PlayerView.swift
//  CLD
//
//  Created by 김규철 on 2023/08/09.
//

import UIKit
import AVKit

final class PlayerView: UIView {
    
    var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
        player?.isMuted = true
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
    func setupPlayerItem(with assetURL: String) {
        if let videoURL = URL(string: assetURL) {
            // 에셋이 재생 상태일 때 해당 에셋의 타이밍과 프레젠테이션 상태를 모델링하는 객체
            // AVPlayer 객체가 AVPlayerItem을 사용하고, AVPlayerItem이 AVAsset을 사용하는 구조
            let playerItem = AVPlayerItem(url: videoURL)
            player?.replaceCurrentItem(with: playerItem)
        } else {
            print("Invalid URL: \(assetURL)")
        }
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
}
