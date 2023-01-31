//
//  ProgressCollectionViewCell.swift
//  Habit_Nebesnyi
//
//  Created by Лёха Небесный on 27.01.2023.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {

    private lazy var textLabel = UILabel()
    private lazy var percentLabel = UILabel()
    private lazy var progressLine = UIProgressView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupContentView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setupContentView() {
        self.contentView.backgroundColor = .systemBackground
        self.setupTextLabel()
        self.setupPercentLabel()
        self.setupProgressLine()
    }

    private func setupTextLabel() {
        textLabel.font = Constants.footnoteStatus
        textLabel.textColor = .systemGray2
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 1
        textLabel.text = "Всё получится!"

        self.contentView.addSubview(textLabel)

        NSLayoutConstraint.activate([
            self.textLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Constants.spacing),
            self.textLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.spacing),
                ])
    }

    private func setupPercentLabel() {
        percentLabel.font = Constants.footnoteStatus
        percentLabel.textColor = .systemGray2
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        percentLabel.numberOfLines = 1
        percentLabel.text = String(Int(HabitsStore.shared.todayProgress * 100.0))  + "%"

        self.contentView.addSubview(percentLabel)

        NSLayoutConstraint.activate([
            self.percentLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Constants.spacing),
            self.percentLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Constants.spacing),
                ])
    }
    private func setupProgressLine() {
        progressLine.progress = HabitsStore.shared.todayProgress
        progressLine.progressTintColor = Constants.colorPurple
        progressLine.trackTintColor = .systemGray2
        progressLine.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(progressLine)

        NSLayoutConstraint.activate([
            self.progressLine.topAnchor.constraint(equalTo: self.textLabel.bottomAnchor, constant: Constants.spacing),
            self.progressLine.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.spacing),
            self.progressLine.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Constants.spacing),
            self.progressLine.heightAnchor.constraint(equalToConstant: 6),
        ])
    }
}
