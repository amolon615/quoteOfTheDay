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
    
    //array of url of images, to be displayed in AsyncImages in cells
    @Published var imageURLs: [String] = []
    
    //array of Photo objects. Each object contain Src property, which hold all image qualities. In our case I fetch only 1 image quality.
    @Published var fetchedPhotos: [Photo]? = nil
    
    //buffer array to collect all images without pushing @Published array each time one url is added. Only when the whole array is populated with urls - we put it's value to our @Published fetchedPhotos array
    var bufferPhotosArray: [String] = []
    
    @Published var imagesDidLoad: Bool = false
    

    
    //fetching the list of curated images
    private func fetchImage() async throws {
        do {
            let loadedImagesPexel = try await imageLoader.loadImage()
            DispatchQueue.main.async {
                self.fetchedPhotos = loadedImagesPexel?.photos
                guard let fetchedPhotos = self.fetchedPhotos else { return }
                //loading 50 image urls
                for i in 0...40 {
                    let fetchedPhoto = fetchedPhotos[i].src.landscape
                    guard let unwrappedURLPhoto =  fetchedPhoto else { return }
                    self.bufferPhotosArray.append(unwrappedURLPhoto)
                }
                self.imageURLs = self.bufferPhotosArray
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
                DispatchQueue.main.async {
                    if self.imagesDidLoad == true {
                        withAnimation(.easeInOut(duration: 1.0)){
                            self.imagesDidLoad = false
                        }
                    }
                }
                try await fetchImage()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.easeIn(duration: 1.5)) {
                        self.imagesDidLoad = true
                    }
                }
             
            } catch {
                DispatchQueue.main.async {
                    self.imageLoadingError = ImageLoadingError.badDecoding
                }
            }
        }
    }
}
