//
//  UIImageView+Extensions.swift
//  MercadoLibre
//
//  Created by Juan on 17/06/22.
//

import Foundation
import UIKit

// Used to image cache
private let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func download(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                imageCache.setObject(image, forKey: url.absoluteString as NSString)
            }
        }.resume()
    }
    
    func download(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        var completeLink = link.replacingOccurrences(of: "http://", with: "https://")
        completeLink = completeLink.replacingOccurrences(of: "-I", with: "-O")
        
        if let cachedImage = imageCache.object(forKey: completeLink as NSString) {
            image = cachedImage
        }
        guard let url = URL(string: completeLink) else { return }
        download(from: url, contentMode: mode)
    }
}
