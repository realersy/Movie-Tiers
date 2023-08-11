//
//  SearchMovieCell.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 25.07.2023.
//

import Foundation
import UIKit

final class SearchMovieCell: UICollectionViewCell {
    
    //MARK: Cell identifier
    public static let cellID = "searchMovieCell"
    
    //MARK: Properties
    let imageView = UIImageView()
    
    //MARK: Initialers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: Setup
extension SearchMovieCell {
    func setup(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
//MARK: Cell configuration
extension SearchMovieCell {
    func configImage(item: SearchItem){
        
        SearchMovieService.shared.getImage(urlToImage: item.imageLinkString ?? "") { data in
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
                
            }
        }
    }
}
