//
//  MediaListViewModelTests.swift
//  MediaPreviewTests
//
//  Created by Saeed on 8/14/1402 AP.
//

import XCTest
@testable import MediaPreview

final class MediaListViewModelTests: XCTestCase {
    
    var viewModel: MediaListViewModel!
    var networkService: NetworkService!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkService()
        viewModel = MediaListViewModel(networkService: networkService)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchImageURLs() {
        let expectation = XCTestExpectation(description: "Fetching image URLs")
        
        viewModel.fetchImageURLs()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertFalse(self.viewModel.mediaList.isEmpty, "mediaList should not empty")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }

    
    func testDownloadImages() {
        let imageURL = "https://wallpapershome.com/images/pages/ico_h/25371.jpg"
        viewModel.mediaList = [Media(title: "", previewLink: imageURL, mediaLink: "", type: "")]
        
        viewModel.downloadImages(at: imageURL)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertNotNil(self.viewModel.images[imageURL])
        }
        
        Thread.sleep(forTimeInterval: 3)
    }
    
}

