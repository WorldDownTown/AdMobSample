//
//  UIView+Extension.swift
//  AdMobSample
//
//  Created by shoji on 2016/06/15.
//  Copyright © 2016年 com.shoji. All rights reserved.
//

import UIKit

extension UIView {

    func addConstraintsForAllEdgesWithItem(view: UIView) {

        view.translatesAutoresizingMaskIntoConstraints = false

        let top = NSLayoutConstraint(
            item: view,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Top,
            multiplier: 1.0,
            constant: 0.0)

        let bottom = NSLayoutConstraint(
            item: self,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 0.0)

        let left = NSLayoutConstraint(
            item: view,
            attribute: .Leading,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Leading,
            multiplier: 1.0,
            constant: 0.0)

        let right = NSLayoutConstraint(
            item: self,
            attribute: .Trailing,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Trailing,
            multiplier: 1.0,
            constant: 0.0)

        let constraints = [top, bottom, left, right]

        addConstraints(constraints)
    }
}
