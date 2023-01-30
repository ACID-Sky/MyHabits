//
//  InfoViewController.swift
//  Habit_Nebesnyi
//
//  Created by Лёха Небесный on 23.01.2023.
//

import UIKit

class InfoViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var headLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.headline
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = "Привычка за 21 день"
        return label
    }()

    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.body
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму: \n\n1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага. \n\n2. Выдержать 2 дня в прежнем состоянии самоконтроля. \n\n3. Отметить в дневнике первую неделю изменений и подвести первые итоги – что оказалось тяжело, что – легче, с чем еще предстоит серьезно бороться. \n\n4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств. \n\n5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой. \n\n6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся. \n\nИсточник: psychbook.ru"
        return label
    }()




    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Информация"
        
        setupScrollView()
        setupHeadLabel()
        setupInfoLabel()

    }

    private func setupScrollView() {
        self.view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func setupHeadLabel() {
        scrollView.addSubview(headLabel)
        NSLayoutConstraint.activate([
            self.headLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            self.headLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            self.headLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8),
        ])
    }

    private func setupInfoLabel() {
        scrollView.addSubview(infoLabel)
        NSLayoutConstraint.activate([
            self.infoLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 16),
            self.infoLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            self.infoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            self.infoLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
        ])
    }



}
