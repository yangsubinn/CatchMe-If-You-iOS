//
//  UIImageView+Extension.swift
//  CatchMe
//
//  Created by Thisisme Hi on 2021/07/15.
//

import UIKit

import Kingfisher

extension UIImageView {
    func imageFromURL(url: String) {
        let url = URL(string: url)
        self.kf.setImage(with: url)
    }
}

extension UIImage {
    func resizeWith(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(
            frame: CGRect(origin: .zero,
                          size: CGSize(width: size.width * percentage,
                                       height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    func resizeWith(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(
            frame: CGRect(origin: .zero,
                          size: CGSize(width: width,
                                       height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}
