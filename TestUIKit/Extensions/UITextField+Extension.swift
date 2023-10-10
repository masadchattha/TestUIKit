//
//  UITextField+Extension.swift
//  LFW
//
//  Created by Jassie on 25/05/2018.
//  Copyright © 2018 CodingPixel. All rights reserved.
//

import Foundation
import UIKit


extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}


@IBDesignable
class PaddingField: UITextField {
    
    // Provides left padding for images
    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var rightPadding: CGFloat = 0
    @IBInspectable var topPadding: CGFloat = 0
    @IBInspectable var bottomPadding: CGFloat = 0
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: topPadding, left: leftPadding , bottom: bottomPadding, right: rightPadding)
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: topPadding, left: leftPadding , bottom: bottomPadding, right: rightPadding)
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: topPadding, left: leftPadding , bottom: bottomPadding, right: rightPadding)
        return bounds.inset(by: padding)
    }
}



@IBDesignable
class DesignableUITextField: UITextField {
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var rightPadding: CGFloat = 0
    @IBInspectable var upPadding: CGFloat = 0
    @IBInspectable var downPadding: CGFloat = 0
    
    
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image.withRenderingMode(.alwaysOriginal)
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
    
    
    

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: 0, left: leftPadding + 25, bottom: 0, right: 0)
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: 0, left: leftPadding + 25, bottom: 0, right: 0)
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: 0, left: leftPadding + 25, bottom: 0, right: 0)
        return bounds.inset(by: padding)
    }
    
    
    
}


// MARK: - valiudation Methods
extension UITextField {
    /// Checks if textFiels is Empty or Blank(Having white spaces)
    ///
    /// If any or both case happen, return TRUE otherwise FALSE
    /// - Returns: Bool
    var isEmptyOrBlank: Bool {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
    
    /// Checks if textFiels is Greater or Equal to 8 & equal or Less than 15 characters
    ///
    /// If text-count is LESS then 8 and greater thab 15, return False otherwise FALSE
    /// - Returns: Bool
    var isValidPassword: Bool {
//        guard let text = text?.trimmingCharacters(in: .whitespacesAndNewlines), text.count >= 8 && text.count <= 15  else {
        guard let text = text?.trimmingCharacters(in: .whitespacesAndNewlines), text.count >= 8 else {
            return false
        }
        return true
    }
    
    // TODO: edit logic Explanation
    /// Checks if textFiels is Greater or Equal to 8 characters
    ///
    /// If text-count is LESS then 8, return False otherwise FALSE
    /// - Returns: Bool
    var isValidEmail: Bool {
        guard let email = text, !isEmptyOrBlank else {
            return false
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // TODO: edit logic Explanation
    /// Checks if textFiels is Greater or Equal to 8 characters
    ///
    /// If text-count is LESS then 8, return False otherwise FALSE
    /// - Returns: Bool
    var isValidPhoneNumber: Bool {
        guard let phoneNumber = text, !isEmptyOrBlank else {
            return false
        }
        // phoneNumberRegex will only validate USA based phone numbers
        //^: Start-of-regex, \+1: Exact same occurance are allowed, \d{10}: onlyt 10-digits are allowed (\d represnt digits class), $: End of Regex
//        let phoneNumberRegex = #"^\+1\d{10}$"#
        
        // Regex from Android Team
        let phoneNumberRegex = #"^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$"#
        let phoneNumberPredicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        return phoneNumberPredicate.evaluate(with: phoneNumber)
    }
    
    // TODO: edit logic Explanation
    /// Checks if textFiels is Greater or Equal to 8 characters
    ///
    /// If text-count is LESS then 8, return False otherwise FALSE
    /// - Returns: Bool
    var isValidDate: Bool {
        guard let phoneNumber = text, !isEmptyOrBlank else {
            return false
        }
        // Date Format is: DD/MM/YYYY
        let dateRegex = #"^(0?[1-9]|[12][0-9]|3[01])/(0?[1-9]|1[0-2])/(\d{4})$"#
        let datePredicate = NSPredicate(format: "SELF MATCHES %@", dateRegex)
        return datePredicate.evaluate(with: phoneNumber)
    }
    
    /// Validate License Number
    /// Atleast 1 alphabet, 1 number. Dash is optional. (Everything else is not allowed)
    var isValidLicenseNumber: Bool {
        guard let licenseNumber = text else {return false}
//        let licenseRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d-]+$"
        // Accept only numbers and alphabets with an optional dash, and a minimum of 7 characters.
//        let licenseRegex = "^[a-zA-Z0-9-]{7,}$"
        let licenseRegex = "^(?=(?:.*\\d){3})[a-zA-Z0-9-]{7,}$"
        let licensePredicate = NSPredicate(format: "SELF MATCHES %@", licenseRegex)
        return licensePredicate.evaluate(with: licenseNumber)
    }
}

// MARK: - UITextField Extension for Padding
extension UITextField {
    func paddingtextfield(){
        
        let paddingview : UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        
        self.leftView = paddingview
        self.leftViewMode = UITextField.ViewMode.always
        
        self.rightView = paddingview
        self.rightViewMode = UITextField.ViewMode.always
        
    }
    
}

// MARK: - TextField Extension for Max Length
private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
            get {
                guard let l = __maxLengths[self] else {
                   return 150 // (global default-limit. or just, Int.max)
                }
                return l
            }
            set {
                __maxLengths[self] = newValue
                addTarget(self, action: #selector(fix), for: .editingChanged)
            }
        }
        
    @objc func fix(textField: UITextField) {
            let t = textField.text
            textField.text = t?.prefix(maxLength).string
        }
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
