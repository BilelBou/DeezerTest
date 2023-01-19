//
//  DZRArtist.swift
//  DeezerExerciseSwiftUI
//
//  Created by Bilel Bouricha on 18/01/2023.
//

import Foundation

struct ArtistsData: Decodable {
    let artists: [DZRArtist]
    
    init(artists: [DZRArtist]) {
        self.artists = artists
    }
    
    enum CodingKeys: String, CodingKey {
        case artists = "data"
    }
}

struct DZRArtist: Decodable {
    let id: Int
    let name: String
    let picture: String?
    let tracklist: String?
    
    init(id: Int, name: String, picture: String?, tracklist: String? = nil) {
        self.id = id
        self.name = name
        self.picture = picture
        self.tracklist = tracklist
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case picture = "picture_big"
        case tracklist = "tracklist"
    }
}

extension DZRArtist {
    static func mock() -> DZRArtist {
        .init(id: 5, name: "Jamiroquai", picture: "jamiroquai")
    }
    
    static func mocks() -> [DZRArtist] {
        [.init(id: 1, name: "The Beatles", picture: "beatles"),
         .init(id: 2, name: "Manu Chao", picture: "manuchao"),
         .init(id: 3, name: "Metallica", picture: "metallica"),
         .init(id: 4, name: "Nirvana", picture: "nirvana"),
        ]
    }
}

extension ArtistsData {
    static func mock() -> ArtistsData {
        .init(artists: [.mock()])
    }
    
    static func mocks() -> ArtistsData {
        .init(artists: DZRArtist.mocks())
    }
}
