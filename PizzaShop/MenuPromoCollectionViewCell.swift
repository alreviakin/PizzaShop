//
//  MenuPromoCollectionViewCell.swift
//  PizzaShop
//
//  Created by Алексей Ревякин on 23.06.2023.
//

import UIKit

class MenuPromoCollectionViewCell: UICollectionViewCell {
    private var promoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(promoImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        promoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        promoImageView.image = nil
    }
    
    func configure(with imageData: Data?) {
        guard let imageData, let image = UIImage(data: imageData) else { return }
        promoImageView.image = image
    }
}
