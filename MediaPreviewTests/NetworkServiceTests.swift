//
//  MediaPreviewTests.swift
//  MediaPreviewTests
//
//  Created by Saeed on 8/14/1402 AP.
//

import XCTest
import Combine
@testable import MediaPreview

final class NetworkServiceTests: XCTestCase {
    
    var networkService: NetworkService!
    var cancellableSet: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        networkService = NetworkService()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchMediaList() {
        let expectation = XCTestExpectation(description: "Fetching media list")
        
        let cancellable = networkService.fetchMediaList()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    //Test pass if network request finish successfully
                    expectation.fulfill()
                case .failure(let error):
                    //Test fail if networ request fail with error
                    XCTFail("Error: \(error)")
                }
            }, receiveValue: { _ in

            })
        
        cancellable.store(in: &cancellableSet)
        wait(for: [expectation], timeout: 5)
    }
    
    func testDownloadImage() {
        let imageURL = "https://wallpapershome.com/images/pages/ico_h/25371.jpg"
        let imageExpectation = XCTestExpectation(description: "Downloading image")

        let cancellable = networkService.downloadImage(from: imageURL)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    imageExpectation.fulfill()
                case .failure(let error):
                    XCTFail("Error: \(error)")
                }
            }, receiveValue: { image in
                XCTAssertNotNil(image, "Downloaded img shouldnt be nil")
            })

        cancellable.store(in: &cancellableSet)
        wait(for: [imageExpectation], timeout: 5)
    }

    
}
