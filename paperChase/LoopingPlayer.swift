//
//  LoopingPlayer.swift
//  paperChase
//
//  Created by Philippe Van Daele on 2021-02-08.
//

import SwiftUI
import AVFoundation

struct LoopingPlayer: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        return QueuePlayerUIView(frame: .zero)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Do nothing here
    }
}

class QueuePlayerUIView: UIView{
    
    private var playerLayer = AVPlayerLayer()
    private var playerLooper :AVPlayerLooper?
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        // Load video
        let fileUrl = Bundle.main.url(forResource: "walking", withExtension: "mp4")!
        let playerItem = AVPlayerItem(url: fileUrl)
        
        // Setup player
        let player = AVQueuePlayer(playerItem: playerItem)
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        // Loop
        playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
        
        // Play
        player.play()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
}


struct LoopingPlayer_Previews: PreviewProvider {
    static var previews: some View {
        LoopingPlayer()
    }
}
