//
//  Loader.swift
//  LoaderTest
//
//  Created by anoop mohanan.
//  Copyright © 2017 anoop. All rights reserved.
//

import Foundation
import UIKit

final class LoadingOverlay {
    private var overlayView = UIView()
    private var activityIndicator = UIActivityIndicatorView()
    private var bgView = UIView()
    private weak var parentView: UIView!
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }

    public func showOverlay(view: UIView) {
        parentView = view
        bgView.frame = view.frame
        bgView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        bgView.addSubview(overlayView)
        bgView.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleHeight, .flexibleWidth]
        overlayView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        overlayView.center = view.center
        overlayView.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin]
        overlayView.backgroundColor = UIColor.black
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10

        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .whiteLarge
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)

        overlayView.addSubview(activityIndicator)
        view.addSubview(bgView)
        activityIndicator.startAnimating()
    }

    public func hideOverlayView() {
        activityIndicator.stopAnimating()
        if parentView != nil {
            if parentView.subviews.contains(bgView) {
                bgView.removeFromSuperview()
            }
        }
    }
}
