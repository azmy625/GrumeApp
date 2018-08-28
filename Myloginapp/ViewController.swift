//
//  ViewController.swift
//  Myloginapp
//
//  Created by aokijun on 2018/08/27.
//  Copyright © 2018年 aokijun. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth




class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var status: UILabel!
    var auth: Auth!
    var handle: AuthStateDidChangeListenerHandle?
    var isLogIn: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.auth = Auth.auth()
        self.isLogIn = false
        
        email.delegate = self
        password.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.handle = self.auth.addStateDidChangeListener { (auth, user) in
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.auth.removeStateDidChangeListener(self.handle!)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    @IBAction func signUp(_ sender: Any) {
        self.auth.createUser(withEmail: self.email.text!, password: self.password.text!) { (authResult, error) in
            if error == nil {
                //self.fromEmail.text = authResult?.email
                //self.fromUserId.text = authResult?.uid
                self.isLogIn = true
                self.status.text = "登録が成功しました"
            } else {
                self.status.text = error!.localizedDescription
            }
        }
    }
    
    @IBAction func login(_ sender: Any) {
        if self.isLogIn {
            self.status.text = "既にログインしています"
            return
        }
        self.auth.signIn(withEmail: self.email.text!, password: self.password.text!) { (authResult, error) in
            if (error == nil) {
                //self.fromEmail.text = authResult?.email
                //self.fromUserId.text = authResult?.uid
                self.isLogIn = true
                self.status.text = "ログインに成功しました"
            } else {
                self.status.text = error!.localizedDescription
            }
        }
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        email.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
    
    
    
    
}
