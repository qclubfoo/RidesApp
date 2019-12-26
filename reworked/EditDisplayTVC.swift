//
//  EditDisplay.swift
//  reworked
//
//  Created by Дмитрий on 24.12.2019.
//  Copyright © 2019 Дмитрий. All rights reserved.
//

import UIKit

class EditDisplayTVC: UITableViewController {
    
    weak var currentDay: DayClass?
    weak var mainTVC: MainTVC?
    @IBOutlet weak var dateOutlet: UILabel!
    @IBOutlet weak var metroOutlet: UILabel!
    @IBOutlet weak var tatOutlet: UILabel!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var metroTFOutlet: UITextField!
    @IBOutlet weak var tatTFOutlet: UITextField!
    
    // установка закруглений для кнопок (возможно лучше было создать кастомный класс кнопок?), назначение firstResponder, установка текущих значений даты и поездок в соответствующие Labels.
    override func viewDidLoad() {
        super.viewDidLoad()
        decreaseButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
        increaseButton.layer.cornerRadius = 10
        metroTFOutlet.becomeFirstResponder()
        guard let guardedCurrentDay = currentDay else { return }
        dateOutlet.text = guardedCurrentDay.date
        metroOutlet.text = String(guardedCurrentDay.metroRide)
        tatOutlet.text = String(guardedCurrentDay.tatRide)
    }
    
    // Обработка нажатия кнопки Decrease, уменьшающей текущие значения на значения из TextField ов после чего закрывается EditDisplayTVC и обновляются данные в MainTVC. Если введенные значения уменьшат текущее значение до отрицательного числа, то значение остается прежним.
    @IBAction func decreaseAction(_ sender: Any) {
        guard let guardedMainTVC = mainTVC else { return }
        let metro = Int(metroTFOutlet.text ?? "0") ?? 0
        let tat = Int(tatTFOutlet.text ?? "0") ?? 0
        if currentDay!.metroRide - metro >= 0 {
            currentDay?.metroRide -= metro
        }
        if currentDay!.tatRide - tat >= 0 {
            currentDay!.tatRide -= tat
        }
        dismiss(animated: true, completion: nil)
        guardedMainTVC.tableView.reloadData()
    }
    // Обработка нажатия кнопки Increase, увеличивающей текущие значения на значения из TextField ов после чего закрывается EditDisplayTVC и обновляются данные в MainTVC
    @IBAction func increaseAction(_ sender: Any) {
        guard let guardedMainTVC = mainTVC else { return }
        let metro = Int(metroTFOutlet.text ?? "0") ?? 0
        let tat = Int(tatTFOutlet.text ?? "0") ?? 0
        currentDay?.metroRide += metro
        currentDay?.tatRide += tat
        dismiss(animated: true) { guardedMainTVC.tableView.reloadData() }
    }
    
    // Обработка нажатия кнопки Cancel, просто закрывает EditDisplayTVC и возвращает в MainTVC
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
// метод для перехода в TableViewController: EditDisplayTVC, возвращающий EditDisplayTVC
    static func storyboardInstance() -> EditDisplayTVC? {
        let storyboard = UIStoryboard(name: "EditDisplayTVC", bundle: nil)
        return storyboard.instantiateInitialViewController() as? EditDisplayTVC
    }
}
