//
//  HabitDetailsViewController.swift
//  Habit_Nebesnyi
//
//  Created by Лёха Небесный on 30.01.2023.
//

import UIKit

class HabitDetailsViewController: UIViewController {

    private lazy var tableView = UITableView(frame: .zero, style: .grouped)

    private lazy var indexHabit: Int = 0
    private lazy var countOfDaysTracked: Int = 0
    let ncObserver = NotificationCenter.default

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettingsView()
        setupTableView()
        ncObserver.addObserver(self, selector: #selector(self.dismissView), name: Notification.Name("DismissView"), object: nil)
    }
    
    private func setupSettingsView() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.tintColor = Constants.colorPurple

        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editHabit))
        editButton.style = .done
        self.navigationItem.rightBarButtonItem = editButton
    }

    private func setupTableView () {
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(tableView)

        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                ])
    }

    func setupCountOfDaysTracked(for Index: Int) {
        self.indexHabit = Index
        self.navigationItem.title = HabitsStore.shared.habits[Index].name

        for (_, date) in HabitsStore.shared.dates.enumerated() {
            HabitsStore.shared.habit(HabitsStore.shared.habits[Index], isTrackedIn: date) ? countOfDaysTracked += 1 : nil
        }
    }

    @objc func editHabit() {
        let editHabit = HabitViewController()
        editHabit.indexHabit = indexHabit
        let editView = UINavigationController(rootViewController: editHabit)
        editView.modalPresentationStyle = .fullScreen
        present(editView, animated: true)
    }

    @objc func dismissView() {
        self.navigationController?.popViewController(animated: true)
    }

}

extension HabitDetailsViewController: UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.countOfDaysTracked
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "АКТИВНОСТЬ"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "DD MMMM yyyy"
        let dayBack = HabitsStore.shared.habits[indexHabit].trackDates.sorted(by: >)
        let date: String = dateFormatter.string(from: dayBack[indexPath.item])
        let today = Calendar.current.startOfDay(for: Date())
        let date0 = dateFormatter.string(from: today)
        let date1 = dateFormatter.string(from: (today - (60*60*24)))
        let date2 = dateFormatter.string(from: (today - 2*(60*60*24)))
        let cell = UITableViewCell()
        switch date {
        case date0:
            cell.textLabel?.text = "Сегодня"
        case date1:
            cell.textLabel?.text = "Вчера"
        case date2:
            cell.textLabel?.text = "Позавчера"
        default:
            cell.textLabel?.text = date
        }
        return cell
    }
}
