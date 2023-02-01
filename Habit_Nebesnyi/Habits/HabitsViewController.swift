//
//  HabitsViewController.swift
//  Habit_Nebesnyi
//
//  Created by Лёха Небесный on 23.01.2023.
//

import UIKit

class HabitsViewController: UIViewController {

    private lazy var layout = UICollectionViewFlowLayout ()
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                        collectionViewLayout: self.layout)
    let ncObserver = NotificationCenter.default

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettingsView()
        setupLoyoutCollectionView()
        setupCollectionView()
        ncObserver.addObserver(self, selector: #selector(self.reloadCell), name: Notification.Name(Constants.reloadCell), object: nil)
    }

    private func setupSettingsView() {
        self.view.backgroundColor = Constants.colorGray

        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Сегодня"

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHabit))
        addButton.tintColor = Constants.colorPurple
        self.navigationItem.rightBarButtonItem = addButton
    }

    private func setupLoyoutCollectionView() {
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = Constants.spacing
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = Constants.colorGray
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.defaultCellID)
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: Constants.progressCellID)
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: Constants.habitCellID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false

        self.view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.spacingX2),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.spacingX2),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    @objc func addHabit() {
        let addNewHabit = UINavigationController(rootViewController: HabitViewController())
        addNewHabit.modalPresentationStyle = .fullScreen
        present(addNewHabit, animated: true)
    }

    @objc func reloadCell() {
        collectionView.reloadData()
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return HabitsStore.shared.habits.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.progressCellID, for: indexPath) as? ProgressCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.defaultCellID, for: indexPath)
                return cell
            }
            cell.layer.cornerRadius = Constants.cornRadius
            cell.clipsToBounds = true
            return cell
        } else {
            for (index, habit) in HabitsStore.shared.habits.enumerated() where indexPath.item == index {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.habitCellID, for: indexPath) as? HabitCollectionViewCell else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.defaultCellID, for: indexPath)
                    return cell
                }
                cell.setup(with: habit, index: index)
                cell.layer.cornerRadius = Constants.cornRadius
                cell.clipsToBounds = true
                return cell
            }
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.defaultCellID, for: indexPath)
        return cell
    }
}


extension HabitsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return .init(top: Constants.spacingX3, left: 0, bottom: Constants.spacingX2, right: 0) 
        }
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: 50)
        } else {
            return CGSize(width: collectionView.frame.width, height: 110)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let store = HabitsStore.shared
        let info = HabitDetailsViewController()
        info.setupCountOfDaysTracked(for: indexPath.item, store: store)
        self.navigationController?.pushViewController(info, animated: true)
    }
}
