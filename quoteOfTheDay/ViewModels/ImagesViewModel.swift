//
//  ImagesViewModel.swift
//  quoteOfTheDay
//
//  Created by Artem on 24/06/2023.
//

import Foundation


class ImagesViewModel: ObservableObject {
    var imageLoader = ImageLoader()
    var router = Router()
    
    @Published var imageLoadingError: ImageLoadingError? = nil
    @Published var imageURLs: [String] = []
    @Published var fetchedPhotos: [Photo]? = nil
    @Published var imagesDidLoad: Bool = false
    
    
    private func fetchImage() async throws {
        do {
            let loadedImagesPexel = try await imageLoader.loadImage()
            DispatchQueue.main.async {
                self.fetchedPhotos = loadedImagesPexel?.photos
                self.imagesDidLoad = false
                guard let fetchedPhotos = self.fetchedPhotos else { return }
                for i in 0...50 {
                    let fetchedPhoto = fetchedPhotos[i].src.landscape
                    guard let unwrappedURLPhoto =  fetchedPhoto else { return }
                    self.imageURLs.append(unwrappedURLPhoto)
                }
                self.imagesDidLoad = true
            }
        } catch let error as ImageLoadingError {
            DispatchQueue.main.async {
                    self.imageLoadingError = error
                print("error fetching")
            }
        } catch {
            DispatchQueue.main.async {
                self.imageLoadingError = ImageLoadingError.badDecoding
            }
        }
    }

    
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
