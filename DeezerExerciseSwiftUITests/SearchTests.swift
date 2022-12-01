//
//  SearchTests.swift
//  DeezerExerciseSwiftUITests
//
//  Created by Pierre Chardonneau on 01/12/2021.
//

@testable import DeezerExerciseSwiftUI

import XCTest

class SearchTests: XCTestCase {
    let baseUrl = "http://api.deezer.com/search/artist"
    
    final class MockRequester: Requester {
        var artistsMocked = [DZRArtist]()
        var inputUrl: URL?
        
        func searchArtist(url: URL, completion: @escaping ([DZRArtist]) -> ()) {
            inputUrl = url
            
            DispatchQueue.global(qos: .background).async {
                completion(self.artistsMocked)
            }
        }
    }
    
    func testUrlNoCrash() {
        let requester = MockRequester()
        
        search("NoCrash", requester: requester, completion: { _ in })
        
        XCTAssertEqual(requester.inputUrl?.absoluteString, "\(baseUrl)?q=NoCrash")
    }
    
    func testUrlThe_Crash() {
        let requester = MockRequester()
        
        search("The Crash", requester: requester, completion: { _ in })
        
        XCTAssertEqual(requester.inputUrl?.absoluteString, "\(baseUrl)?q=The Crash")
    }
    
    func testResult() throws {
        let requester = MockRequester()
        requester.artistsMocked = DZRArtist.mocks()
        
        var result: [DZRArtist]?
        search("NoCrash", requester: requester) { artists in
            result = artists
        }
        
        XCTAssertEqual(result!.count, 4)
    }
}
