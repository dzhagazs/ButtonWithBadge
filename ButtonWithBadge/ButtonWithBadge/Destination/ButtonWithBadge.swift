//
//  ButtonWithBadge.swift
//  Tap
//
//  Created by Alexandr on 6/8/16.
//  Copyright © 2016 f17y. All rights reserved.
//

import UIKit

let badgeHeight = 13.0

public enum BadgePosition {
	case topRight
	case topLeft
	case bottomRight
	case bottomLeft
}

public enum BadgeAnimationType {
	case bouncing
	case fade
}

public class ButtonWithBadge: UIButton {
	
	//MARK: - Private Properties
	
	private var value: Int = 0
	private var badgeLabel: UILabel
	private var badgeHeightConstraint: NSLayoutConstraint?
	private var badgeWidthConstraint: NSLayoutConstraint?
	private var badgePositionConstraints: [NSLayoutConstraint] = []
	private var position: BadgePosition = .topRight
	private var badgeIsLayouted: Bool = false
	private var textColor: UIColor = UIColor.whiteColor()
	private var badgeBgColor: UIColor = UIColor.init(red: 201.0/255.0, green: 39.0/255.0, blue: 93.0/255.0, alpha: 1.0)
	public var hidesBadgeIfZero: Bool = true
	
	public var badgeTextColor: UIColor {
		get {
			return textColor
		}
		
		set (newValue) {
			textColor = newValue
			badgeLabel.textColor = newValue
		}
	}
	
	public var badgeBackgroundColor: UIColor {
		get {
			return badgeBgColor
		}
		
		set (newValue) {
			badgeBgColor = newValue
			badgeLabel.backgroundColor = newValue
			badgeLabel.layer.borderColor = newValue.CGColor
		}
	}
	
	public var badgePosition: BadgePosition {
		get {
			return position
		}
		set (newPosition) {
			
			if newPosition != badgePosition {
				position = newPosition
				layoutBadgeLabel()
			}
		}
	}
	
	public var animationType: BadgeAnimationType = .bouncing
	
	//MARK: - Initialization
	
	override init(frame: CGRect) {
		badgeLabel = PaddingLabel.init(frame: CGRectZero)
		super.init(frame: frame)
		addSubview(badgeLabel)
		configureBadgeLabel()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		badgeLabel = PaddingLabel.init(frame: CGRectZero)
		super.init(coder: aDecoder)
		addSubview(badgeLabel)
		configureBadgeLabel()
	}
	
	public var badgeValue: Int {
		set(newValue) {
			
			value = newValue
			updateBadge()
		}
		get {
			return value
		}
	}
	
	public var badgeFontSize: CGFloat {
		get {
			return badgeLabel.font.pointSize
		}
		
		set(newValue) {
			badgeLabel.font = UIFont.systemFontOfSize(newValue)
			badgeLabel.sizeToFit()
			let newHeight = newValue * (13.0 / 10.0)
			badgeHeightConstraint?.constant = newHeight
			badgeWidthConstraint?.constant = newHeight
			badgeLabel.setNeedsLayout()
			badgeLabel.layoutIfNeeded()
			badgeLabel.layer.cornerRadius = badgeLabel.bounds.size.height / 2.0
		}
	}
	
	//MARK: - Configuration
	
	private func updateBadge() {
		//		badgeLabel = PaddingLabel.init(frame: CGRectZero)
		//		badgeLabel?.translatesAutoresizingMaskIntoConstraints = false
		//		badgeLabel?.textAlignment = NSTextAlignment.Center
		//		badgeLabel?.font = UIFont.systemFontOfSize(10)
		//		badgeLabel?.textColor = UIColor.whiteColor()
		//		badgeLabel?.backgroundColor = UIColor.init(red: 201.0/255.0, green: 39.0/255.0, blue: 93.0/255.0, alpha: 1.0)
		//		self.addSubview(badgeLabel!)
		//
		//		let heightConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .Height, relatedBy: .GreaterThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: CGFloat(badgeHeight))
		//		badgeLabel?.addConstraint(heightConstraint)
		//		let widthConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .Width, relatedBy: .GreaterThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: CGFloat(badgeHeight))
		//		badgeLabel?.addConstraint(widthConstraint)
		//		let trailingConstraint = NSLayoutConstraint(item: self, attribute: .Trailing, relatedBy: .Equal, toItem: badgeLabel!, attribute: .Trailing, multiplier: 1.0, constant: -5)
		//		self.addConstraint(trailingConstraint)
		//		let topConstraint = NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: badgeLabel!, attribute: .Top, multiplier: 1.0, constant: 5)
		//		self.addConstraint(topConstraint)
		//		badgeLabel?.layer.borderColor = UIColor.init(red: 201.0/255.0, green: 39.0/255.0, blue: 93.0/255.0, alpha: 1.0).CGColor
		//		badgeLabel?.layer.cornerRadius = CGFloat(badgeHeight/2.0)
		//		badgeLabel?.layer.borderWidth = 1.0
		//		badgeLabel?.clipsToBounds = true
		//		self.badgeTrailingConstraint = trailingConstraint
		//		self.badgeTopConstraint = topConstraint
		//		self.badgeWidthConstraint = widthConstraint
		badgeLabel.text = String(value)
	}
	
