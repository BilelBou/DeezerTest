//
//  ArtistDetailsView.swift
//  DeezerExerciseSwiftUI
//
//  Created by Gilles Bordas on 30/11/2021.
//

import SwiftUI

struct ArtistDetailsView: View {
    @StateObject var viewModel: DetailsViewModel
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        VStack(spacing: 24) {
            DetailsHeader(viewModel: viewModel)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    Text(viewModel.album.title)
                        .font(.title)
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.albumTrackList, id: \.id) { track in
                            DetailsAlbumList(viewModel: viewModel, track: track)
                        }
                    }
                }
            }
        }
        
        .onAppear {
            viewModel.getAlbums()
        }
    }
}

struct DetailsHeader: View {
    @StateObject var viewModel: DetailsViewModel
    
    var body: some View {
        AsyncImage(url: URL(string: viewModel.album.cover)) { image in
            image
                .resizable()
        } placeholder: {
            Image("placeholder")
        }
        .scaledToFit()
        .frame(height: 200)
        .clipShape(Circle())
    }
}

struct DetailsAlbumList: View {
    @StateObject var viewModel: DetailsViewModel
    var track: DZRAlbumTrackList
    @State private var openPlayer = false
    
    var body: some View {
        HStack {
            Text(track.title)
            Image(systemName: "play")
                .resizable()
                .frame(width: 10, height: 10)
        }
        .background(
            NavigationLink("", isActive: $openPlayer) {
                PlayerView(viewModel: PlayerViewModel(track: track, album: viewModel.album))
            })
        .onTapGesture {
            openPlayer = true
        }
    }
}

struct ArtistDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistDetailsView(viewModel: DetailsViewModel(artist: DZRArtist.mock()))
    }
}
