//
//  ViewController.swift
//  ButtonWithBadge
//
//  Created by Alexandr on 9/23/16.
//  Copyright © 2016 dzhagazs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var tapButton: ButtonWithBadge!
	@IBOutlet weak var hideWhenZeroSwitch: UISwitch!
	@IBOutlet weak var animationTypeSegmentedControl: UISegmentedControl!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tapButton.badgeValue = 10
		animationTypeSegmentedControl.selectedSegmentIndex = tapButton.animationType.rawValue
		hideWhenZeroSwitch.isOn = tapButton.hidesBadgeIfZero
	}
	
	// MARK: - Actoins

	@IBAction func hidesWhenZeroValueChanged(_ sender: UISwitch) {
		tapButton.hidesBadgeIfZero = sender.isOn
	}
	
	@IBAction func changePositionAction(_ sender: AnyObject) {
		let currentPosition = tapButton.badgePosition
		var nextPosition: BadgePosition
		switch currentPosition {
		case .topRight:
			nextPosition = .topLeft
		case .topLeft:
			nextPosition = .bottomLeft
		case .bottomLeft:
			nextPosition = .bottomRight
		case .bottomRight:
			nextPosition = .topRight
		}
		
		tapButton.badgePosition = nextPosition
	}
	
	@IBAction func plusAction(_ sender: AnyObject) {
		tapButton.badgeValue += 10
	}
	
	@IBAction func minusAction(_ sender: AnyObject) {
		tapButton.badgeValue -= 10
	}
	
	@IBAction func badgeSIzeValueChange(_ sender: UISlider) {
		tapButton.badgeFontSize = CGFloat(sender.value)
	}
	
	@IBAction func changeAnimationType(_ sender: UISegmentedControl) {
		tapButton.animationType = BadgeAnimationType(rawValue: sender.selectedSegmentIndex)!
	}
}

