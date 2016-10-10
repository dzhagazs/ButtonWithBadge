//
//  ViewController.swift
//  ButtonWithBadge
//
//  Created by Alexandr on 9/23/16.
//  Copyright © 2016 v-damki-man. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var tapButton: ButtonWithBadge!
	override func viewDidLoad() {
		super.viewDidLoad()
		tapButton.badgeValue = 10
	}
	
	// MARK: - Actoins

	@IBAction func changePositionAction(sender: AnyObject) {
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
	@IBAction func plusAction(sender: AnyObject) {
		tapButton.badgeValue += 10
	}
	
	@IBAction func minusAction(sender: AnyObject) {
		tapButton.badgeValue -= 10
	}
	
	@IBAction func badgeSIzeValueChange(sender: UISlider) {
		tapButton.badgeFontSize = CGFloat(sender.value)
	}
}

