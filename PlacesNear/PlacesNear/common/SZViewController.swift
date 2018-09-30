//
//  SZViewController.swift
//  SwiftBase
//
//  Created by zsx on 2018/8/28.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

open class SZViewController: UIViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let dict:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)]
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : AnyObject]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        let icon = UIImage(named: "icon_BackIcon.png")

        let leftBarBtn = UIBarButtonItem(title: "", style: .plain, target: self,
                                         action: #selector(backToPrevious))
        leftBarBtn.image = icon
        self.navigationItem.leftBarButtonItem = leftBarBtn
        
        self.view.backgroundColor = UIColor.white
        
        
        
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillChange(_:)),name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillHiden(_:)),name: .UIKeyboardWillHide, object: nil)
        
    }
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    @objc open func backToPrevious() {
        self.navigationController!.popViewController(animated: true)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func keyboardWillChange(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo else {
            return
        }

        let window = UIApplication.shared.keyWindow

        var firstFrame:CGRect?

        let inputViews:[UIView] = getInputViews(superView: self.view)
        
        for inputView in inputViews {
            if inputView is UITextField {
                let textField:UITextField = inputView as! UITextField
                if textField.isFirstResponder {
                    firstFrame = textField.convert(textField.bounds, to: window)
                }
            } else {
                let textView:UITextView = inputView as! UITextView
                if textView.isFirstResponder {
                    firstFrame = textView.convert(textView.bounds, to: window)
                }
            }
        }
        
        
        guard let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        guard let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        
        let frame = value.cgRectValue
        
        guard let viewFrame = firstFrame else {
            return
        }
        
        if viewFrame.origin.y + viewFrame.size.height + 20 < frame.origin.y {
            return
        }

        UIView.animate(withDuration: duration) {
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: frame.origin.y - (viewFrame.origin.y + viewFrame.size.height + 20), width: self.view.frame.size.width, height: self.view.frame.size.height)
        }
        
    }
    @objc func keyboardWillHiden(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        
        guard let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        UIView.animate(withDuration: duration) {
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }
    }
    
    private func getInputViews(superView:UIView) -> [UIView] {
        var arr:[UIView] = [UIView]()
        for subView in superView.subviews {
            if subView is UITextField || subView is UITextView {
                arr.append(subView)
            }
            if subView.subviews.count > 0 {
                arr.append(contentsOf: getInputViews(superView: subView))
            }
        }
        return arr
    }
}


// MARK: - 扩展方法
extension SZViewController {
    public func popToControllerAt(index:Int) {
        if let navi = self.navigationController {
            var arr:[UIViewController] = navi.viewControllers
            for (i,_) in navi.viewControllers.enumerated().reversed() {
                if i > index {
                    arr.remove(at: i)
                }
            }
            navi.setViewControllers(arr, animated: true)
        }
    }
}
