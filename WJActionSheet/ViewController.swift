//
//  ViewController.swift
//  WJActionSheet
//
//  Created by Tung Tran on 9/8/15.
//  Copyright (c) 2015 Tung Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let actionSheet = WJActionSheet(title: "Title")
        actionSheet.addButtonWithTitle("Button 1", type: WJActionInSheetType.Destructive) { () -> Void in
            print("Button 1 is tapped")
        }
        actionSheet.addButtonWithTitle("Button 2", type: WJActionInSheetType.Normal) { () -> Void in
            print("Button 2 is tapped")
        }
        actionSheet.addCancelButtonWithTitle(nil) { () -> Void in
            print("Cancel is tapped")
        }
        actionSheet.showInView(view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

