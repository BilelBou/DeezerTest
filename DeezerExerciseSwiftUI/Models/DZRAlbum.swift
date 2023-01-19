//
//  DZRAlbum.swift
//  DeezerExerciseSwiftUI
//
//  Created by Bilel Bouricha on 18/01/2023.
//

import Foundation

struct AlbumsData: Decodable {
    let tracklist: [DZRTrackList]
    
    init(tracklist: [DZRTrackList]) {
        self.tracklist = tracklist
    }
    
    enum CodingKeys: String, CodingKey {
        case tracklist = "data"
    }
}

struct DZRAlbum: Decodable {
    var id: Int
    var title: String
    var tracklist: String
    var cover: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case tracklist = "tracklist"
        case cover = "cover_big"
    }
}

struct DZRTrackList: Decodable {
    var album: DZRAlbum
}

extension DZRAlbum {
    static func mock() -> DZRAlbum {
        .init(id: 1, title: "Hello World", tracklist: "", cover: "")
    }
}

extension AlbumsData {
    static func mock() -> AlbumsData {
        .init(tracklist: [.mock()])
    }
}

extension DZRTrackList {
    static func mock() -> DZRTrackList {
        .init(album: .mock())
    }
}
