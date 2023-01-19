//
//  AudioManager.swift
//  DeezerExerciseSwiftUI
//
//  Created by Bilel Bouricha on 18/01/2023.
//

import Foundation
import AVFoundation

final class AudioManager {
    var player: AVPlayer?
    
    @Published var didEndPlaying = false
    
    init() {
        subsribe()
    }
    
    func startPlayer(track: URL) {
        player = AVPlayer(url: track)
        player?.play()
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
        
    }
    
    func pause() {
        player?.pause()
    }
    
    func pausePlay() -> Bool {
        if player?.rate == 0 {
            player?.play()
            return true
        } else {
            player?.pause()
            return false
        }
    }
    
    private func subsribe() {
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(playerDidFinishPlaying),
                         name: .AVPlayerItemDidPlayToEndTime,
                         object: player?.currentItem
            )
    }
    
    @objc private func playerDidFinishPlaying() {
        self.didEndPlaying = true
    }
}
