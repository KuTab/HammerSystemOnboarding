//
//  MenuView.swift
//  HammerSystemOnboarding
//
//  Created by Egor Dadugin on 04.04.2023.
//

import UIKit
import SnapKit

protocol MenuDisplaysView: UIView {
    
}

class MenuView: UIView {

    lazy var townLabel: UILabel = {
       let label = UILabel()
        label.text = "Moscow"
        return label
    }()
    
    var bannerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 112)
        layout.sectionInset.right = 16
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "BannerCell")
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    init(delegate: UICollectionViewDelegate & UICollectionViewDataSource) {
        super.init(frame: .zero)
        backgroundColor = .white
        bannerCollectionView.delegate = delegate
        bannerCollectionView.dataSource = delegate
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(townLabel)
        addSubview(bannerCollectionView)
    }
    
    private func makeConstraints() {
        townLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(self.snp.leading).offset(16)
        }
        
        bannerCollectionView.snp.makeConstraints { make in
            make.top.equalTo(townLabel.snp.bottom).offset(24)
            make.leading.equalTo(self.snp.leading).offset(16)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(112)
        }
    }
}

extension MenuView: MenuDisplaysView {
    
}
