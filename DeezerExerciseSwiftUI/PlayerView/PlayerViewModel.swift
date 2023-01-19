//
//  PlayerViewModel.swift
//  DeezerExerciseSwiftUI
//
//  Created by Bilel Bouricha on 18/01/2023.
//

import Combine
import Foundation

final class PlayerViewModel: ObservableObject {
    let track: DZRAlbumTrackList
    let album: DZRAlbum
    private var bag = Set<AnyCancellable>()
    @Published var audioManager = AudioManager()
    @Published var isPlaying: Bool = false
    
    init(track: DZRAlbumTrackList, album: DZRAlbum) {
        self.track = track
        self.album = album
        play()
        configureSubscribers()
    }
    
    func play() {
        guard let url = URL(string: track.preview) else { return }
        audioManager.startPlayer(track: url)
    }
    
    func pausePlay() {
        isPlaying = audioManager.pausePlay()
    }
    
    func configureSubscribers() {
        audioManager.$didEndPlaying
            .receive(on: DispatchQueue.main)
            .sink { [weak self] didEndPlaying in
                if didEndPlaying {
                    self?.isPlaying = false
                }
            }
            .store(in: &bag)
    }
}
