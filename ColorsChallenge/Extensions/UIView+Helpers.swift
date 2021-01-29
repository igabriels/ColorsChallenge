//
//  UIView+Helpers.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 28/01/21.
//

import UIKit

extension UIView {
    func showLoadingView() {
        let view = UIView(frame: bounds)
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.25)
        view.tag = 10000
        
        let loadingIndicatorView = UIActivityIndicatorView(style: .medium)
        loadingIndicatorView.tintColor = .white
        loadingIndicatorView.center = view.center
        loadingIndicatorView.startAnimating()
        loadingIndicatorView.hidesWhenStopped = true
        view.addSubview(loadingIndicatorView)
        
        addSubview(view)
    }
    
    func removeLoadingView() {
        let loaderView = viewWithTag(10000)
        loaderView?.removeFromSuperview()
    }
}
