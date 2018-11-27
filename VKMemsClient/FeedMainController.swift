import UIKit

class FeedMainController: UIViewController {

    var tableView: UITableView!
    let data = [Post()]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.pinBounds()
        tableView.register(MainCell.self, forCellReuseIdentifier: "1")
        tableView.reloadData()
    }
}

extension FeedMainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "1") as! MainCell

        cell.configure(post: data[0])
        return cell
    }

}
