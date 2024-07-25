//
//  AsyncImageView.swift
//  MyAnimVue
//
//  Created by Олег Романов on 25.07.2024.
//

import UIKit

var asyncImagesCachArray = NSCache<NSString, UIImage>()

final class AsyncImageView: UIImageView {
    
    private var currentURL: NSString?
    
    func loadAsyncFrom(url: String, placeholder: UIImage?) {
        let imageURL = url as NSString
        
        if let cachedImage = asyncImagesCachArray.object(forKey: imageURL) {
            image = cachedImage
            return
        }
        
        image = placeholder
        currentURL = imageURL
        
        guard let requestURL = URL(string: url) else {
            image = placeholder
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                if error == nil {
                    if let imageData = data {
                        if self.currentURL == imageURL {
                            if let imageToPresent = UIImage(data: imageData) {
                                asyncImagesCachArray.setObject(imageToPresent, forKey: imageURL)
                                self.image = imageToPresent
                            } else {
                                self.image = placeholder
                            }
                        }
                    } else {
                        self.image = placeholder
                    }
                } else {
                    self.image = placeholder
                }
            }
        }.resume()
    }
}
