//
//  PlayerView.swift
//  DeezerExerciseSwiftUI
//
//  Created by Bilel Bouricha on 18/01/2023.
//

import AVFoundation
import Foundation
import SwiftUI

struct PlayerView: View {
    @StateObject var viewModel: PlayerViewModel
    @State private var value: Double = 0.0
    var foreverAnimation: Animation {
        Animation.linear(duration: 4.0)
            .repeatForever(autoreverses: false)
    }
    
    let timer = Timer
        .publish(every: 0.1, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        VStack(spacing: 30) {
            ZStack {
                

                
                AsyncImage(url: URL(string: viewModel.album.cover)) { image in
                    image
                        .resizable()
                        .rotationEffect(Angle(degrees: viewModel.isPlaying ? 360 : 0.0))
                        .animation(viewModel.isPlaying ? foreverAnimation : .default)
                        .onAppear { viewModel.isPlaying = true }
                        .scaledToFit()
                    
                } placeholder: {
                    Image("placeholder")
                }
                
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.black)
            }

            .frame(width: 400, height: 400)
            .clipShape(Circle())

            Text(viewModel.track.title)
                .font(.title2)
            Spacer()
 
            if let player = viewModel.audioManager.player {
            
                VStack(spacing: 10) {
                    Slider(value: $value, in: 0...29) { editing in
                        if !editing {
                            player.seek(to: CMTimeMake(value: Int64(value), timescale: 1))
                        }
                    }
                    .accentColor(Color.primary)
                    HStack {
                        Text("0:00")
                        Spacer()
                        Text("0:" + String(player.currentTime().seconds.rounded()))
                    }
                    .font(.caption)
                    
                    HStack {
                        PlayerControlButton(systemName: "repeat") {
                            
                        }
                        
                        Spacer()
                        
                        PlayerControlButton(systemName: "gobackward.10") {
                            player.seek(to: CMTimeMake(value: Int64(player.currentTime().seconds - 10), timescale: 1))
                        }
                        
                        Spacer()
                        
                        
                        PlayerControlButton(systemName: viewModel.isPlaying  ? "pause.circle.fill" : "play.circle.fill", fontSize: 44) {
                            viewModel.pausePlay()
                        }
                        
                        Spacer()
                        
                        
                        PlayerControlButton(systemName: "goforward.10") {
                            player.seek(to: CMTimeMake(value: Int64(player.currentTime().seconds + 10), timescale: 1))
                        }
                        
                        Spacer()
                        
                        
                        PlayerControlButton(systemName: "stop.fill") {
                            
                        }
                    }
                }
                .padding(20)
            }
        }
        .onReceive(timer) { _ in
            guard let player = viewModel.audioManager.player else { return }
            value = player.currentItem?.currentTime().seconds ?? 0
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(viewModel: PlayerViewModel(track: .mock(), album: .mock()))
            .preferredColorScheme(.dark)
    }
}
