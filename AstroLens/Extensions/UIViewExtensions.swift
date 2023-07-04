//
//  UIViewExtensions.swift
//  AstroLens
//
//  Created by Jeremy Leworthy on 2023-03-05.
//

import UIKit

extension UIView {
	
	func height(constant: CGFloat,
				equality: NSLayoutConstraint.Relation = .equal,
				priority: UILayoutPriority = .required) -> NSLayoutConstraint {
		
		let height = NSLayoutConstraint(item: self,
										attribute: .height,
										relatedBy: equality,
										toItem: nil,
										attribute: .notAnAttribute,
										multiplier: 1,
										constant: constant)
		height.priority = priority
		return height
	}
	
	func width(constant: CGFloat,
			   equality: NSLayoutConstraint.Relation = .equal,
			   priority: UILayoutPriority = .required) -> NSLayoutConstraint {
		
		let width = NSLayoutConstraint(item: self,
									   attribute: .width,
									   relatedBy: equality,
									   toItem: nil,
									   attribute: .notAnAttribute,
									   multiplier: 1,
									   constant: constant)
		width.priority = priority
		return width
	}
}
