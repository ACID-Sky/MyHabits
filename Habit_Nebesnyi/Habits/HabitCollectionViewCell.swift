//
//  HabitCollectionViewCell.swift
//  Habit_Nebesnyi
//
//  Created by Лёха Небесный on 27.01.2023.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {

    private lazy var nameLabel = UILabel()
    private lazy var dateLabel = UILabel()
    private lazy var counterLabel = UILabel()
    private lazy var progressRing = UIImageView()

    var indexCell: Int = 0
    let notification = NotificationCenter.default

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupContentView()
        setupGestures()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupContentView() {
        self.contentView.backgroundColor = .systemBackground
        self.setupNameLabel()
        self.setupDateLabel()
        self.setupCounterLabel()
        self.setupProgressRing()
    }

    private func setupNameLabel() {
        nameLabel.font = Constants.headline
        nameLabel.textColor = .systemGray2
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 1

        self.contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Constants.spacingX2),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.spacingX2),
                ])
    }

    private func setupDateLabel() {
        dateLabel.font = Constants.caption
        dateLabel.textColor = .systemGray2
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.numberOfLines = 1

        self.contentView.addSubview(dateLabel)

        NSLayoutConstraint.activate([
            self.dateLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: Constants.spacing),
            self.dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.spacingX2),
                ])
    }

    private func setupCounterLabel() {
        counterLabel.font = Constants.footnoteStatus
        counterLabel.textColor = .systemGray
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        counterLabel.numberOfLines = 1

        self.contentView.addSubview(counterLabel)

        NSLayoutConstraint.activate([
            self.counterLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: Constants.spacingX2),
            self.counterLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.spacingX2),
                ])
    }

    private func setupProgressRing() {
        progressRing.translatesAutoresizingMaskIntoConstraints = false
        progressRing.isUserInteractionEnabled = true
        progressRing.contentMode = .scaleAspectFill

        self.contentView.addSubview(progressRing)

        NSLayoutConstraint.activate([
            self.progressRing.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.progressRing.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Constants.spacingX2),
            self.progressRing.widthAnchor.constraint(equalToConstant: 40),
            self.progressRing.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    func setup(with nameHabit: Habit, index: Int) {
        self.indexCell = index
        self.nameLabel.textColor = nameHabit.color
        self.nameLabel.text = nameHabit.name
        self.dateLabel.text = nameHabit.dateString
        self.counterLabel.text = "Счётчик: " + String(nameHabit.trackDates.count)
        self.progressRing.tintColor = nameHabit.color
        if nameHabit.isAlreadyTakenToday {
            self.progressRing.image = UIImage(systemName: "checkmark.circle.fill")
            self.progressRing.isUserInteractionEnabled = false
        } else{
            self.progressRing.image = UIImage(systemName: "circle")
            self.progressRing.isUserInteractionEnabled = true
        }
    }

    private func setupGestures() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.progressRing.addGestureRecognizer(tapGestureRecognizer)

    }

    @objc private func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        self.progressRing.isUserInteractionEnabled = false
        self.progressRing.image = UIImage(systemName: "checkmark.circle.fill")
        let store = HabitsStore.shared
        store.track(store.habits[indexCell])
        self.counterLabel.text = "Счётчик: " + String(store.habits[indexCell].trackDates.count)
        self.notification.post(name: Notification.Name("ReloadProgressCell"), object: nil)
    }
}
