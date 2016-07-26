//
//  ViewController.swift
//  ValidatedSignUp
//
//  Created by Flatiron School on 7/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var saveButtonOUtlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //call the function to assign delegates
        self.assignDelegates()
        //disable the textfields, except the first one
        self.disableAllTextfield()
    
    }
    
    //submit button function
    @IBAction func SubmitButtonTapped(sender: UIButton) {
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case self.firstNameTextField:
            if self.nameCheck(textField.text!) {
                print("valid name")
                self.lastNameTextField.enabled = true
                self.lastNameTextField.becomeFirstResponder()
            }
            else {
                self.showAlert(textField, message: "Your entry \(textField.text!) is invalid. The entry cannot be empty and cannot have any digits.")
            }
        case self.lastNameTextField:
            if self.nameCheck(textField.text!) {
                print("valid lastname")
                self.emailTextField.enabled = true
                self.emailTextField.becomeFirstResponder()
            }
            else {
                self.showAlert(textField, message: "Your entry \(textField.text!) is invalid. The entry cannot be empty and cannot have any digits.")
            }
        case self.emailTextField:
            if self.emailCheck(textField.text!) {
                print("valid email")
                self.userNameTextField.enabled = true
                self.userNameTextField.becomeFirstResponder()
            }
            else {
                self.showAlert(textField, message: "Your entry \(textField.text!) is invalid. Please enter a valid e-mail format")
            }
        case userNameTextField:
            if self.nameCheck(textField.text!) {
                print("valid username")
                self.passwordTextField.enabled = true
                self.passwordTextField.becomeFirstResponder()
            }
            else {
                self.showAlert(textField, message: "Your entry \(textField.text!) is invalid. The entry cannot be empty and cannot have any digits.")
            }
        case passwordTextField:
            if textField.text!.characters.count >= 6 {
                print("valid password")
                self.saveButtonOUtlet.enabled = true
                textField.resignFirstResponder()
            }
            else {
                self.showAlert(textField, message: "Your entry \(textField.text!) is invalid. You should enter at least 6 characters or digits.")
            }
        default:
            print("incorrect textfield / entry?")
        }
        return true;
    }
    
    //assign the delegates
    func assignDelegates() {
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.emailTextField.delegate = self
        self.userNameTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    // disables all the textfields and the button except the first textfield
    func disableAllTextfield() {
        self.firstNameTextField.enabled = true
        self.lastNameTextField.enabled = false
        self.emailTextField.enabled = false
        self.userNameTextField.enabled = false
        self.passwordTextField.enabled = false
        self.saveButtonOUtlet.enabled = false
    }
    
    // a function to validate the firstname, lastname, and username
    func nameCheck(word:String) -> Bool {
        var returnBool = false
        let trimmedWord = word.stringByTrimmingCharactersInSet(NSCharacterSet.decimalDigitCharacterSet())
        if (word.characters.count > 0) && (trimmedWord.characters.count == word.characters.count) {
            returnBool = true
        }
        else {
            returnBool = false
        }
        return returnBool
    }
    
    //a function to check valid email
    func emailCheck(email: String) -> Bool {
        var formatCorrect = false
        var lengthIsOk = false
        if email.characters.count > 0 {
            lengthIsOk = true
        }
        let emailArrayForAtSign = email.componentsSeparatedByString("@")
        if  emailArrayForAtSign.count == 2 {
            let emailAfterAtSign:String = emailArrayForAtSign[1]
            let emailArrayAfterAt = emailAfterAtSign.componentsSeparatedByString(".")
            if emailArrayAfterAt.count == 2 {
                if self.nameCheck(emailArrayAfterAt[1]){
                    formatCorrect = true
                }
                else {
                    formatCorrect = false
                }
            }
            else {
                formatCorrect = false
            }
        }
        else {
            formatCorrect = false
        }
        return (lengthIsOk && formatCorrect)
    }
    
    //a function to show alert
    func showAlert(textField: UITextField, message: String) {
        let alertController = UIAlertController(title: "Wrong Input", message: message, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Clear", style: .Cancel) {(action) in
            textField.text = ""
        }
        alertController.addAction(cancelAction)
        let OKAction = UIAlertAction(title: "OK", style: .Default) {(action) in
            // do nothing. Everything is awesome!
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
            // Nothing to do brah, just present itself already for God's sake!
        }
    }
}

