//
//  WJActionSheet.swift
//  WJActionSheet
//
//  Created by Tung Tran on 9/8/15.
//  Copyright (c) 2015 Tung Tran. All rights reserved.
//

import UIKit

private class WJActionInSheet {
    var title: String
    var action: (() -> Void)?
    
    init(title: String, action: (() -> Void)?) {
        self.title = title
        self.action = action
    }
}

enum WJActionInSheetType: Int {
    case Normal = 0
    case Cancel = 1
    case Destructive = 2
}

class WJActionSheet: UIActionSheet {
    
    private var actions = [WJActionInSheet]()
    
    convenience init(title: String) {
        self.init()
        self.title = title
        delegate = self
    }
    
    func addButtonWithTitle(title: String, type: WJActionInSheetType, action: (() -> Void)?) {
        addButtonWithTitle(title)
        actions.append(WJActionInSheet(title: title, action: action))
        if type == WJActionInSheetType.Cancel {
            cancelButtonIndex = actions.count - 1
        } else if type == WJActionInSheetType.Destructive {
            destructiveButtonIndex = actions.count - 1
        }
    }
    
    func addCancelButtonWithAction(action: (() -> Void)?) {
        let buttonTitle = "Cancel"
        addButtonWithTitle(buttonTitle)
        actions.append(WJActionInSheet(title: buttonTitle, action: action))
        cancelButtonIndex = actions.count - 1
    }
}

extension WJActionSheet: UIActionSheetDelegate {
    
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        if buttonIndex == actionSheet.cancelButtonIndex {
            return
        }
        
        if let action = actions[buttonIndex].action {
            action()
        }
    }
}
