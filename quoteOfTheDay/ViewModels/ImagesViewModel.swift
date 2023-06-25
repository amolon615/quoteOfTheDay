//
//  ImagesViewModel.swift
//  quoteOfTheDay
//
//  Created by Artem on 24/06/2023.
//

import SwiftUI


class ImagesViewModel: ObservableObject {
    var imageLoader = ImageLoader()
    var router = Router()
    
    @Published var imageLoadingError: ImageLoadingError? = nil
    @Published var imageURLs: [String] = []
    @Published var fetchedPhotos: [Photo]? = nil
    @Published var imagesDidLoad: Bool = false
    

    
    //fetching the list of curated images
    private func fetchImage() async throws {
        do {
            let loadedImagesPexel = try await imageLoader.loadImage()
            DispatchQueue.main.async {
                self.fetchedPhotos = loadedImagesPexel?.photos
                self.imagesDidLoad = false
                guard let fetchedPhotos = self.fetchedPhotos else { return }
                //loading 50 image urls
                for i in 0...50 {
                    let fetchedPhoto = fetchedPhotos[i].src.landscape
                    guard let unwrappedURLPhoto =  fetchedPhoto else { return }
                    self.imageURLs.append(unwrappedURLPhoto)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeIn(duration: 1.5)) {
                        self.imagesDidLoad = true
                    }
                }
            }
        } catch let error as ImageLoadingError {
            DispatchQueue.main.async {
                    self.imageLoadingError = error
            }
        } catch {
            DispatchQueue.main.async {
                self.imageLoadingError = ImageLoadingError.badDecoding
            }
        }
    }

    //loading images
    func loadImages() {
        Task {
            do {
                try await fetchImage()
             
            } catch {
                DispatchQueue.main.async {
                    self.imageLoadingError = ImageLoadingError.badDecoding
                }
            }
        }
    }
}
