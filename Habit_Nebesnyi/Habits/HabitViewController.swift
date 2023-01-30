//
//  HabitViewController.swift
//  Habit_Nebesnyi
//
//  Created by Лёха Небесный on 25.01.2023.
//

import UIKit

class HabitViewController: UIViewController {

    private lazy var nameLabel = UILabel()
    private lazy var nameHabit = UITextField()
    private lazy var colorLabel = UILabel()
    private lazy var colorRing = UIImageView()
    private lazy var timeLabel = UILabel()
    private lazy var timeTextLabel = UILabel()
    private lazy var timeSet = UIDatePicker()

    let notification = NotificationCenter.default

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupSettingsView()
        setupNameLabel()
        setupNameHabit()
        setupColorLabel()
        setupColorRing()
        setupTimeLabel()
        setupTimeTextLabel()
        setupTimeSet()
        self.setupGestures()

    }

    private func setupSettingsView() {
        self.navigationItem.title = "Создать"

        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addNewHabit))
        saveButton.tintColor = Constants.colorPurple
        saveButton.style = .done
        self.navigationItem.rightBarButtonItem = saveButton

        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelGenerate))
        cancelButton.tintColor = Constants.colorPurple
        self.navigationItem.leftBarButtonItem = cancelButton
    }

    private func setupNameLabel() {
        nameLabel.font = Constants.headline
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 1
        nameLabel.text = "НАЗВАНИЕ"

        self.view.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Constants.spacingX2),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.spacing),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.spacing),
                ])
    }
    private func setupNameHabit() {
        nameHabit.translatesAutoresizingMaskIntoConstraints = false
        nameHabit.tag = 1
        nameHabit.backgroundColor = .systemBackground
        nameHabit.textColor = .black
        nameHabit.font = Constants.body
        nameHabit.autocapitalizationType = .none
        nameHabit.attributedPlaceholder = NSAttributedString(
            string: "Бегать по утрам, спать 8 часов и т.п.",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2]
        )
        nameHabit.delegate = self
        nameHabit.returnKeyType = .done
        nameHabit.autocapitalizationType = .sentences

        self.view.addSubview(nameHabit)

        NSLayoutConstraint.activate([
            self.nameHabit.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: Constants.spacing),
            self.nameHabit.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.spacing),
            self.nameHabit.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.spacing),
                ])
    }
    private func setupColorLabel() {
        colorLabel.font = Constants.headline
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        colorLabel.numberOfLines = 1
        colorLabel.text = "ЦВЕТ"

        self.view.addSubview(colorLabel)

        NSLayoutConstraint.activate([
            self.colorLabel.topAnchor.constraint(equalTo: self.nameHabit.bottomAnchor, constant: Constants.spacing),
            self.colorLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.spacing),
            self.colorLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.spacing),
                ])
    }
    private func setupColorRing() {
        colorRing.backgroundColor = Constants.colorOrenge
        colorRing.layer.cornerRadius = 20
        colorRing.translatesAutoresizingMaskIntoConstraints = false
        colorRing.isUserInteractionEnabled = true

        self.view.addSubview(colorRing)

        NSLayoutConstraint.activate([
            self.colorRing.topAnchor.constraint(equalTo: self.colorLabel.bottomAnchor, constant: Constants.spacing),
            self.colorRing.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.spacing),
            self.colorRing.widthAnchor.constraint(equalToConstant: 40),
            self.colorRing.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    private func setupTimeLabel() {
        timeLabel.font = Constants.headline
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.numberOfLines = 1
        timeLabel.text = "ВРЕМЯ"

        self.view.addSubview(timeLabel)

        NSLayoutConstraint.activate([
            self.timeLabel.topAnchor.constraint(equalTo: self.colorRing.bottomAnchor, constant: Constants.spacing),
            self.timeLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.spacing),
            self.timeLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.spacing),
                ])
    }

    private func setupTimeTextLabel() {
        timeTextLabel.font = Constants.body
        timeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        timeTextLabel.numberOfLines = 1
        timeTextLabel.text = "Каждый день в "

        self.view.addSubview(timeTextLabel)

        NSLayoutConstraint.activate([
            self.timeTextLabel.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: Constants.spacing),
            self.timeTextLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.spacing),
                ])
    }
    private func setupTimeSet() {
        timeSet.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(timeSet)
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm"
        let sTime = timeFormat.date(from: "08:00")
        timeSet.date = sTime!
        timeSet.datePickerMode = .time
        timeSet.tintColor = Constants.colorPurple

        NSLayoutConstraint.activate([
            self.timeSet.centerYAnchor.constraint(equalTo: self.timeTextLabel.centerYAnchor),
            self.timeSet.leadingAnchor.constraint(equalTo: self.timeTextLabel.trailingAnchor, constant: Constants.spacing),
                ])

    }

    @objc func addNewHabit() {
        let newHabit = Habit(name: self.nameHabit.text ?? "Выпить стакан воды перед завтраком",
                             date: self.timeSet.date,
                             color: self.colorRing.backgroundColor ?? Constants.colorOrenge)
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        print("🎁🎁🎁", newHabit.name, newHabit.date, newHabit.color)
        self.notification.post(name: Notification.Name("ReloadCell"), object: nil)
        dismiss(animated: true)
    }

    @objc func cancelGenerate() {
        dismiss(animated: true)
    }

    private func setupGestures() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.colorRing.addGestureRecognizer(tapGestureRecognizer)

    }

    @objc private func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        self.colorRing.isUserInteractionEnabled = false

        let chooseColor = UIColorPickerViewController()
        chooseColor.selectedColor = colorRing.backgroundColor ?? .black
        chooseColor.delegate = self
        present(chooseColor, animated: true)
    }

}

extension HabitViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.colorRing.backgroundColor = viewController.selectedColor
        self.colorRing.isUserInteractionEnabled = true
    }
}
