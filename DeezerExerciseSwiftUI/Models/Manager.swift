//
//  SearchManager.swift
//  DeezerExerciseSwiftUI
//
//  Created by Bilel Bouricha on 18/01/2023.
//

import Foundation

protocol Requester {
    func searchArtist(url: URL, completion: @escaping (Result<ArtistsData, Error>) -> ())
    func getAlbums(url: URL, completion:@escaping (Result<AlbumsData, Error>) -> ())
    func getAlbumTrackList(url: URL, completion:@escaping (Result<AlbumTrackListData, Error>) -> ())
}

class Manager: Requester {
    
    func searchArtist(url: URL, completion:@escaping (Result<ArtistsData, Error>) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let artists = try JSONDecoder().decode(ArtistsData.self, from: data)
                    completion(.success(artists))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }
        task.resume()
    }
    
    func getAlbums(url: URL, completion:@escaping (Result<AlbumsData, Error>) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let artists = try JSONDecoder().decode(AlbumsData.self, from: data)
                    completion(.success(artists))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }
        task.resume()
    }
    
    func getAlbumTrackList(url: URL, completion:@escaping (Result<AlbumTrackListData, Error>) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let artists = try JSONDecoder().decode(AlbumTrackListData.self, from: data)
                    completion(.success(artists))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }
        task.resume()
    }
}