	func configureBadgeLabel() {
		badgeLabel.translatesAutoresizingMaskIntoConstraints = false
		badgeLabel.textAlignment = NSTextAlignment.Center
		badgeLabel.font = UIFont.systemFontOfSize(10)
		badgeLabel.textColor = badgeTextColor
		badgeLabel.backgroundColor = badgeBackgroundColor
		badgeLabel.layer.borderColor = badgeBackgroundColor.CGColor
		badgeLabel.layer.cornerRadius = CGFloat(badgeHeight/2.0)
		badgeLabel.layer.borderWidth = 1.0
		badgeLabel.clipsToBounds = true
	}
	
	//MARK: - Layout
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		
		if badgeIsLayouted == false {
			layoutBadgeLabel()
		}
	}
	
	private func layoutBadgeLabel() {
		
		for c in badgePositionConstraints {
			self.removeConstraint(c)
		}
		badgePositionConstraints = []
		switch badgePosition {
		case .topRight:
			let trailingConstraint = NSLayoutConstraint(item: self, attribute: .Trailing, relatedBy: .Equal, toItem: badgeLabel, attribute: .Trailing, multiplier: 1.0, constant: -5)
			self.addConstraint(trailingConstraint)
			let topConstraint = NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: badgeLabel, attribute: .Top, multiplier: 1.0, constant: 5)
			self.addConstraint(topConstraint)
			badgePositionConstraints = [trailingConstraint, topConstraint]
			break
			
		case .topLeft:
			let leadingConstraint = NSLayoutConstraint(item: self, attribute: .Leading, relatedBy: .Equal, toItem: badgeLabel, attribute: .Leading, multiplier: 1.0, constant: -5)
			self.addConstraint(leadingConstraint)
			let topConstraint = NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: badgeLabel, attribute: .Top, multiplier: 1.0, constant: 5)
			self.addConstraint(topConstraint)
			badgePositionConstraints = [leadingConstraint, topConstraint]
			break
			
		case .bottomLeft:
			let leadingConstraint = NSLayoutConstraint(item: self, attribute: .Leading, relatedBy: .Equal, toItem: badgeLabel, attribute: .Leading, multiplier: 1.0, constant: -5)
			self.addConstraint(leadingConstraint)
			let bottomConstraint = NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: badgeLabel, attribute: .Bottom, multiplier: 1.0, constant: 5)
			self.addConstraint(bottomConstraint)
			badgePositionConstraints = [leadingConstraint, bottomConstraint]
			break
			
		case .bottomRight:
			let trailingConstraint = NSLayoutConstraint(item: self, attribute: .Trailing, relatedBy: .Equal, toItem: badgeLabel, attribute: .Trailing, multiplier: 1.0, constant: -5)
			self.addConstraint(trailingConstraint)
			let bottomConstraint = NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: badgeLabel, attribute: .Bottom, multiplier: 1.0, constant: 5)
			self.addConstraint(bottomConstraint)
			badgePositionConstraints = [trailingConstraint, bottomConstraint]
			break
		}
		badgeHeightConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .Height, relatedBy: .GreaterThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: CGFloat(badgeHeight))
		badgeLabel.addConstraint(badgeHeightConstraint!)
		badgeWidthConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .Width, relatedBy: .GreaterThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: CGFloat(badgeHeight))
		badgeLabel.addConstraint(badgeWidthConstraint!)
		setNeedsLayout()
		badgeIsLayouted = true
	}
}