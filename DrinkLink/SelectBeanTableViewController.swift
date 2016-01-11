import UIKit

class SelectBeanTableViewController: UITableViewController {
    
    var sender: ViewController?
    var senderSegue: NSString?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Bean"
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        cell.textLabel!.text = "Test"
        cell.detailTextLabel!.text = "-42"

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (senderSegue == "wheel") {
            sender!.wheelBeanSelected()
        } else {
            sender!.beerBeanSelected()
        }
        navigationController!.popViewControllerAnimated(true)
    }

}
