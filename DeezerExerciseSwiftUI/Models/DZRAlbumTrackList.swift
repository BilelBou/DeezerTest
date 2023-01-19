//
//  DZRAlbumTrackList.swift
//  DeezerExerciseSwiftUI
//
//  Created by Bilel Bouricha on 18/01/2023.
//

import Foundation

struct AlbumTrackListData: Decodable {
    let albumTrackList: [DZRAlbumTrackList]
    
    init(albumTrackList: [DZRAlbumTrackList]) {
        self.albumTrackList = albumTrackList
    }
    
    enum CodingKeys: String, CodingKey {
        case albumTrackList = "data"
    }
}

struct DZRAlbumTrackList: Decodable {
    var id: Int
    var title: String
    var preview: String
}

extension DZRAlbumTrackList {
    static func mock() -> DZRAlbumTrackList {
        .init(id: 1, title: "Nice title", preview: "")
    }
}

extension AlbumTrackListData {
    static func mock() -> AlbumTrackListData {
        .init(albumTrackList: [.mock()])
    }
}
