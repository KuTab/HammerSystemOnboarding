//
//  MenuViewController.swift
//  HammerSystemOnboarding
//
//  Created by Egor Dadugin on 04.04.2023.
//

import UIKit
import SnapKit

protocol MenuDisplayLogic: AnyObject {
    func displayFood(_ viewModel: MenuDataFlow.ViewModel)
}

class MenuViewController: UIViewController {
    private var interactor: MenuBusinessLogic
    private let images = [UIImage(named: "BK"), UIImage(named: "BK")]
    private let bannerViewHeight: CGFloat = 112
    private var pizza: [PresentedFood]
    private var deserts: [PresentedFood]
    private var options: [String] =  ["Pizza", "Deserts"]
    
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
    
    var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 88, height: 32)
        layout.sectionInset.right = 8
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCell")
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 375, height: 156)
        layout.sectionInset.right = 8
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FoodCell.self, forCellWithReuseIdentifier: "FoodCell")
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    init(interactor: MenuBusinessLogic) {
        self.interactor = interactor
        self.pizza = []
        self.deserts = []
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchFood(.init())
    }
    
    private func addSubviews() {
        view.addSubview(townLabel)
        view.addSubview(bannerCollectionView)
        view.addSubview(categoryCollectionView)
        view.addSubview(menuCollectionView)
    }
    
    private func makeConstraints() {
        townLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(view.snp.leading).offset(16)
        }
        
        bannerCollectionView.snp.makeConstraints { make in
            make.top.equalTo(townLabel.snp.bottom).offset(24)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(bannerViewHeight)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(bannerCollectionView.snp.bottom).offset(32)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(32)
        }
        
        menuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(24)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
}

extension MenuViewController: MenuDisplayLogic {
    func displayFood(_ viewModel: MenuDataFlow.ViewModel) {
        self.pizza = viewModel.presentedPizza
        self.deserts = viewModel.presenteDeserts
        menuCollectionView.reloadData()
    }
}

extension MenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            switch indexPath.row {
            case 0:
                menuCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            case 1:
                menuCollectionView.scrollToItem(at: IndexPath(row: 0, section: 1), at:  .top, animated: true)
            default:
                return
            }
        }
    }
}

extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerCollectionView {
            return images.count
        } else if collectionView == categoryCollectionView {
            return options.count
        } else if collectionView == menuCollectionView {
            return section == 0 ? pizza.count : deserts.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath)
            let image = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: cell.bounds.size.height))
            image.image = images[indexPath.row]
            cell.contentView.addSubview(image)
            cell.layer.cornerRadius = 5
            return cell
        } else if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath)
            cell.backgroundColor = .lightGray
            let title = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: 16))
            title.textAlignment = .center
            title.textColor = .white
            title.text = options[indexPath.row]
            title.center = cell.contentView.center
            cell.contentView.addSubview(title)
            cell.layer.cornerRadius = 16
            return cell
        } else if collectionView == menuCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as! FoodCell
            let menuItem = indexPath.section == 0 ? pizza[indexPath.row] : deserts[indexPath.row]
            cell.titleLabel.text = menuItem.name
            cell.descriptionLabel.text = menuItem.description
            cell.priceLabel.text = "от \(menuItem.price) р"
            cell.loadImage(for: menuItem.image)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == menuCollectionView {
            return 2
        }
        return 1
    }
}

extension MenuViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if menuCollectionView.contentOffset.y > 0 {
            bannerCollectionView.snp.updateConstraints { make in
                make.height.equalTo(bannerViewHeight - menuCollectionView.contentOffset.y)
                UIView.animate(withDuration: 0.2) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
}
