//
//  ContentView.swift
//  MediaPreview
//
//  Created by Saeed on 8/13/1402 AP.
//

import SwiftUI

struct MediaListView: View {
    
    @ObservedObject var viewModel: MediaListViewModel
    
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
    MediaListView(viewModel: MediaListViewModel(networkService: NetworkService()))
}




