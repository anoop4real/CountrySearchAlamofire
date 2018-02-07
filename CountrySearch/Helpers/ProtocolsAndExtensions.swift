//
//  ProtocolsAndExtensions.swift
//  WorldCountriesSwift
//
//  Created by anoopm on 22/10/16.
//  Copyright © 2016 anoopm. All rights reserved.
//

import Foundation
import UIKit

//From :https://gist.github.com/gonzalezreal/92507b53d2b1e267d49a
protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UITableViewCell: ReusableView {
}

// MARK: - Segue Handler protocol
// https://www.natashatherobot.com/protocol-oriented-segue-identifiers-swift/
protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self:UIViewController, SegueIdentifier.RawValue == String {
    func performSegueWithIdentifier(segueIdentifier: SegueIdentifier,
                                    sender: AnyObject?) {

        performSegue(withIdentifier: segueIdentifier.rawValue, sender: sender)
    }

    func segueIdentifierForSegue(segue: UIStoryboardSegue) -> SegueIdentifier {

        // still have to use guard stuff here, but at least you're
        // extracting it this time
        guard let identifier = segue.identifier,
            let segueIdentifier = SegueIdentifier(rawValue: identifier) else {
                fatalError("Invalid segue identifier \(String(describing: segue.identifier)).") }

        return segueIdentifier
    }
}
extension UISearchBar {
    
    public var textField: UITextField? {
        let subViews = subviews.flatMap { $0.subviews }
        guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
            return nil
        }
        return textField
    }
    
    public var activityIndicator: UIActivityIndicatorView? {
        return textField?.leftView?.subviews.flatMap{ $0 as? UIActivityIndicatorView }.first
    }
    
    var isLoading: Bool {
        get {
            return activityIndicator != nil
        } set {
            if newValue {
                if activityIndicator == nil {
                    let newActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                    newActivityIndicator.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                    newActivityIndicator.startAnimating()
                    newActivityIndicator.backgroundColor = UIColor.white
                    textField?.leftView?.addSubview(newActivityIndicator)
                    let leftViewSize = textField?.leftView?.frame.size ?? CGSize.zero
                    newActivityIndicator.center = CGPoint(x: leftViewSize.width/2, y: leftViewSize.height/2)
                }
            } else {
                activityIndicator?.removeFromSuperview()
            }
        }
    }
}
