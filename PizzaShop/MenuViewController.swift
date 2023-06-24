//
//  MenuController.swift
//  PizzaShop
//
//  Created by Алексей Ревякин on 23.06.2023.
//

import UIKit
import SnapKit

protocol MenuDisplayLogic: AnyObject {
    func displayPromos(viewModel: MenuModels.FetchPromos.ViewModel)
    func displayCategories(viewModel: MenuModels.FetchCategories.ViewModel)
    func displayFood(viewModel: MenuModels.FetchFood.ViewModel)
}

class MenuViewController: UIViewController {
    //MARK: UIElements
    private var menuItems: [UIAction] {
        return [
            UIAction(title: "Москва", handler: {_ in }),
            UIAction(title: "Санкт-Петербург", handler: {_ in }),
            UIAction(title: "Саранск", handler: {_ in }),
            UIAction(title: "Сочи", handler: {_ in })
        ]
    }
    private var menuCity: UIMenu {
        return UIMenu(children: menuItems)
    }
    lazy var leftBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        let button: UIButton = {
            let button = UIButton(type: .system)
            button.showsMenuAsPrimaryAction = true
            button.setTitle("Москва", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            button.setTitleColor(.black, for: .normal)
            button.setTitleColor(.black, for: .highlighted)
            button.menu = menuCity
            var config = UIButton.Configuration.plain()
            config.image = R.Image.arrow
            config.imagePadding = 8
            config.imagePlacement = .trailing
            button.configuration = config
            return button
        }()
        barButtonItem.customView = button
        return barButtonItem
    }()
    private let promoIdentifire = "promoCell"
    private lazy var promoCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width * 0.8, height: view.bounds.height * 0.15)
        layout.sectionInset = UIEdgeInsets(top: 0, left: view.bounds.width * 0.05, bottom: 0, right: view.bounds.width * 0.05)
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = R.Color.viewBackground
        collection.dataSource = self
        collection.register(MenuPromoCollectionViewCell.self, forCellWithReuseIdentifier: promoIdentifire)
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    private let categoryIdentifire = "categoryCell"
    private lazy var categoryCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 88, height: 32)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: view.bounds.width * 0.05, bottom: 0, right: view.bounds.width * 0.05)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = R.Color.viewBackground
        collection.dataSource = self
        collection.delegate = self
        collection.showsHorizontalScrollIndicator = false
        collection.register(MenuCategoryCollectionViewCell.self, forCellWithReuseIdentifier: categoryIdentifire)
        return collection
    }()
    private let foodIdentifire = "foodCell"
    private lazy var foodTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 20
        tableView.layer.masksToBounds = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MenuFoodTableViewCell.self, forCellReuseIdentifier: foodIdentifire)
        tableView.allowsSelection = false
        tableView.panGestureRecognizer.addObserver(self, forKeyPath: "state", options: [.new,.old], context: nil)
        tableView.addObserver(self, forKeyPath: "contentOffset", options: [.new,.old], context: nil)
        return tableView
    }()

    var interactor: MenuBusinessLogic?
    
    var promosImageData: [Data] = []
    var categories: [String] = []
    var pizzas: [MenuModels.FetchFood.ViewModel.FoodDisplay] = []
    var burgers: [MenuModels.FetchFood.ViewModel.FoodDisplay] = []
    var desserts: [MenuModels.FetchFood.ViewModel.FoodDisplay] = []
    var drinks: [MenuModels.FetchFood.ViewModel.FoodDisplay] = []
    var foods: [MenuModels.FetchFood.ViewModel.FoodDisplay] = []
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureUI()
        layout()
        getPromos()
        getCategories()
        getPizzas()
    }
    
    private func configureUI() {
        view.backgroundColor = R.Color.viewBackground
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        view.addSubview(promoCollection)
        view.addSubview(categoryCollection)
        view.addSubview(foodTableView)
    }
    
    private func layout() {
        promoCollection.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(view.bounds.height * 0.15)
        }
        categoryCollection.snp.makeConstraints { make in
            make.top.equalTo(promoCollection.snp.bottom).offset(24)
            make.left.right.equalToSuperview()
            make.height.equalTo(32)
        }
        foodTableView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollection.snp.bottom).offset(24)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setup() {
        let interactor = MenuInteractor()
        let presenter = MenuPresenter()
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
    }
    
    private func getPromos() {
        let request = MenuModels.FetchPromos.Request()
        interactor?.getPromos(request: request)
    }
    
    private func getCategories() {
        let request = MenuModels.FetchCategories.Request()
        interactor?.getCategories(request: request)
    }
    
    private func getPizzas() {
        let request = MenuModels.FetchFood.Request(category: .pizzas)
        interactor?.getFoods(request: request)
    }
    
    private func getBurgers() {
        let request = MenuModels.FetchFood.Request(category: .burgers)
        interactor?.getFoods(request: request)
    }
    
    private func getDesserts() {
        let request = MenuModels.FetchFood.Request(category: .desserts)
        interactor?.getFoods(request: request)
    }
    
    private func getDrinks() {
        let request = MenuModels.FetchFood.Request(category: .drinks)
        interactor?.getFoods(request: request)
    }
    
}

