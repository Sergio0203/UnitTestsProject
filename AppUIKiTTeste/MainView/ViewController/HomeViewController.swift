//
//  HomeViewController.swift
//  AppUIKiTTeste
//
//  Created by Sérgio César Lira Júnior on 07/04/25.
//
import UIKit

protocol ButtonDelegate: AnyObject {
    func buttonTapped()
}

final class HomeViewController: UIViewController {
    lazy var homeView: HomeView = {
        let view = HomeView(buttonDelegate: self)
        return view
    } ()
    
    override func loadView() {
        super.loadView()
        self.view = homeView
    }
    
    func setGradientBackground() {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = view.bounds
            
            gradientLayer.colors = [
                UIColor.systemBlue.cgColor,
                UIColor.systemTeal.cgColor
            ]
            
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            
            view.layer.insertSublayer(gradientLayer, at: 0)
        }
}

extension HomeViewController: ButtonDelegate {
    @objc func buttonTapped() {
        print("Button Tapped")
    }
}
