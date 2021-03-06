//
//  LoginViewController.swift
//  BuildInstagramApp
//
//  Created by Bryan on 2021/10/25.
//

import UIKit
import SafariServices
import FirebaseAuth
class LoginViewController: UIViewController {
    
    struct Constnts{
        static let cornerRadius : CGFloat = 8.0
    }
    
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "userName or Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constnts.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField : UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "password...."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constnts.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let loginButton :UIButton = {
        let button = UIButton()
        button.setTitle("Log IN", for:.normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constnts.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(UIColor.white, for: .normal)
        
        return button
    }()
    private let termsButton :UIButton = {
        let button = UIButton()
        button.setTitle("Terms of service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    private let privacyButton :UIButton = {
        let button = UIButton()
        button.setTitle("privece policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    private let createAccountButton :UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("creat a new account?", for: .normal)
        return button
    }()
    
    private let headerView :UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let imageView = UIImageView(image: UIImage(named: "gradient"))
        imageView.contentMode = .scaleAspectFill
        header.addSubview(imageView)
        
        return header
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self,action:#selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self,action:#selector(didTapCreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self,action:#selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self,action:#selector(didTapPrivacyButton), for: .touchUpInside)
        
        
        usernameEmailField.delegate = self
        passwordField.delegate = self
        addSubviews()
        view.backgroundColor = .systemBackground
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // view.safeAreaInsets.top
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height /  3.0)
        configureHeaderView()
        usernameEmailField.frame = CGRect(x: 25, y: headerView.bottom + 40, width: view.frame.size.width - 50, height: 52.0)
        passwordField.frame = CGRect(x: 25, y: usernameEmailField.bottom + 10, width: view.frame.size.width - 50, height: 52.0)
        loginButton.frame = CGRect(x: 25, y: passwordField.bottom + 10, width: view.frame.size.width - 50, height: 52.0)
        createAccountButton.frame = CGRect(x: 25, y: loginButton.bottom + 10, width: view.frame.size.width - 50, height: 52.0)
        termsButton.frame = CGRect(x: 10, y: view.height - view.safeAreaInsets.bottom - 100, width: view.width-20, height: 50)
        privacyButton.frame = CGRect(x: 10, y: view.height - view.safeAreaInsets.bottom - 50, width: view.width - 20, height: 50)
    }
    func addSubviews(){
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(headerView)
        view.addSubview(createAccountButton)
    }
    
    func configureHeaderView(){
        guard headerView.subviews.count == 1 else{
            return
        }
        guard let backgroundView = headerView.subviews.first  else{
            return
        }
        backgroundView.frame = headerView.bounds
        let imageView = UIImageView(image: UIImage(named: "textLogo"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width / 4.0, y: view.safeAreaInsets.top, width: headerView.frame.width / 2.0, height: headerView.height - headerView.safeAreaInsets.top)
        
    }
    
    @objc private func didTapLoginButton(){
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else{
                  return
              }
        
        
        //login functionally
        var email: String?
        var username :String?
        if usernameEmail.contains("a"), usernameEmail.contains("."){
            email = usernameEmail
        }else{
            username = usernameEmail
        }
        Authmanager.shared.loginUser(username: username, email: email, password: password) { success in
            DispatchQueue.main.async {
                if success{
                    // user logg in
                    self.dismiss(animated: true, completion: nil)
                }else{
                    //error occurred
                    let alert = UIAlertController(title: "Login error", message: "we were unable to log in", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    @objc private func didTapTermsButton(){
        guard let url = URL(string: "https://help.instagram.com/581066165581870")else{return}
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    @objc private func didTapPrivacyButton(){
        guard let url = URL(string: "https://help.instagram.com/196883487377501")else{return}
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    @objc private func didTapCreateAccountButton(){
        let VC =  RegisterViewController()
        present(UINavigationController(rootViewController: VC), animated: true)
    }

}

extension LoginViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField{
            passwordField.becomeFirstResponder()
        }else if textField == passwordField{
            didTapLoginButton()
        }
        return true
    }
}
