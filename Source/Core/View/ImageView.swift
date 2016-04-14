//
//  ImageView.swift
//  Pods
//
//  Created by McDowell, Ian J [ITACD] on 4/12/16.
//
//

/// Wrapper for UIImageView.
public class ImageView: View<UIImageView> {
    
    public init(_ image: UIImage? = nil) {
        super.init()
        
        self.view.image = image
    }
    
}