//
//  MediaPreviewApp.swift
//  MediaPreview
//
//  Created by Saeed on 8/13/1402 AP
//

import SwiftUI

@main
struct MediaPreviewApp: App {
    var body: some Scene {
        WindowGroup {
            MediaListView(viewModel: MediaListViewModel(networkService: NetworkService()))
        }
    }
}
