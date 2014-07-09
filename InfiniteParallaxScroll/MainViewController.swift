//
//  MainViewController.swift
//  InfiniteParallaxScroll
//
//  Created by Josh Chung on 7/9/14.
//  Copyright (c) 2014 minorblend. All rights reserved.
//

import UIKit

let PAGE_COUNT: CGFloat = 30

class MainViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet var pageIndexLabel: UILabel
    let scrollView: UIScrollView
    let firstPage: PageView
    let secondPage: PageView
    let thirdPage: PageView
    var currentPage: Int = 0 {
    didSet {
        self.updatePages()
    }
    }

    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        scrollView = UIScrollView()
        firstPage = PageView(frame: CGRectZero)
        secondPage = PageView(frame: CGRectZero)
        thirdPage = PageView(frame: CGRectZero)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.insertSubview(self.scrollView, belowSubview: self.pageIndexLabel)
        self.scrollView.delegate = self
        self.scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.scrollView.pagingEnabled = true
        self.scrollView.backgroundColor = UIColor.blackColor()
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["view": self.scrollView]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["view": self.scrollView]))
        
        firstPage.backgroundImage = UIImage(named: "1")
        self.scrollView.addSubview(firstPage)
        
        secondPage.backgroundImage = UIImage(named: "2")
        self.scrollView.addSubview(secondPage)
        
        thirdPage.backgroundImage = UIImage(named: "3")
        self.scrollView.addSubview(thirdPage)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * PAGE_COUNT,
            CGRectGetHeight(self.scrollView.frame))
        
        self.updatePages()
    }
    
    func updatePages() {
        var frame = self.view.bounds
        var width = CGRectGetWidth(frame)
        var x = Double(self.currentPage) * width
        frame.origin.x = x - width
        switch (self.currentPage % 3) {
        case 0: // 3-(1)-2
            if CGRectGetMinX(frame) >= 0 {
                thirdPage.frame = frame
            }
            frame.origin.x = x
            firstPage.frame = frame
            frame.origin.x += width
            if CGRectGetMinX(frame) < self.scrollView.contentSize.width {
                secondPage.frame = frame
            }
        case 1: // 1-(2)-3
            if CGRectGetMinX(frame) >= 0 {
                firstPage.frame = frame
            }
            frame.origin.x = x
            secondPage.frame = frame
            frame.origin.x += width
            if CGRectGetMinX(frame) < self.scrollView.contentSize.width {
                thirdPage.frame = frame
            }
        case _: // 2-(3)-1
            if CGRectGetMinX(frame) >= 0 {
                secondPage.frame = frame
            }
            frame.origin.x = x
            thirdPage.frame = frame
            frame.origin.x += width
            if CGRectGetMinX(frame) < self.scrollView.contentSize.width {
                firstPage.frame = frame
            }
        }
        
        self.pageIndexLabel.text = "\(self.currentPage + 1)"
    }

    // UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        self.currentPage = Int(round(self.scrollView.contentOffset.x / CGRectGetWidth(self.scrollView.bounds)))
        
        self.firstPage.contentOffsetX = self.scrollView.contentOffset.x
        self.secondPage.contentOffsetX = self.scrollView.contentOffset.x
        self.thirdPage.contentOffsetX = self.scrollView.contentOffset.x
    }
}
