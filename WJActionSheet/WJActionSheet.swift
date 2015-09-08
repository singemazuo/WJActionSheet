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
    
    convenience init(title: String) {
        self.init()

        self.title = title
        delegate = self
    }
    
    /**
        Add Button
    
    :param: title  button title
    :param: type   WJActionInSheetType
    :param: action action block
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
        Add Cancel Button quickly
    
    :param: action action of cancel button
    */
    func addCancelButtonWithAction(action: (() -> Void)?) {
        addButtonWithTitle("Cancel", type: WJActionInSheetType.Cancel, action: action)
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
