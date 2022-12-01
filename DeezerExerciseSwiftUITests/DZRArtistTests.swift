//
//  DZRArtistTests.swift
//  DeezerExerciseSwiftUITests
//
//  Created by Pierre Chardonneau on 01/12/2021.
//

@testable import DeezerExerciseSwiftUI

import XCTest

class DZRArtistTests: XCTestCase {

    private let artistData = """
    {
        "id":215,
        "name":"Toto",
        "link":"https://www.deezer.com/artist/215",
        "picture":"https://api.deezer.com/artist/215/image",
        "picture_small":"https://cdns-images.dzcdn.net/images/artist/50a60374b3e6fa17d61d7a06284e5154/56x56-000000-80-0-0.jpg",
        "picture_medium":"https://cdns-images.dzcdn.net/images/artist/50a60374b3e6fa17d61d7a06284e5154/250x250-000000-80-0-0.jpg",
        "picture_big":"https://cdns-images.dzcdn.net/images/artist/50a60374b3e6fa17d61d7a06284e5154/500x500-000000-80-0-0.jpg",
        "picture_xl":"https://cdns-images.dzcdn.net/images/artist/50a60374b3e6fa17d61d7a06284e5154/1000x1000-000000-80-0-0.jpg",
        "nb_album":28,
        "nb_fan":471246,
        "radio":true,
        "tracklist":"https://api.deezer.com/artist/215/top?limit=50",
        "type":"artist"
    }
    """.data(using: .utf8)!
    
    func testModelFromJsonData() throws {
        var artistJson: Any!
        XCTAssertNoThrow(artistJson = try JSONSerialization.jsonObject(with: artistData, options: []))
        
        guard let artistDict = artistJson as? [String: Any] else {
            XCTFail("Fail to cast artistJson into artistDict")
            return
        }
        
        let artist = DZRArtist(identifier: String(artistDict["id"] as? Int ?? 0),
                               name: artistDict["name"] as? String ?? "NA",
                               picture: nil)
        
        XCTAssertEqual(artist.identifier, "216")
        XCTAssertEqual(artist.name, "Toto")
//        XCTAssertEqual(artist.picture, "https://api.deezer.com/artist/215/image")
    }
}
