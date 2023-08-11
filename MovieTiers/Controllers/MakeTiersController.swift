//
//  MakeTiersController.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 01.08.2023.
//

import Foundation
import UIKit
//MARK: TierListDelegate
protocol TierListDelegate: AnyObject {
    func tierListDidChange(newTierList: TierList)
}

final class MakeTiersController: UIViewController {
    //MARK: Parameters
    var stackView = UIStackView()
    let nextButton = UIButton()
    
    //Injected properties
    var tierTitle = String()
    var numOfTiers = Int()
    
    var colorsArray = [String]()
    var titlesArray = [String]()
    
    weak var tierListDelegate: TierListDelegate?
    var index: Int = 0
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor("#33377A")
        title = tierTitle
        setupStackView()
        setupNextButton()
    }
    
    convenience init(numOfTiers: Int, tierTitle: String) {
        self.init(nibName: nil, bundle: nil)
        self.numOfTiers = numOfTiers
        self.tierTitle = tierTitle
    }
    
}
//MARK: Setup
extension MakeTiersController {
    //Setup next Button
    func setupNextButton(){
        nextButton.setTitle("Create List", for: [])
        view.addSubview(nextButton)
        nextButton.layer.cornerRadius = 18
        nextButton.backgroundColor = UIColor.systemPurple
        nextButton.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 30)
        nextButton.setTitleColor(.white, for: [])
        nextButton.addTarget(self, action: #selector(createList), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.heightAnchor.constraint(equalToConstant: 70),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
            
        ])
    }
    //Setup stackView
    func setupStackView(){
        view.addSubview(stackView)
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150)
        ])
        
        for i in stride(from: 0, through: numOfTiers-1, by: 1){
            let tierMaker = TierMakerView()
            tierMaker.tierTitle.delegate = self
            tierMaker.tierTitle.attributedPlaceholder = NSAttributedString(
                string: "#\(i+1) Tier",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2])
            stackView.addArrangedSubview(tierMaker)
            tierMaker.colorButton.tag = i
            tierMaker.colorButton.addTarget(self, action: #selector(pressedColor), for: .touchUpInside)
            tierMaker.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                tierMaker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 65),
                tierMaker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -65)
            ])
        }
        
    }
}
//MARK: UIColorPickerViewControllerDelegate
extension MakeTiersController: UIColorPickerViewControllerDelegate {
    @objc func pressedColor(sender: UIButton){
        let colorVC = UIColorPickerViewController()
        index = sender.tag
        colorVC.delegate = self
        present(colorVC, animated: true)
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        (stackView.arrangedSubviews[index] as! TierMakerView).colorButton.backgroundColor = color
        dismiss(animated: true)
    }
}
//MARK: UITextFieldDelegate
extension MakeTiersController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

//MARK: Selector Functions
extension MakeTiersController {
    @objc func createList(){
        for i in 0...numOfTiers-1{
            if (stackView.arrangedSubviews[i] as! TierMakerView).tierTitle.text == "" {
                let alertContr = UIAlertController(title: "Oops...", message: "Make sure all your tiers are named", preferredStyle: .alert)
                alertContr.addAction(UIAlertAction(title: "OK", style: .default))
                colorsArray = []
                titlesArray = []
                present(alertContr, animated: true)
                return
            }
        }
        for i in 0...numOfTiers-1{
            colorsArray.append((stackView.arrangedSubviews[i] as! TierMakerView).colorButton.backgroundColor?.toHexString() ?? "#FFFFFF")
            titlesArray.append((stackView.arrangedSubviews[i] as! TierMakerView).tierTitle.text!)
        }
        var tiers = [Tier]()
        for i in 0...numOfTiers-1{
            let tier = Tier(colorHex: colorsArray[i], name: titlesArray[i], items: [])
            tiers.append(tier)
        }
        let tierList = TierList(tierList: tiers, title: tierTitle)
        
        tierListDelegate?.tierListDidChange(newTierList: tierList)
        navigationController?.popToRootViewController(animated: true)
    }
}
