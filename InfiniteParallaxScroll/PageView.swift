//
//  PageView.swift
//  InfiniteParallaxScroll
//
//  Created by Josh Chung on 7/9/14.
//  Copyright (c) 2014 minorblend. All rights reserved.
//

import UIKit

class PageView: UIView {
    let backgroundImageView: UIImageView
    var backgroundImage: UIImage? {
    didSet {
        backgroundImageView.image = backgroundImage
    }
    }
    var contentOffsetX: CGFloat = 0 {
    didSet {
        var frame = self.backgroundImageView.frame
        frame.origin.x = (self.contentOffsetX - CGRectGetMinX(self.frame)) / 2.0
        self.backgroundImageView.frame = frame
    }
    }

    init(frame: CGRect) {
        backgroundImageView = UIImageView()
        super.init(frame: frame)
        
        self.clipsToBounds = true
        backgroundImageView.frame = self.bounds
        backgroundImageView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.addSubview(backgroundImageView)
    }
}
