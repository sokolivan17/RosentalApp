//
//  ProfileViewController.swift
//  RosentalApp
//
//  Created by Ваня Сокол on 31.08.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private var username: String?
    private var password: String?
    
    private var profileData: ProfileModel?

    private let notificationButton = NotificationButton()
    private let profileInfoView = ProfileInfoView()
    private let whiteView = UIView()
    private let allServicesButton = UIButton()
    private let dateLabel = UILabel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = createCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: MessageCell.reuseID)
        collectionView.register(BillCell.self, forCellWithReuseIdentifier: BillCell.reuseID)
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.reuseID)
        collectionView.register(ServiceCell.self, forCellWithReuseIdentifier: ServiceCell.reuseID)
        return collectionView
    }()
    
    init(username: String? = nil, password: String? = nil) {
        self.username = username
        self.password = password
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupUI()
        setupLayout()
        getProfileInfo(for: username, password: password)
    }
    
    private func getProfileInfo(for username: String?, password: String?) {
        guard let username,
              let password
        else { return }
        
        NetworkService.shared.makedDashboardRequest(for: username, password: password) { [weak self] result in
            guard let self else { return }
            
            switch result {
                
            case .success(let response):
                self.profileData = response
                
                DispatchQueue.main.async {
                    self.profileInfoView.configureView(with: response.myProfile)
                    self.setupDateLabel(with: response.customerDashboard.date)
                    self.notificationButton.configure(with: response)
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "profileBackgroundBlue")
        
        whiteView.backgroundColor = .systemBackground
        whiteView.layer.cornerRadius = 16
        
        allServicesButton.setTitle("Все сервисы", for: .normal)
        allServicesButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        allServicesButton.backgroundColor = UIColor(named: "orangeButton")
        allServicesButton.setTitleColor(.black, for: .normal)
        allServicesButton.layer.cornerRadius = 8
        
        setupDateLabel(with: "")
    }
    
    private func setupDateLabel(with text: String) {
        let firstAttributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 26), NSAttributedString.Key.foregroundColor : UIColor.black]
        
        let secondAttributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 26), NSAttributedString.Key.foregroundColor : UIColor.lightGray]
        
        let firstAttributedString = NSMutableAttributedString(string:"Сегодня ", attributes: firstAttributes)
        let secondAttributedString = NSMutableAttributedString(string: text, attributes: secondAttributes)
        
        firstAttributedString.append(secondAttributedString)
        dateLabel.attributedText = firstAttributedString
    }
    
    private func setupLayout() {
        let views = [whiteView, notificationButton, profileInfoView, dateLabel, collectionView, allServicesButton]
        
        views.forEach { item in
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            profileInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            profileInfoView.heightAnchor.constraint(equalToConstant: 50),
            
            notificationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            notificationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            notificationButton.widthAnchor.constraint(equalToConstant: 30),
            notificationButton.heightAnchor.constraint(equalToConstant: 38),
            
            whiteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            whiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 26),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -208),
            
            allServicesButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            allServicesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            allServicesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            allServicesButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in

            switch sectionIndex {

            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.98),
                                                      heightDimension: .fractionalHeight(1))
                let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                                       heightDimension: .fractionalHeight(0.14))
                let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [layoutItem])

                let sectionLayout = NSCollectionLayoutSection(group: layoutGroup)
                sectionLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0)
                sectionLayout.orthogonalScrollingBehavior = .groupPaging
                return sectionLayout
                
            case 1:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(1))
                let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(70))
                let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                                     subitems: [layoutItem])

                let sectionLayout = NSCollectionLayoutSection(group: layoutGroup)
                sectionLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0)
                return sectionLayout

            case 2:
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.98),
                                                      heightDimension: .fractionalHeight(1))
                let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                       heightDimension: .fractionalHeight(0.20))
                let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [layoutItem])

                let sectionLayout = NSCollectionLayoutSection(group: layoutGroup)
                sectionLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0)
                sectionLayout.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                return sectionLayout
                
            case 3:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(1))
                let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(110))
                let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: layoutItem, count: 3)

                let sectionLayout = NSCollectionLayoutSection(group: layoutGroup)
                sectionLayout.orthogonalScrollingBehavior = .continuous
                return sectionLayout
            default:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(1))
                let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 2),
                                                       heightDimension: .fractionalHeight(1 / 1.5))
                let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: layoutItem, count: 2)

                let sectionLayout = NSCollectionLayoutSection(group: layoutGroup)
                sectionLayout.orthogonalScrollingBehavior = .groupPaging
                return sectionLayout
            }
        }
    }
}


extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return profileData?.customerDashboard.menuItems.count ?? 1
        case 2:
            return profileData?.customerDashboard.banners.count ?? 1
        case 3:
            return profileData?.customerDashboard.services.count ?? 1
        default:
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCell.reuseID, for: indexPath) as? MessageCell
            cell?.configure(with: profileData?.customerDashboard.notifications)
            return cell ?? UICollectionViewCell()
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BillCell.reuseID, for: indexPath) as? BillCell
            let model = profileData?.customerDashboard.menuItems[indexPath.row]
            cell?.configure(with: model)
            return cell ?? UICollectionViewCell()
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.reuseID, for: indexPath) as? BannerCell
            let model = profileData?.customerDashboard.banners[indexPath.row]
            cell?.configure(with: model)
            return cell ?? UICollectionViewCell()
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceCell.reuseID, for: indexPath) as? ServiceCell
            let model = profileData?.customerDashboard.services[indexPath.row]
            cell?.configure(with: model)
            return cell ?? UICollectionViewCell()
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.reuseID, for: indexPath) as? BannerCell
            let model = profileData?.customerDashboard.banners[indexPath.row]
            cell?.configure(with: model)
            return cell ?? UICollectionViewCell()
        }
    }
}
