//
//  FoodCell.swift
//  HammerSystemOnboarding
//
//  Created by Egor Dadugin on 05.04.2023.
//

import UIKit
import SnapKit

class FoodCell: UICollectionViewCell {
    var image = UIImageView()
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(image)
        descriptionLabel.numberOfLines = 0
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(priceLabel)
    }
    
    private func makeConstraints() {
        
        
        image.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(16)
            make.top.equalTo(self.snp.top).offset(24)
            make.height.equalTo(132)
            make.width.equalTo(132)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(image.snp.trailing).offset(32)
            make.top.equalTo(self.snp.top).offset(32)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(image.snp.trailing).offset(32)
            make.trailing.equalTo(self.snp.trailing)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            make.leading.equalTo(image.snp.trailing).offset(116)
            
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(156)
            make.bottom.equalTo(priceLabel.snp.bottom).offset(16)
        }
    }
    
    public func loadImage(for url: URL) {
        DispatchQueue.global().async { [weak self] in
            
            if let imageData = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self?.image.image = UIImage(data: imageData)
                }
            }
        }
    }
}
