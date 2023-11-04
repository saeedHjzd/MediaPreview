//
//  ContentView.swift
//  MediaPreview
//
//  Created by Saeed on 8/13/1402 AP.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        Image(systemName: "photo.artframe")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10)
    }
}

#Preview {
    ContentView()
}
