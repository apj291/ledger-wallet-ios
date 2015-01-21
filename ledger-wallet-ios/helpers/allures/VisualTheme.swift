//
//  VisualTheme.swift
//  ledger-wallet-ios
//
//  Created by Nicolas Bigot on 12/01/2015.
//  Copyright (c) 2015 Ledger. All rights reserved.
//

import UIKit

struct VisualTheme {
    
    typealias ViewAllure = (UIView) -> ()
    typealias LabelAllure = (Label) -> ()
    typealias ButtonAllure = (Button) -> ()
    typealias TextFieldAllure = (TextField) -> ()


    //MARK: View allures
    
    static let viewAllures: [String: ViewAllure] = [
        "view.background": { view in
            view.backgroundColor = VisualFactory.Colors.backgroundColor
        },
        "view.nightBlue": { view in
            view.backgroundColor = VisualFactory.Colors.nightBlue
        },
        "view.transparent": { view in
            view.backgroundColor = VisualFactory.Colors.transparent
            view.opaque = false
        },
        "actionBar.grey": { view in
            let actionBar = view as ActionBarView
            actionBar.backgroundColor = VisualFactory.Colors.extraLightGrey
            actionBar.borderColor = VisualFactory.Colors.veryLightGrey
        },
        "tableView.transparent": { view in
            let tableView = view as TableView
            tableView.backgroundColor = VisualFactory.Colors.transparent
            tableView.separatorColor = VisualFactory.Colors.lightGrey
            tableView.separatorInset = UIEdgeInsetsMake(0, VisualFactory.Metrics.Paddings.small, 0, VisualFactory.Metrics.Paddings.small)
        },
        "tableViewCell.transparent": { view in
            let tableViewCell = view as TableViewCell
            tableViewCell.contentView.backgroundColor = VisualFactory.Colors.transparent
            tableViewCell.backgroundColor = VisualFactory.Colors.transparent
        },
        "navigationBar.nightBlue": { view in
            let navigationBar = view as NavigationBar
            navigationBar.translucent = false
            navigationBar.shadowImage = UIImage()
            navigationBar.barTintColor = VisualFactory.Colors.nightBlue
            navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        }
    ]
    
    //MARK: Label allures
    
    static let labelAllures: [String: LabelAllure] = [
        "navigationBar.title": { label in
            label.attributedText = NSAttributedString(string: label.readableText(), attributes: VisualFactory.TextAttributes.pageTitle)
        },
        "navigationBar.largeTitle": { label in
            label.attributedText = NSAttributedString(string: label.readableText(), attributes: VisualFactory.TextAttributes.largePageTitle)
        },
        "navigationBar.text": { label in
            label.attributedText = NSAttributedString(string: label.readableText(), attributes: VisualFactory.TextAttributes.navigationBarText)
        },
        "medium": { label in
            label.attributedText = NSAttributedString(string: label.readableText(), attributes: VisualFactory.TextAttributes.medium)
        },
        "medium.grey": { label in
            label.attributedText = NSAttributedString(string: label.readableText(), attributes: VisualFactory.TextAttributes.mediumGrey)
        },
        "small": { label in
            label.attributedText = NSAttributedString(string: label.readableText(), attributes: VisualFactory.TextAttributes.small)
        },
        "small.grey": { label in
            label.attributedText = NSAttributedString(string: label.readableText(), attributes: VisualFactory.TextAttributes.smallGrey)
        },
        "small.softGrey": { label in
            label.attributedText = NSAttributedString(string: label.readableText(), attributes: VisualFactory.TextAttributes.smallSoftGrey)
        },
        "largeTitle": { label in
            label.attributedText = NSAttributedString(string: label.readableText(), attributes: VisualFactory.TextAttributes.largeTitle)
        },
        "hugeNumber.grey": { label in
            label.attributedText = NSAttributedString(string: label.readableText(), attributes: VisualFactory.TextAttributes.hugeNumberGrey)
        }
    ]
    
    //MARK: Button allures
    
