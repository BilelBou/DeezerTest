//
//  DetailsViewModel.swift
//  DeezerExerciseSwiftUI
//
//  Created by Bilel Bouricha on 18/01/2023.
//

import Foundation

final class DetailsViewModel: ObservableObject {
    var artist: DZRArtist
    @Published var album: DZRAlbum = .mock()
    @Published var albumTrackList: [DZRAlbumTrackList] = []
    
    let audioManager = AudioManager()
    
    init(artist: DZRArtist) {
        self.artist = artist
    }
    
    func getAlbums(requester: Requester = Manager()) {
        guard let tracklist = artist.tracklist, let url = URL(string: tracklist) else { return }
        requester.getAlbums(url: url) { result in
            switch result {
            case .success(let success):
                guard let album = success.tracklist.first?.album, let url = URL(string: album.tracklist) else { return }
                self.getAlbumTrackList(url: url)
                DispatchQueue.main.async {
                    self.album = album
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func getAlbumTrackList(url: URL, requester: Requester = Manager()) {
        requester.getAlbumTrackList(url: url) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.albumTrackList = success.albumTrackList
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func playMusic(url: URL) {
        audioManager.startPlayer(track: url)
    }
}
