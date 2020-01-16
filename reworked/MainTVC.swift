//
//  MainDisplay.swift
//  reworked
//
//  Created by Дмитрий on 24.12.2019.
//  Copyright © 2019 Дмитрий. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class MainTVC: UITableViewController, CustomCellClassDelegate, AddDisplayTVCDelegate, EditDisplayTVCDelegate {
 
    var daysArray = [DayClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        daysArray = getJSON()
    }

    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        daysArray = CoreDataService.shared.daysFetchRequest(entityName: "DayClass")
    }
    
    // Action кнопки для создания новой ячейки. Сначала вызывается метод storyboardInstance() для получения контроллера, к которому будет осуществлен переход. Затем этот контроллер презентится на экран. После чего сетится ссылка на контроллер вызвавший это переход внутри вызываемого контроллера.
    @IBAction func addNewCell(_ sender: Any) {
        if let addDisplayTVC = AddDisplayTVC.storyboardInstance() {
            present(addDisplayTVC, animated: true, completion: nil)
            addDisplayTVC.mainTVCdelegate = self
        }
    }
    @IBAction func editCell(_ sender: Any) {
        if let editDistplayTVC = EditDisplayTVC.storyboardInstance() {
            present(editDistplayTVC, animated: true, completion: nil)
            
        }
    }
    
    // метод возвращает количество ячеек, которые будут созданы. Возвращаемое значение получает по количеству элементов в массиве daysArray.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysArray.count
    }

    // метод возвращает ячейку, которая будет создана в соответствующем IndexPath. далее ячейка преобразуется к кастомному виду CustomCellClass. до return доступна для дальнейшей настройки или модификации.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomCellClass else { return UITableViewCell() }
        cell.delegate = self
        textConfig(for: cell, with: daysArray[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let managedContext = appDelegate.persistentContainer.viewContext
        let managedContext = CoreDataService.shared.managedContext
        let day = daysArray[indexPath.row]
        managedContext.delete(day)
        daysArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        saveCoreData(inContext: managedContext)
    }
    
    func saveCoreData(inContext context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch let error as NSError {
            print("CCould not save. \(error), \(error.userInfo)")
            }
    }

    // метод вызывается в AddDisplayTVC, в него передаются данные для заполнения массива с данными. Сначала создается новый элемент в массиве, затем его элементам присваиваются значения. После вызывается метод для вставки ячейки с этими данными. При попытке добавить значение с такой же датой, поездки добавятся к существующей ячейке. Добавлен поиск ячейки с такой же датой, при нахождении такой, пополняются ее значения вместо создания новой.
    func addDataInArray(data: (dateAsDate: Date, date: String, metroRides: Int, tatRides: Int)) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let managedContext = appDelegate.persistentContainer.viewContext
        let managedContext = CoreDataService.shared.managedContext
        if (data.metroRides != 0 || data.tatRides != 0) {
            if let index = daysArray.firstIndex(where: {$0.date == data.date}){
                daysArray[index].tatRide += data.tatRides
                daysArray[index].metroRide += data.metroRides
        } else {
                if let entity = CoreDataService.shared.getEntity(byName: "DayClass"){
                    let day = DayClass(insertInto: managedContext, entity: entity, data: data)
                    daysArray.append(day)
                    daysArray.sort(by: {$0.dateAsDate > $1.dateAsDate})
                }
        }
        saveCoreData(inContext: managedContext)
        }
    }
    
    
    // метод для установки значений в кастомные ячейки.
    func textConfig(for cell: UITableViewCell, with item: DayClass) {
        guard let customCell = cell as? CustomCellClass else { return }
        customCell.dateLabel.text = item.date
        customCell.metroNumLabel.text = String(item.metroRide)
        customCell.tatNumLabel.text = String(item.tatRide)
        customCell.totalSpentLabel.text = String(item.metroCost * item.metroRide + item.tatCost * item.tatRide) + " rub."
    }

    // метод создает ячейку с соответствующим индексом и добавляет ее к TableView
    func addCellWhithData(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    // метод получает данные по приложенной ссылке, парсит их и возвращает массив данных.
//    func getJSON() ->  [DayClass] {
//        let urlString = "https://firebasestorage.googleapis.com/v0/b/ridescount.appspot.com/o/DaysArray.json?alt=media&token=ce1d0d03-f00f-47cb-a9f4-602932f77262"
//        let url = URL(string: urlString)!
//            do {
//                let data = try Data(contentsOf: url, options: .alwaysMapped)
//                let decoder = JSONDecoder()
//                let modelArray = try decoder.decode([DayClass].self, from: data)
//                return modelArray
//            } catch let parsingError {
//                print("Error", parsingError)
//        }
//        return []
//    }
    

    // делегатская функция класса CustomCellClass. Через нее проихсодит обработка кнопки находящейся в ячейке (ячейка подается как параметр в функцию), далее из нее извлекается индекс ячейки в которой нужно будет изменить данные.
    func didTapButton(cell: CustomCellClass) {
        if let editDistplayTVC = EditDisplayTVC.storyboardInstance() {
            guard let i =  tableView.indexPath(for: cell)?.row else { return }
            editDistplayTVC.currentDay = daysArray[i]
            editDistplayTVC.mainTVCdelegate = self
            present(editDistplayTVC, animated: true, completion: nil)
        }
    }
    
    func increaseFunction(_ metro: Int, _ tat: Int, _ currentDay: DayClass) {
        currentDay.metroRide += metro
        currentDay.tatRide += tat
    }
    
    func decreaseFunction(_ metro: Int, _ tat: Int, _ currentDay: DayClass) {
        if currentDay.metroRide - metro >= 0 {
            currentDay.metroRide -= metro
        }
        if currentDay.tatRide - tat >= 0 {
            currentDay.tatRide -= tat
        }
    }
    
    func updateValues() {
        tableView.reloadData()
    }
}
