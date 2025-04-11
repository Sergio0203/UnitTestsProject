//
//  HomeView.swift
//  AppUIKiTTeste
//
//  Created by Sérgio César Lira Júnior on 07/04/25.
//

import UIKit

final class HomeView: UIView {
    let portView = UIScreen.main.bounds
    weak var buttonDelegate: ButtonDelegate?
    
    lazy var gradient: CAGradientLayer = {
        let gradiente = CAGradientLayer()
        gradiente.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradiente.frame = .init(x: 0, y: 0, width: portView.width, height: portView.height)
        gradiente.locations = [0, 1]
        gradiente.startPoint = .init(x: 0.5, y: 0)
        gradiente.endPoint = .init(x: 0.5, y: 1)
        return gradiente
    } ()
    
    lazy var gradientAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "gradienteAnimation")
        animation.fromValue = [0, 0]
        animation.toValue = [1, 1]
        animation.duration = 2
        animation.repeatCount = .infinity
        return animation
    } ()
    
    lazy var buttontest: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tap me", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.tintColor = .yellow
        return button
    } ()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(
            string: "Digite algo",
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        //textField.layer.cornerRadius = 2
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.delegate = self
        return textField
    } ()
    
    init(buttonDelegate: ButtonDelegate) {
        self.buttonDelegate = buttonDelegate
        super.init(frame: .zero)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTap() {
        buttonDelegate?.buttonTapped()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
    
    }
}

extension HomeView: SetupView {
    func addComponents() {
        addSubview(buttontest)
        addSubview(textField)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            buttontest.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttontest.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.topAnchor.constraint(equalTo: buttontest.topAnchor, constant: -100),
            
            textField.widthAnchor.constraint(equalToConstant: 150),
            textField.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    func addStyles() {
        layer.insertSublayer(gradient, at: 0)
        
    }
    
    
}

extension HomeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return false
    }
}
