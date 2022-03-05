import UIKit

class SettingsViewController: UIViewController {
    private let settingsView = SettingsView()
    private let userDefaults = UserDefaults.standard
    
    @objc func changeSort(){
        userDefaults.setValue(settingsView.sortSwitch.isOn, forKey: "isAlphabetSort")
    }
    
    @objc func changePassword() {
        let loginViewController = LoginViewController(isChange: true)
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        settingsView.passwordResetButton.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        settingsView.sortSwitch.addTarget(self, action: #selector(changeSort), for: .touchUpInside)
    }
    
    override func loadView() {
        view = settingsView
    }
}
