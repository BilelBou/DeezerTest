//
//  ContentView.swift
//  DeezerExerciseSwiftUI
//
//  Created by Gilles Bordas on 30/11/2021.
//

import SwiftUI

struct ContentView: View {
    @State var artists = [DZRArtist]()
    @State var searchText: String = ""
    @State var openDetails: Bool = false
    let columns = [GridItem(.adaptive(minimum: 60))]

    var body: some View {
        NavigationView {
            LazyVGrid(columns: columns) {
                ForEach(artists, id: \.identifier) { artist in
                    NavigationLink("", isActive: $openDetails) {
                        ArtistDetailsView(artist: artist)
                    }
                    Button {
                        openDetails = true
                    } label: {
                        VStack {
                            artist.picture ?? Image("placeholder")
                            Text(artist.name)
                        }
                    }
                }
            }.navigationTitle("Discover new Artists")
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { searchText in
            search(searchText) {
                artists = $0
            }
        }
    }
}

func search(_ searchText: String, requester: Requester = ApiRequester(), completion: @escaping ([DZRArtist]) -> ()) {
    let requestURL = URL(string: "http://api.deezer.com/search/artist?q=" + searchText)!
    requester.searchArtist(url: requestURL, completion: completion)
}

// MARK: - Requester
protocol Requester {
    func searchArtist(url: URL, completion: @escaping ([DZRArtist]) -> ())
}

class ApiRequester: Requester {
    func searchArtist(url: URL, completion: @escaping ([DZRArtist]) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
            if let data = json?["data"] as? [[String: Any]] {
                var matchingArtists = [DZRArtist]()
                for artistData in data {
                    print(artistData)
                    let artist = DZRArtist(identifier: String(artistData["id"] as? Int ?? 0),
                                           name: artistData["name"] as? String ?? "NA",
                                           picture: nil)
                    matchingArtists.append(artist)
                }
                completion(matchingArtists)
            }
        }
        task.resume()
    }
}

// MARK: - Model
struct DZRArtist/*: Decodable*/ {
    let identifier: String
    let name: String
    let picture: Image?
}

extension DZRArtist {
    static func mock() -> DZRArtist {
        .init(identifier: "5", name: "Jamiroquai", picture: Image("jamiroquai"))
    }
    
    static func mocks() -> [DZRArtist] {
        [.init(identifier: "1", name: "The Beatles", picture: Image("beatles")),
         .init(identifier: "2", name: "Manu Chao", picture: Image("manuchao")),
         .init(identifier: "3", name: "Metallica", picture: Image("metallica")),
         .init(identifier: "4", name: "Nirvana", picture: Image("nirvana")),
        ]
    }
}
