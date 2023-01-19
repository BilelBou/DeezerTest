//
//  ContentView.swift
//  DeezerExerciseSwiftUI
//
//  Created by Gilles Bordas on 30/11/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = SearchViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.artists, id: \.id) { artist in
                        ImageCellView(artist: artist)
                    }
                }
            }.navigationTitle("Discover new Artists")
        }
        .accentColor(Color.gray)
        .searchable(text: $viewModel.searchText)
        .onChange(of: viewModel.searched) { searchText in
            viewModel.search(searchText)
        }
    }
}

struct ImageCellView: View {
    @State private var openDetails = false
    var artist: DZRArtist
    var body: some View {
        Button {
            openDetails = true
        } label: {
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: artist.picture ?? "placeholder")) { image in
                    image
                        .resizable()
                } placeholder: {
                    Image("placeholder")
                }
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                Text(artist.name)
                    .font(.title3)
            }
        }
        .background(
            NavigationLink("", isActive: $openDetails) {
                ArtistDetailsView(viewModel: DetailsViewModel(artist: artist))
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: SearchViewModel())
    }
}
