//
//  MoviePosterController.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 26.07.2023.
//

import Foundation
import UIKit

final class MoviePosterController: UIViewController {
    
    let imageView = UIImageView()
    let  titleLabel = UILabel()
    let deleteButton = UIButton()
    
    var myInventory: [Item]?
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("we are here----------")
        view.backgroundColor = UIColor("#33377A")
        setup()
    }
    
    init(_ title: String, _ imageData: Data, _ items: [Item], _ index: Int){
        self.myInventory = items
        self.index = index
        titleLabel.text = title
        imageView.image = UIImage(data: imageData)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MoviePosterController {
    func setup(){
        view.addSubview(deleteButton)
        deleteButton.setTitle("Delete Movie", for: [])
        deleteButton.backgroundColor = UIColor("#E54A3D")
        deleteButton.setTitleColor(.white, for: [])
        deleteButton.layer.cornerRadius = 22
        deleteButton.addTarget(self, action: #selector(pressedDelete), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            deleteButton.heightAnchor.constraint(equalToConstant: 60),
            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 1.8),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        view.addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "AmericanTypewriter", size: 28)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 80),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
     @objc func pressedDelete(){
         myInventory?.remove(at: index!)
         FileService.shared.writeModel(items: myInventory!)
         navigationController?.popViewController(animated: true)
    }
    
}
