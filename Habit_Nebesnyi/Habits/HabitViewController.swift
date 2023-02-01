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
    private lazy var deletButton = UIButton()
    
    var indexHabit: Int? = nil
    let notification = NotificationCenter.default

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let store = HabitsStore.shared
        setupSettingsView()
        setupNameLabel()
        setupNameHabit(store)
        setupColorLabel()
        setupColorRing(store)
        setupTimeLabel()
        setupTimeTextLabel()
        setupTimeSet(store)
        self.setupGestures()
        if indexHabit != nil {
            setupButton()
        }

    }

    private func setupSettingsView() {
        self.navigationController?.navigationBar.tintColor = Constants.colorPurple
        var saveButton = UIBarButtonItem()
        if indexHabit == nil {
            self.navigationItem.title = "Создать"
            saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addNewHabit))
        }else{
            self.navigationItem.title = "Править"
            saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveEditHabit))
        }
        saveButton.style = .done
        self.navigationItem.rightBarButtonItem = saveButton

        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelGenerate))
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
    private func setupNameHabit(_ store: HabitsStore) {
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
        if indexHabit != nil {
            nameHabit.text = store.habits[indexHabit!].name
        }

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
    private func setupColorRing(_ store: HabitsStore) {
        if indexHabit == nil {
            colorRing.backgroundColor = Constants.colorOrenge
        }else{
            colorRing.backgroundColor = store.habits[indexHabit!].color
        }
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

    private func setupTimeSet(_ store: HabitsStore) {
        timeSet.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(timeSet)
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm"
        let sTime = timeFormat.date(from: "08:00")
        if indexHabit == nil {
            timeSet.date = sTime!
        }else{
            timeSet.date = store.habits[indexHabit!].date
        }
        timeSet.datePickerMode = .time
        timeSet.tintColor = Constants.colorPurple

        NSLayoutConstraint.activate([
            self.timeSet.centerYAnchor.constraint(equalTo: self.timeTextLabel.centerYAnchor),
            self.timeSet.leadingAnchor.constraint(equalTo: self.timeTextLabel.trailingAnchor, constant: Constants.spacing),
                ])
    }

    private func setupButton() {
        deletButton.translatesAutoresizingMaskIntoConstraints = false
        deletButton.setTitleColor(.systemRed, for: .normal)
        deletButton.setTitle("Удалить привычку", for: .normal)
        deletButton.addTarget(self, action:  #selector(buttonPresed), for: .touchUpInside)

        self.view.addSubview(deletButton)

        NSLayoutConstraint.activate([
            self.deletButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.deletButton.heightAnchor.constraint(equalToConstant: 50),
            self.deletButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                ])
    }

    @objc func addNewHabit() {
        let newHabit = Habit(name: self.nameHabit.text ?? "Выпить стакан воды перед завтраком",
                             date: self.timeSet.date,
                             color: self.colorRing.backgroundColor ?? Constants.colorOrenge)
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        self.notification.post(name: Notification.Name(Constants.reloadCell), object: nil)
        self.notification.post(name: Notification.Name(Constants.reloadProgressCell), object: nil)
        dismiss(animated: true)
    }

    @objc func saveEditHabit() {
        let store = HabitsStore.shared
        store.habits[self.indexHabit!].name = self.nameHabit.text ?? "Выпить стакан воды перед завтраком"
        store.habits[self.indexHabit!].date = self.timeSet.date
        store.habits[self.indexHabit!].color = self.colorRing.backgroundColor ?? Constants.colorOrenge
        store.save()
        self.notification.post(name: Notification.Name(Constants.reloadCell), object: nil)
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

    @objc private func buttonPresed () {
        let alert = UIAlertController(title: "Удалить привычку?", message: "Вы хотите удалить привычку '\(nameHabit.text ?? "Без названия")'?", preferredStyle: .alert)

        let yesAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            HabitsStore.shared.habits.remove(at: self.indexHabit!)
            self.notification.post(name: Notification.Name(Constants.reloadCell), object: nil)
            self.notification.post(name: Notification.Name(Constants.reloadProgressCell), object: nil)
            self.notification.post(name: Notification.Name(Constants.dismissView), object: nil)
            self.dismiss(animated: true)
        }
        let noAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

        alert.addAction(yesAction)
        alert.addAction(noAction)

        self.present(alert, animated: true, completion: nil)
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
