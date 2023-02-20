////
////  DemoVC.swift
////  mvcsample
////
////  Created by Nguyen Dinh Dong on 25/11/2022.
////
//
//import UIKit
//import SDCAlertView
//
//class DemoVC: BaseVC {
//    @IBOutlet var tableView: UITableView!
//
//    var todos: [Todo] = [] {
//        didSet {
//            // Mỗi lần thay đổi todos thì reload tableview
//            tableView.reloadData()
//        }
//    }
//
//    var realmUseCase: TodosUseCase?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.register(cellType: DemoCell.self)
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTodo))
//
//        realmUseCase = RMUseCaseProvider().makeTodosUseCase()
//
//        // tải dữ liệu khi lần đầu vào màn hình này
//        loadData()
//    }
//
//    // Thêm todo
//    @objc func addTodo() {
//        // Khởi tạo đối tượng todo
//        let todo = Todo()
//        todo.name = String.random(ofLength: 10)
//        
//        // Chèn vào array todos
//        todos.insert(todo, at: 0)
//        todo.status = .inProgress
//        todo.comment = String(randomOfLength: 50)
//        
//        // Lưu vào realm
//        realmUseCase?.save(todo: todo)
//    }
//
//    // Tải dữ liệu
//    func loadData() {
//        
//        // Tải dữ liệu từ realm
//        realmUseCase?.getAll(complete: { todoArray in
//            self.todos = todoArray.sorted { $0.createAt > $1.createAt }
//        })
//    }
//    
//    func delete(item: Todo) {
//        // Lọc các phần tử khác với phần tử chuẩn bị xoá
//        todos = todos.filter { $0.uid != item.uid }
//        
//        // cập nhật lại ui
//        tableView.reloadData()
//        
//        // Xoá phần tử khỏi realm
//        realmUseCase?.delete(todo: item)
//        
//        
//    }
//    
//    func alertDelete(todo: Todo) {
//        let alert = AlertController(title: "Cảnh báo", message: "Bạn có muốn xoá todo: \(todo.name) không?", preferredStyle: .alert)
//        alert.addAction(AlertAction(title: "Cancel", style: .normal))
//        alert.addAction(AlertAction(title: "OK", style: .preferred, handler: { act in
//            self.delete(item: todo)
//        }))
//        alert.present()
//    }
//    
//}
//
//extension DemoVC: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return todos.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(with: DemoCell.self, for: indexPath)
//        let todo = todos[indexPath.row]
//        cell.contentLabel.text = todo.name
//        cell.createAtLabel.text = todo.getDateCreate()
//        
//        cell.onTapDelete = {
//            self.alertDelete(todo: todo)
//        }
//        
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 66
//    }
//}
