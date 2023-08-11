//
//  MakeNewTierListController.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 01.08.2023.
//

import Foundation
import UIKit

final class MakeNewTierListController: UIViewController {
    //MARK: Parameters
    let titleLabel = UILabel()
    let titleTextField = UITextField()
    
    let numberOfTiersLabel = UILabel()
    let numberOfTiersTextField = UITextField()
    
    let makeTiersButton = UIButton()
    let nextButton = UIButton()
    
    weak var delegate: TierListDelegate?
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}
//MARK: Setup
extension MakeNewTierListController {
    func setup(){
        //View
        view.backgroundColor = UIColor("#33377A")
        
        //Title Label
        titleLabel.text = "Tier List Title"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Arial-BoldMT", size: 30)
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 400),
            titleLabel.heightAnchor.constraint(equalToConstant: 70),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
        //Title Textfield
        titleTextField.attributedPlaceholder = NSAttributedString(
            string: "E.G Best Dramas",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2])
        titleTextField.backgroundColor = .white
        titleTextField.textColor = .black
        titleTextField.delegate = self
        titleTextField.font = UIFont(name: "Arial-BoldMT", size: 30)
        titleTextField.layer.cornerRadius = 18
        view.addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextField.heightAnchor.constraint(equalToConstant: 70),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            titleTextField.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 70),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
        
        //Number of Tiers Label
        numberOfTiersLabel.text = "Number of Tiers"
        numberOfTiersLabel.textColor = .white
        numberOfTiersLabel.font = UIFont(name: "Arial-BoldMT", size: 30)
        view.addSubview(numberOfTiersLabel)
        numberOfTiersLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberOfTiersLabel.widthAnchor.constraint(equalToConstant: 400),
            numberOfTiersLabel.heightAnchor.constraint(equalToConstant: 70),
            numberOfTiersLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 30),
            numberOfTiersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
        
        //Number of Tiers Textfield
        numberOfTiersTextField.attributedPlaceholder = NSAttributedString(
            string: "Max. 5 : Default 3",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2])
        numberOfTiersTextField.backgroundColor = .white
        numberOfTiersTextField.textColor = .black
        numberOfTiersTextField.keyboardType = .numberPad
        numberOfTiersTextField.delegate = self
        numberOfTiersTextField.font = UIFont(name: "Arial-BoldMT", size: 30)
        numberOfTiersTextField.layer.cornerRadius = 18
        view.addSubview(numberOfTiersTextField)
        numberOfTiersTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberOfTiersTextField.heightAnchor.constraint(equalToConstant: 70),
            numberOfTiersTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            numberOfTiersTextField.topAnchor.constraint(equalTo: numberOfTiersLabel.topAnchor, constant: 70),
            numberOfTiersTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
        
        nextButton.addTarget(self, action: #selector(goNext), for: .touchUpInside)
    }
    
    func shake(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: numberOfTiersTextField.center.x-6, y: numberOfTiersTextField.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: numberOfTiersTextField.center.x+6, y: numberOfTiersTextField.center.y))
        self.numberOfTiersTextField.layer.add(animation, forKey: "position")
    }
    
    func checkEntry(num: Int) -> Bool{
        if num > 5 || num == 0 {
            return false
        }
        else{
            return true
        }
    }
}
//MARK: UITextFieldDelegate
extension MakeNewTierListController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return titleTextField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let int_text = Int(numberOfTiersTextField.text!) ?? 3
        if !checkEntry(num: int_text) || titleTextField.text?.isEmpty == true {
            nextButton.isHidden = true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let int_text = Int(numberOfTiersTextField.text!) ?? 3
        
        if !checkEntry(num: int_text) || titleTextField.text?.isEmpty == true {
            shake()
        } else {
            nextButton.isHidden = false
            nextButton.setTitle("Make Tiers", for: [])
            view.addSubview(nextButton)
            nextButton.layer.cornerRadius = 18
            nextButton.backgroundColor = UIColor.systemPurple
            nextButton.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 30)
            nextButton.setTitleColor(.white, for: [])
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                nextButton.heightAnchor.constraint(equalToConstant: 70),
                nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
                nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
                nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
                
            ])
        }
    }
}
//MARK: Selector Functions
extension MakeNewTierListController {
    @objc func goNext(){
        let int_text = Int(numberOfTiersTextField.text!) ?? 3
        let makeTiersController = MakeTiersController(numOfTiers: int_text, tierTitle: titleTextField.text!)
        //present(makeTiersController, animated: true)
        makeTiersController.tierListDelegate = delegate
        navigationController?.pushViewController(makeTiersController, animated: true)
    }
}


