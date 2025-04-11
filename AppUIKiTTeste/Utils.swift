//
//  Utils.swift
//  AppUIKiTTeste
//
//  Created by Sérgio César Lira Júnior on 08/04/25.
//

protocol SetupView {
    func addComponents()
    func setupConstraints()
    func addStyles()
}

extension SetupView {
    func setupView() {
        addComponents()
        setupConstraints()
        addStyles()
    }
}
