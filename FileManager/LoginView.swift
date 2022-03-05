import UIKit

class LoginView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.viewSetup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var passwordBar: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .systemGray6
        field.layer.cornerRadius = 7
        return field
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    lazy var annotation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private func viewSetup(){
        [passwordBar,loginButton,annotation].forEach {self.addSubview($0)}
        self.backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            passwordBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwordBar.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            passwordBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordBar.bottomAnchor, constant: 20),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            annotation.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            annotation.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
