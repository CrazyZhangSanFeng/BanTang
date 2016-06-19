//
//  BTCreatTextVC.swift
//  BanTang
//
//  Created by 张灿 on 16/6/19.
//  Copyright © 2016年 张灿. All rights reserved.
//

import UIKit

class BTCreatTextVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textInputView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textInputView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //取消按钮
    @IBAction func cancleBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //预览按钮
    @IBAction func seeBtn(sender: AnyObject) {
        debugPrint("预览")
    }
    
    //发布按钮
    @IBAction func postBtn(sender: AnyObject) {
        debugPrint("发布")
    }
    
    //MARK: - 标题字数限制
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        if textView.text.characters.count > 30 {
            textView.deleteBackward()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        textView.text.removeAll()
    }
    
    
    

}
