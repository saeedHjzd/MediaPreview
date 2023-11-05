//
//  DetailView.swift
//  MediaPreview
//
//  Created by Saeed on 8/14/1402 AP.
//

import SwiftUI

struct DetailView: View {
    let media: Media
    
    var body: some View {
        Text("DetailsView")
            .multilineTextAlignment(.center)
            .onAppear(perform: {
                if media.mediaType == . video {
                    print("Playing video with URL: ", media.mediaLink)
                }else {
                    print("Presenting image with URL: ", media.mediaLink)
                }
        })
    }
}


#Preview {
    DetailView(media: Media(title: "", previewLink: "", mediaLink: "", type: ""))
}
