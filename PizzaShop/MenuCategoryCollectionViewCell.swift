//
//  MenuCategoryCollectionViewCell.swift
//  PizzaShop
//
//  Created by Алексей Ревякин on 24.06.2023.
//

import UIKit

class MenuCategoryCollectionViewCell: UICollectionViewCell {
    private var categoryLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = R.Color.deselectedCategoryCell
        label.layer.cornerRadius = 16
        label.layer.borderWidth = 1
        label.layer.borderColor = R.Color.deselectedCategoryCell.cgColor
        label.layer.masksToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(categoryLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        categoryLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryLabel.text = nil
    }
    
    func configure(with category: String) {
        categoryLabel.text = category
    }
    override var isSelected: Bool {
        didSet {
            if isSelected {
                UIView.animate(withDuration: 0.5) {
                    self.categoryLabel.backgroundColor = R.Color.selectedCategoryCell
                    self.categoryLabel.layer.borderWidth = 0
                    self.categoryLabel.textColor = R.Color.colorB1
                    self.categoryLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
                }
            }else {
                categoryLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
                categoryLabel.textColor = R.Color.deselectedCategoryCell
                categoryLabel.layer.borderWidth = 1
                categoryLabel.backgroundColor = R.Color.viewBackground
            }
        }
    }
}