//MARK: - UICollectionViewDataSource
extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == promoCollection {
            return promosImageData.count
        } else if collectionView == categoryCollection{
            return categories.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == promoCollection {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: promoIdentifire, for: indexPath) as? MenuPromoCollectionViewCell else { return UICollectionViewCell()}
            cell.configure(with: promosImageData[indexPath.row])
            return cell
        } else if collectionView == categoryCollection {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryIdentifire, for: indexPath) as? MenuCategoryCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(with: categories[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tableIndexPath = IndexPath(row: indexPath.row * 10, section: 0)
        foodTableView.scrollToRow(at: tableIndexPath, at: .top, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: foodIdentifire, for: indexPath) as? MenuFoodTableViewCell else { return UITableViewCell()}
        let food = foods[indexPath.row]
        cell.configure(image: food.image,
                       name: food.name,
                       desription: food.description,
                       cost: food.cost)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

//MARK: - MenuDisplayLogic
extension MenuViewController: MenuDisplayLogic {
    func displayPromos(viewModel: MenuModels.FetchPromos.ViewModel) {
        self.promosImageData = viewModel.imageData
        DispatchQueue.main.async {
            self.promoCollection.reloadData()
        }
    }
    
    func displayCategories(viewModel: MenuModels.FetchCategories.ViewModel) {
        self.categories = viewModel.categories
        self.categoryCollection.reloadData()
    }
    
    func displayFood(viewModel: MenuModels.FetchFood.ViewModel) {
        let group = DispatchGroup()
        group.enter()
        switch viewModel.category {
        case .pizzas:
            pizzas = viewModel.foods
            foods += viewModel.foods
            DispatchQueue.main.async {
                group.leave()
            }
            group.notify(queue: .main) {
                self.foodTableView.reloadData()
                self.getBurgers()
            }
        case .burgers:
            burgers = viewModel.foods
            foods += viewModel.foods
            DispatchQueue.main.async {
                group.leave()
            }
            group.notify(queue: .main) {
                self.foodTableView.reloadData()
                self.getDesserts()
            }
        case .desserts:
            desserts = viewModel.foods
            foods += viewModel.foods
            DispatchQueue.main.async {
                group.leave()
            }
            group.notify(queue: .main) {
                self.getDrinks()
            }
        case .drinks:
            drinks = viewModel.foods
            foods += viewModel.foods
            DispatchQueue.main.async {
                self.foodTableView.reloadData()
                group.leave()
            }
        }
    }
}

extension MenuViewController {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" {
            let contentOffset = foodTableView.contentOffset.y
            if contentOffset <  180 * 10 {
                let indexPath = IndexPath(row: 0, section: 0)
                selectedCategoryCollectionCell(for: indexPath)
            } else if contentOffset >= 180 * 10 && contentOffset < 180 * 20 {
                let indexPath = IndexPath(row: 1, section: 0)
                selectedCategoryCollectionCell(for: indexPath)
            } else if contentOffset >= 180 * 20 && contentOffset < 180 * 30 {
                let indexPath = IndexPath(row: 2, section: 0)
                selectedCategoryCollectionCell(for: indexPath)
            } else {
                let indexPath = IndexPath(row: 3, section: 0)
                selectedCategoryCollectionCell(for: indexPath)
            }
        }
    }
    
    func selectedCategoryCollectionCell(for indexPath: IndexPath) {
        categoryCollection.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}
