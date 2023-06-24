//
//  MenuFoodTableViewCell.swift
//  PizzaShop
//
//  Created by Алексей Ревякин on 24.06.2023.
//

import UIKit

class MenuFoodTableViewCell: UITableViewCell {
    
    private var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 132, height: 132)
        return imageView
    }()
    private var nameFoodLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        return label
    }()
    private var descriptionFoodLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        label.textColor = R.Color.descriptionFont
        return label
    }()
    private var costFoodLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 6
        label.layer.borderColor = R.Color.colorB1.cgColor
        label.layer.borderWidth = 1
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = R.Color.colorB1
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(foodImageView)
        contentView.addSubview(nameFoodLabel)
        contentView.addSubview(descriptionFoodLabel)
        contentView.addSubview(costFoodLabel)
    }
    
    override func layoutSubviews() {
        foodImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(contentView.bounds.width * 0.05)
            make.top.equalToSuperview().offset(24)
            make.width.equalTo(132)
            make.height.equalTo(132)
        }
        nameFoodLabel.snp.makeConstraints { make in
            make.left.equalTo(foodImageView.snp.right).offset(32)
            make.top.equalToSuperview().offset(8 + 24)
            make.right.equalToSuperview().offset(-contentView.bounds.width * 0.065)
            make.height.equalTo(20)
        }
        descriptionFoodLabel.snp.makeConstraints { make in
            make.left.equalTo(nameFoodLabel)
            make.right.equalTo(nameFoodLabel)
            make.top.equalTo(nameFoodLabel.snp.bottom).offset(8)
        }
        costFoodLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionFoodLabel.snp.bottom).offset(16)
            make.right.equalTo(nameFoodLabel)
            make.width.equalTo(87)
            make.height.equalTo(32)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(image: Data, name: String, desription: String, cost: String) {
        foodImageView.image = UIImage(data: image)
        nameFoodLabel.text = name
        descriptionFoodLabel.text = desription
        costFoodLabel.text = cost
    }
    
    override func prepareForReuse() {
        foodImageView.image = nil
        nameFoodLabel.text = nil
        descriptionFoodLabel.text = nil
        costFoodLabel.text = nil
    }

}
