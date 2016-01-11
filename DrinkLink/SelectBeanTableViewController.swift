import UIKit
import Bean_iOS_OSX_SDK

class SelectBeanTableViewController: UITableViewController, PTDBeanManagerDelegate {
    
    @IBOutlet var tV: UITableView!
    
    var sender: ViewController?
    var senderSegue: NSString?
    var beanManager: PTDBeanManager?

    var beans = [PTDBean]()
    var beansSeen = Set<NSUUID>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Bean"
        self.navigationController!.toolbarHidden = false
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        beanManager = appDelegate.beanManager!
        beanManager!.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        startScanning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        stopScanning()
    }
    
    @IBAction func refreshTapped(sender: AnyObject) {
        startScanning()
    }
    
    // MARK: - Bean methods
    
    func startScanning() {
        beans.removeAll()
        beansSeen.removeAll()
        var error: NSError?
        beanManager!.startScanningForBeans_error(&error)
        if let e = error {
            print(e)
        }
    }
    
    func stopScanning() {
        var error: NSError?
        beanManager!.stopScanningForBeans_error(&error)
        if let e = error {
            print(e)
        }
    }
    
    // MARK: - BeanManager delegate
    
    func beanManager(beanManager: PTDBeanManager!, didDiscoverBean bean: PTDBean!, error: NSError!) {
        if !beansSeen.contains(bean.identifier) {
            beansSeen.insert(bean.identifier)
            beans.append(bean)
        }
        tV.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beans.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let bean = beans[indexPath.row]
        cell.textLabel!.text = bean.name
        cell.detailTextLabel!.text = "\(bean.RSSI)"

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let bean = beans[indexPath.row]
        if (senderSegue == "wheel") {
            sender!.wheelBeanSelected(bean)
        } else {
            sender!.beerBeanSelected(bean)
        }
        navigationController!.popViewControllerAnimated(true)
    }

}
