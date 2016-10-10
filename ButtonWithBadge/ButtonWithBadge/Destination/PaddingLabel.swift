//
//  PaddingLabel.swift
//  Tap
//
//  Created by Alexandr on 6/8/16.
//  Copyright © 2016 f17y. All rights reserved.
//

import UIKit

class PaddingLabel: UILabel {
	
	let padding = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
	
	override func drawTextInRect(rect: CGRect) {
		super.drawTextInRect(UIEdgeInsetsInsetRect(rect, padding))
	}
	
	// Override -intrinsicContentSize: for Auto layout code
	override func intrinsicContentSize() -> CGSize {
		let superContentSize = super.intrinsicContentSize()
		let width = superContentSize.width + padding.left + padding.right
		let heigth = superContentSize.height + padding.top + padding.bottom
		return CGSize(width: width, height: heigth)
	}
	
	// Override -sizeThatFits: for Springs & Struts code
	override func sizeThatFits(size: CGSize) -> CGSize {
		let superSizeThatFits = super.sizeThatFits(size)
		let width = superSizeThatFits.width + padding.left + padding.right
		let heigth = superSizeThatFits.height + padding.top + padding.bottom
		return CGSize(width: width, height: heigth)
	}
	
}
