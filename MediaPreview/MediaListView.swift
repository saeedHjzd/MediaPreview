//
//  ContentView.swift
//  MediaPreview
//
//  Created by Saeed on 8/13/1402 AP.
//

import SwiftUI

struct MediaListView: View {
    
    @ObservedObject var viewModel: ImageListViewModel
    
    var body: some View {
        //TODO: - Add Tests
        
        NavigationView{
            List {
                ForEach(viewModel.mediaList, id: \.self) { media in
                    ZStack {
                        NavigationLink(destination: DetailView(media: media)) {
                            EmptyView()
                        }.opacity(0)
                        MediaRowView(media: media, viewModel: viewModel)
                    }
                }
                .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
            
        }
    }
}


#Preview {
    MediaListView(viewModel: ImageListViewModel(networkService: NetworkService()))
}

struct MediaRowView: View {
    
    let media: Media
    @ObservedObject var viewModel: ImageListViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            if let image = viewModel.images[media.previewLink] {
                MediaView(image: image, title: media.title)
            } else {
                Image(systemName: "photo.artframe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
                    .onAppear {
                        viewModel.downloadImages(at: media.previewLink)
                    }
                ProgressView()
            }
        }
        .frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
    }
}

struct MediaView: View {
    
    let image: UIImage
    let title: String
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(20)
            .overlay(alignment: .bottom) {
                Color.white
                    .opacity(0.6)
                    .frame(height: 30)
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
            }
    }
}
