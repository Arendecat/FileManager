import Foundation
import UIKit

class LoginViewController: UIViewController, UISceneDelegate {
   
    init(isChange: Bool) {
        self.isPasswordChange = isChange
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let loginView = LoginView()
    private let userDefaults = UserDefaults.standard
    private var isPasswordChange: Bool
    private var password: String?
    
    func fetchPassword(){
        password = userDefaults.string(forKey: "password")
        if ((password != nil)&&(!isPasswordChange)) {
            loginView.loginButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        } else {
            loginView.loginButton.addTarget(self, action: #selector(setPassword), for: .touchUpInside)
            loginView.loginButton.setTitle("Задать пароль", for: .normal)
        }
    }
    
    @objc func logIn(){
        if (loginView.passwordBar.text == password) {
            loginView.annotation.text = "Пароль верный"
            loginView.annotation.isHidden = false
        } else {
            loginView.annotation.text = "Пароль неверный"
            loginView.annotation.isHidden = false
        }
    }
    
    @objc func setPassword(){
        if (loginView.passwordBar.text!.count >= 4) {
            userDefaults.setValue(loginView.passwordBar.text!, forKey: "password")
            loginView.annotation.text = "Пароль задан: " + loginView.passwordBar.text!
            loginView.annotation.isHidden = false
        } else {
            loginView.annotation.text = "Пароль слишком короткий"
            loginView.annotation.isHidden = false
        }
    }
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        fetchPassword()
    }
}
