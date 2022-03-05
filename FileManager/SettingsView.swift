import UIKit

class SettingsView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.viewSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var sortSwitch: UISwitch = {
        let sSwitch = UISwitch()
        sSwitch.translatesAutoresizingMaskIntoConstraints = false
        sSwitch.setOn(UserDefaults.standard.bool(forKey: "isAlphabetSort"), animated: false) 
        return sSwitch
    }()
    
    lazy var switchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Сортировка по алфавиту"
        return label
    }()
    
    lazy var passwordResetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сменить пароль", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private func viewSetup(){
        [sortSwitch,switchLabel,passwordResetButton].forEach {self.addSubview($0)}
        NSLayoutConstraint.activate([
            sortSwitch.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            sortSwitch.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            
            switchLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            switchLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            switchLabel.rightAnchor.constraint(equalTo: sortSwitch.leftAnchor, constant: -16),
            switchLabel.heightAnchor.constraint(equalTo: sortSwitch.heightAnchor),
            
            passwordResetButton.topAnchor.constraint(equalTo: switchLabel.bottomAnchor, constant: 16),
            passwordResetButton.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            passwordResetButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
        ])
    }
}
