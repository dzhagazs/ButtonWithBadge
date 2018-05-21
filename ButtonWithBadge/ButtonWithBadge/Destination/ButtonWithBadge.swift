//
//  ButtonWithBadge.swift
//  Tap
//
//  Created by Alexandr on 6/8/16.
//  Copyright © 2016 dzhagazs. All rights reserved.
//

import UIKit

let badgeHeight = 13.0

public enum BadgePosition {
	case topRight
	case topLeft
	case bottomRight
	case bottomLeft
}

public enum BadgeAnimationType: Int {
	case none = 0
	case bouncing = 1
}

open class ButtonWithBadge: UIButton {
	
	//MARK: - Private Properties
	
	fileprivate let animationDuration = 0.5
	fileprivate var value: Int = 0
	fileprivate var badgeLabel: PaddingLabel
	fileprivate var badgeHeightConstraint: NSLayoutConstraint?
	fileprivate var badgeWidthConstraint: NSLayoutConstraint?
	fileprivate var badgePositionConstraints: [NSLayoutConstraint] = []
	fileprivate var position: BadgePosition = .topRight
	fileprivate var badgeIsLayouted: Bool = false
	fileprivate var textColor: UIColor = UIColor.white
	fileprivate var badgeBgColor: UIColor = UIColor.init(red: 201.0/255.0, green: 39.0/255.0, blue: 93.0/255.0, alpha: 1.0)
	fileprivate var hides: Bool = true
	open var hidesBadgeIfZero: Bool {
		get {
			return hides
		}
		set (newValue) {
			hides = newValue
			updateBadgeVisibility()
		}
	}
	
	open var badgeTextColor: UIColor {
		get {
			return textColor
		}
		
		set (newValue) {
			textColor = newValue
			badgeLabel.textColor = newValue
		}
	}
	
	open var badgeBackgroundColor: UIColor {
		get {
			return badgeBgColor
		}
		
		set (newValue) {
			badgeBgColor = newValue
			badgeLabel.backgroundColor = newValue
			badgeLabel.layer.borderColor = newValue.cgColor
		}
	}
	
	open var badgePosition: BadgePosition {
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
	
	open var animationType: BadgeAnimationType = .bouncing
	
	//MARK: - Initialization
	
	override init(frame: CGRect) {
		badgeLabel = PaddingLabel.init(frame: CGRect.zero)
		super.init(frame: frame)
		addSubview(badgeLabel)
		configureBadgeLabel()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		badgeLabel = PaddingLabel.init(frame: CGRect.zero)
		super.init(coder: aDecoder)
		addSubview(badgeLabel)
		configureBadgeLabel()
	}
	
	open var badgeValue: Int {
		set(newValue) {
			
			value = newValue
			updateBadge()
		}
		get {
			return value
		}
	}
	
	open var badgeFontSize: CGFloat {
		get {
			return badgeLabel.font.pointSize
		}
		
		set(newValue) {
			badgeLabel.font = UIFont.systemFont(ofSize: newValue)
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
	
	fileprivate func updateBadge() {
		switch animationType {
			case .bouncing:
				UIView.animate(withDuration: animationDuration * (1.0/3.0), animations: { 
					self.badgeLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
					}, completion: { (completed) in
						self.badgeLabel.text = String(self.value)
						self.updateBadgeVisibility()
						UIView .animate(withDuration: self.animationDuration * (2.0/3.0), delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.0, options: UIViewAnimationOptions(), animations: {
							self.badgeLabel.transform = CGAffineTransform.identity
							}, completion: nil)
				})

			break
			case .none:
				self.badgeLabel.text = String(self.value)
				self.updateBadgeVisibility()
			break
		}
	}
	
	fileprivate func updateBadgeVisibility() {
		if value == 0 && hidesBadgeIfZero == true {
			badgeLabel.alpha = 0.0
		} else if (value == 0 && hidesBadgeIfZero == false) || value != 0  {
			badgeLabel.alpha = 1.0
		}
	}
	
	fileprivate func configureBadgeLabel() {
		badgeLabel.translatesAutoresizingMaskIntoConstraints = false
		badgeLabel.textAlignment = NSTextAlignment.center
		badgeLabel.font = UIFont.systemFont(ofSize: 10)
		badgeLabel.textColor = badgeTextColor
		badgeLabel.backgroundColor = badgeBackgroundColor
		badgeLabel.layer.borderColor = badgeBackgroundColor.cgColor
		badgeLabel.layer.cornerRadius = CGFloat(badgeHeight/2.0)
		badgeLabel.layer.borderWidth = 1.0
		badgeLabel.clipsToBounds = true
	}
	
	//MARK: - Layout
	
	open override func layoutSubviews() {
		super.layoutSubviews()
		
		if badgeIsLayouted == false {
			layoutBadgeLabel()
		}
	}
	
	fileprivate func layoutBadgeLabel() {
		
		for c in badgePositionConstraints {
			self.removeConstraint(c)
		}
		badgePositionConstraints = []
		switch badgePosition {
		case .topRight:
			let trailingConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: badgeLabel, attribute: .trailing, multiplier: 1.0, constant: -5)
			self.addConstraint(trailingConstraint)
			let topConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: badgeLabel, attribute: .top, multiplier: 1.0, constant: 5)
			self.addConstraint(topConstraint)
			badgePositionConstraints = [trailingConstraint, topConstraint]
			break
			
		case .topLeft:
			let leadingConstraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: badgeLabel, attribute: .leading, multiplier: 1.0, constant: 5)
			self.addConstraint(leadingConstraint)
			let topConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: badgeLabel, attribute: .top, multiplier: 1.0, constant: 5)
			self.addConstraint(topConstraint)
			badgePositionConstraints = [leadingConstraint, topConstraint]
			break
			
		case .bottomLeft:
			let leadingConstraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: badgeLabel, attribute: .leading, multiplier: 1.0, constant: 5)
			self.addConstraint(leadingConstraint)
			let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: badgeLabel, attribute: .bottom, multiplier: 1.0, constant: -5)
			self.addConstraint(bottomConstraint)
			badgePositionConstraints = [leadingConstraint, bottomConstraint]
			break
			
		case .bottomRight:
			let trailingConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: badgeLabel, attribute: .trailing, multiplier: 1.0, constant: -5)
			self.addConstraint(trailingConstraint)
			let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: badgeLabel, attribute: .bottom, multiplier: 1.0, constant: -5)
			self.addConstraint(bottomConstraint)
			badgePositionConstraints = [trailingConstraint, bottomConstraint]
			break
		}
		badgeHeightConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: CGFloat(badgeHeight))
		badgeLabel.addConstraint(badgeHeightConstraint!)
		badgeWidthConstraint = NSLayoutConstraint(item: badgeLabel, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: CGFloat(badgeHeight))
		badgeLabel.addConstraint(badgeWidthConstraint!)
		setNeedsLayout()
		badgeIsLayouted = true
	}
}
