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
        return ImageView(UIImage(named: "image_animal_1")).construct { view in
            
//            view.contentMode = .ScaleAspectFit

            view.backgroundColor = UIColor.whiteColor()

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ImageView"
    }
}