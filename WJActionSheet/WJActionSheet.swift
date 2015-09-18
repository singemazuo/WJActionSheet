//
//  WJActionSheet.swift
//  WJActionSheet
//
//  Created by Tung Tran on 9/8/15.
//  Copyright (c) 2015 Tung Tran. All rights reserved.
//

import UIKit

/// Control Action in ActionSheet
private class WJActionInSheet {
    var title: String
    var action: (() -> Void)?
    
    init(title: String, action: (() -> Void)?) {
        self.title = title
        self.action = action
    }
}

/**
    Action Type

    - Normal:      normal type
    - Cancel:      Cancel type
    - Destructive: Destructive type
*/
enum WJActionInSheetType: Int {
    case Normal = 0
    case Cancel = 1
    case Destructive = 2
}

/// UIActionSheet with block
class WJActionSheet: UIActionSheet {
    
    /// All available actions
    private var actions = [WJActionInSheet]()
    
    convenience init(title: String?) {
        self.init()

        if let title = title {
            self.title = title
        }
        delegate = self
    }
    
    /**
        Add Button
    
        - parameter title:  button title
        - parameter type:   WJActionInSheetType
        - parameter action: action block
    */
    func addButtonWithTitle(title: String, type: WJActionInSheetType, action: (() -> Void)?) {
        addButtonWithTitle(title)
        actions.append(WJActionInSheet(title: title, action: action))
        if type == WJActionInSheetType.Cancel {
            cancelButtonIndex = actions.count - 1
        } else if type == WJActionInSheetType.Destructive {
            destructiveButtonIndex = actions.count - 1
        }
    }
    
    /**
        Add Cancel button quickly
    
        - parameter title:  cancel button title
        - parameter action: action
    */
    func addCancelButtonWithTitle(title: String?, action: (() -> Void)?) {
        let buttonTitle = title == nil ? "Cancel" : title!
        addButtonWithTitle(buttonTitle, type: WJActionInSheetType.Cancel, action: action)
    }
}

// MARK: - UIActionSheetDelegate
extension WJActionSheet: UIActionSheetDelegate {
    
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        if let action = actions[buttonIndex].action {
            action()
        }
    }
}
