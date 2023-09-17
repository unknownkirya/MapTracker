//
//  DetailViewController.swift
//  TestTaskBerezhnoyKirill
//
//  Created by Кирилл Бережной on 15.09.2023.
//

import UIKit

class DetailViewController: UIViewController {
    private lazy var imageView = UIImageView()
    private lazy var image = UIImage()
    private lazy var nameLabel = UILabel()
    private lazy var connectionLabel = UILabel()
    private lazy var dateLabel = UILabel()
    private lazy var timeLabel = UILabel()
    private lazy var btnCheckHistory = UIButton()
    
    var person: Person?
    var delegateVC: MainViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupPerson() {
        guard let person = person else { return }
        image = person.newImage
        nameLabel.text = person.title
        connectionLabel.text = person.connection
        dateLabel.text = person.date
        timeLabel.text = person.time
        imageView.image = image
    }
    
    private func setupView() {
        view.backgroundColor = .white
        setupButton()
        
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(connectionLabel)
        view.addSubview(dateLabel)
        view.addSubview(timeLabel)
        view.addSubview(btnCheckHistory)
        setupPerson()
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        connectionLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        btnCheckHistory.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            imageView.widthAnchor.constraint(equalToConstant: 75),
            imageView.heightAnchor.constraint(equalToConstant: 75),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 125),
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            connectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 145),
            connectionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            connectionLabel.widthAnchor.constraint(equalToConstant: 35),
            dateLabel.leadingAnchor.constraint(equalTo: connectionLabel.trailingAnchor, constant: 30),
            dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            dateLabel.widthAnchor.constraint(equalToConstant: 75),
            timeLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 20),
            timeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            timeLabel.widthAnchor.constraint(equalToConstant: 100),
            btnCheckHistory.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 125),
            btnCheckHistory.topAnchor.constraint(equalTo: view.topAnchor, constant: 105),
            btnCheckHistory.widthAnchor.constraint(equalToConstant: 170),
        ])
    }
    
    private func setupButton() {
        btnCheckHistory.backgroundColor = .blue
        btnCheckHistory.layer.cornerRadius = 15
        btnCheckHistory.setTitle("Посмотреть историю", for: .normal)
        btnCheckHistory.titleLabel?.font = .systemFont(ofSize: 15)
    }
}
