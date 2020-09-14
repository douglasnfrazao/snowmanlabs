//
//  UIView.swift
//  snowmanlabs
//
//  Created by douglas.nunes on 14/09/20.
//  Copyright © 2020 douglas nunes. All rights reserved.
//

import UIKit

public extension UIView {
    
    func width(anchor: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0) -> UIView {
        widthAnchor.constraint(equalTo: anchor, multiplier: multiplier, constant: constant).isActive = true
        return self
    }
    
    func height(anchor: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0) -> UIView {
        widthAnchor.constraint(equalTo: anchor, multiplier: multiplier, constant: constant).isActive = true
        return self
    }
    
    func width(constant: CGFloat) -> UIView {
        widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    func height(constant: CGFloat) -> UIView {
        heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    func center(_ centerY: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> UIView {
        centerYAnchor.constraint(equalTo: centerY, constant: constant).isActive = true
        return self
    }
    
    func center(_ centerX: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> UIView {
        centerXAnchor.constraint(equalTo: centerX, constant: constant).isActive = true
        return self
    }
    
    func top(anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> UIView {
        topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    func leading(anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> UIView {
        leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    func trailing(anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> UIView {
        trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    func bottom(anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> UIView {
        bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
}

public extension UIView {
    
    func constraint(first: NSLayoutAnchor<NSLayoutXAxisAnchor>, second: NSLayoutAnchor<NSLayoutXAxisAnchor>) -> NSLayoutConstraint? {
        return superview?.constraints.first(where: { $0.firstAnchor == first && $0.secondAnchor == second })
    }
    
    func constraint(first: NSLayoutAnchor<NSLayoutYAxisAnchor>, second: NSLayoutAnchor<NSLayoutYAxisAnchor>) -> NSLayoutConstraint? {
        return superview?.constraints.first(where: { $0.firstAnchor == first && $0.secondAnchor == second })
    }
    
    func widthConstraint() -> NSLayoutConstraint? {
        return constraints.first(where: { $0.firstAnchor.hashValue == widthAnchor.hashValue })
    }
    
    func heightConstraint() -> NSLayoutConstraint? {
        return constraints.first(where: { $0.firstAnchor.hashValue == heightAnchor.hashValue })
    }
    
    func constraint(id: String) -> NSLayoutConstraint? {
        if let constraint = superview?.constraints.first(where: { $0.identifier == id }) {
            return constraint
        }
        return constraints.first(where: { $0.identifier == id })
    }
}
