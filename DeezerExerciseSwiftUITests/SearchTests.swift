//
//  SearchTests.swift
//  DeezerExerciseSwiftUITests
//
//  Created by Pierre Chardonneau on 01/12/2021.
//

@testable import DeezerExerciseSwiftUI
import Combine
import XCTest

class SearchTests: XCTestCase {
    let baseUrl = "https://api.deezer.com/search/artist"
    
    final class MockRequester: Requester {
        var inputUrl: URL?
        var artistsMocked = ArtistsData.mock()
        var albumMocked = AlbumsData.mock()
        var trackListMocked = AlbumTrackListData.mock()
        
        func searchArtist(url: URL, completion: @escaping (Result<DeezerExerciseSwiftUI.ArtistsData, Error>) -> ()) {
            inputUrl = url
            
            DispatchQueue.global(qos: .background).async {
                completion(.success(self.artistsMocked))
            }
        }
        
        func getAlbums(url: URL, completion: @escaping (Result<DeezerExerciseSwiftUI.AlbumsData, Error>) -> ()) {
            inputUrl = url
            
            DispatchQueue.global(qos: .background).async {
                completion(.success(self.albumMocked))
            }
        }
        
        func getAlbumTrackList(url: URL, completion: @escaping (Result<DeezerExerciseSwiftUI.AlbumTrackListData, Error>) -> ()) {
            inputUrl = url
            
            DispatchQueue.global(qos: .background).async {
                completion(.success(self.trackListMocked))
            }
        }
    }
    
    func testUrlNoCrash() {
        let requester = MockRequester()
        let searchViewModel = SearchViewModel()
        
        searchViewModel.search("NoCrash", requester: requester)
        
        XCTAssertEqual(requester.inputUrl?.absoluteString, "\(baseUrl)?q=NoCrash")
    }
    
    func testUrlThe_Crash() {
        let requester = MockRequester()
        let searchViewModel = SearchViewModel()
        
        searchViewModel.search("The Crash", requester: requester)
        
        XCTAssertEqual(requester.inputUrl?.absoluteString, "\(baseUrl)?q=The%20Crash")
    }
    
    func testResult() throws {
        let requester = MockRequester()
        requester.artistsMocked = ArtistsData.mocks()
        let searchViewModel = SearchViewModel()
        var bag = Set<AnyCancellable>()

        var result: [DZRArtist]?
        searchViewModel.search("NoCrash", requester: requester)
        searchViewModel.$artists
            .receive(on: DispatchQueue.main)
            .sink { artists in
                result = artists
                XCTAssertEqual(result!.count, 4)
            }
            .store(in: &bag)
        
    }
}
