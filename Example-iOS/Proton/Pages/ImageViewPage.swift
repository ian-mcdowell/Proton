//
//  ImageViewPage.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 4/12/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Proton

class ImageViewPage: Page {

    override func layout() -> ProtonView {
        return ImageView().construct { view in
            
            // Fetch the images (each image is of the format image_animal_number).
            view.animationImages = (1...5).map { UIImage(named: "image_animal_\($0)")! }
            
            // We want the image to be scaled to the correct aspect ratio within imageView's bounds.
            view.contentMode = .ScaleAspectFit
            
            /*
             If the image does not have the same aspect ratio as imageView's bounds,
             then imageView's backgroundColor will be applied to the "empty" space.
             */
            view.backgroundColor = UIColor.whiteColor()
            
            view.animationDuration = 5
            view.startAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ImageView"
    }
}