    static let buttonAllures: [String: ButtonAllure] = [
        "navigationBar.grey": { button in
            var hightlightedStyle = VisualFactory.TextAttributes.navigationBarText
            hightlightedStyle.updateValue((hightlightedStyle[NSForegroundColorAttributeName] as UIColor).darkerColor(factor: VisualFactory.Metrics.Factors.Darken.ultraStrong), forKey: NSForegroundColorAttributeName)
            button.setAttributedTitle(NSAttributedString(string: button.readableTitleForState(UIControlState.Normal), attributes: VisualFactory.TextAttributes.navigationBarText), forState: UIControlState.Normal)
            button.setAttributedTitle(NSAttributedString(string: button.readableTitleForState(UIControlState.Normal), attributes: hightlightedStyle), forState: UIControlState.Highlighted)
        },
        "navigationBar.white": { button in
            var hightlightedStyle = VisualFactory.TextAttributes.navigationBarWhiteText
            hightlightedStyle.updateValue((hightlightedStyle[NSForegroundColorAttributeName] as UIColor).darkerColor(factor: VisualFactory.Metrics.Factors.Darken.ultraStrong), forKey: NSForegroundColorAttributeName)
            button.setAttributedTitle(NSAttributedString(string: button.readableTitleForState(UIControlState.Normal), attributes: VisualFactory.TextAttributes.navigationBarWhiteText), forState: UIControlState.Normal)
            button.setAttributedTitle(NSAttributedString(string: button.readableTitleForState(UIControlState.Normal), attributes: hightlightedStyle), forState: UIControlState.Highlighted)
        },
        "icon": { button in
            button.adjustsImageWhenHighlighted = false
        },
        "icon.grey": { button in
            VisualTheme.buttonAllures["icon"]?(button)
            button.setTintedImages(button.imageForState(UIControlState.Normal)!, tintColor: VisualFactory.Colors.lightGrey, darkenFactor: VisualFactory.Metrics.Factors.Darken.veryStrong)
        },
        "rounded": { button in
            let roundedButton = button as RoundedButton
            roundedButton.adjustsImageWhenHighlighted = false
            roundedButton.borderRadius = VisualFactory.Metrics.BordersRadii.medium
            roundedButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: VisualFactory.Metrics.Paddings.verySmall)
            roundedButton.setAttributedTitle(NSAttributedString(string: button.readableTitleForState(UIControlState.Normal), attributes: VisualFactory.TextAttributes.roundedButtonText), forState: UIControlState.Normal)
            roundedButton.contentEdgeInsets = UIEdgeInsets(top: VisualFactory.Metrics.Paddings.verySmall, left: VisualFactory.Metrics.Paddings.small, bottom: VisualFactory.Metrics.Paddings.verySmall, right: VisualFactory.Metrics.Paddings.small)
            button.setImage(button.imageForState(UIControlState.Normal)!.imageWithColor(VisualFactory.Colors.white), forState: UIControlState.Normal)
        },
        "rounded.green": { button in
            VisualTheme.buttonAllures["rounded"]?(button)
            let roundedButton = button as RoundedButton
            roundedButton.setFillColor(VisualFactory.Colors.actionGreen, forState: UIControlState.Normal)
            roundedButton.setFillColor(VisualFactory.Colors.actionGreen.darkerColor(), forState: UIControlState.Highlighted)
        }
    ]
    
    //MARK: TextField allures
    
    static let textFieldAllures: [String: TextFieldAllure] = [
        "hugeName": { textField in
            var placeholderAttributes = VisualFactory.TextAttributes.hugeName
            placeholderAttributes.updateValue(VisualFactory.Colors.lightGrey, forKey: NSForegroundColorAttributeName)
            textField.attributedText = NSAttributedString(string: textField.readableText(), attributes: VisualFactory.TextAttributes.hugeName)
            textField.attributedPlaceholder = NSAttributedString(string: textField.readablePlaceholder(), attributes: placeholderAttributes)
            textField.tintColor = VisualFactory.Colors.darkGrey
            textField.borderStyle = UITextBorderStyle.None
            textField.adjustsFontSizeToFitWidth = false
        }
    ]
    
}