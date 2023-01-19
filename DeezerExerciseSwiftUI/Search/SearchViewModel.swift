//
//  ArtisteViewModel.swift
//  DeezerExerciseSwiftUI
//
//  Created by Bilel Bouricha on 18/01/2023.
//

import Combine
import Foundation

final class SearchViewModel: ObservableObject {
    @Published var artists = [DZRArtist]()
    @Published var searchText: String = ""
    @Published var searched: String = ""
    @Published var openDetails: Bool = false
    private var bag = Set<AnyCancellable>()
    
    public init(dueTime: TimeInterval = 0.2) {
        $searchText
            .removeDuplicates()
            .debounce(for: .seconds(dueTime), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                self?.searched = value
            })
            .store(in: &bag)
    }
    
    func search(_ searchText: String, requester: Requester = Manager()) {
        let originalString = "https://api.deezer.com/search/artist?q=" + searchText
        guard let urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        guard let url = URL(string: urlString) else { return }
        requester.searchArtist(url: url) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.artists = data.artists
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.artists = []
                }
            }
        }
    }
    
}
