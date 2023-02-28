//
//  UIView++.swift
//  Core
//
//  Created by xuanbach on 01/07/2022.
//

import UIKit

extension UIView {
    public func allSubviews() -> [UIView] {
        var allSubviews = subviews
        for subview in subviews {
            allSubviews.append(contentsOf: subview.allSubviews())
        }
        return allSubviews
    }
}
