import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var wheel: UIButton!
    @IBOutlet weak var beer: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! SelectBeanTableViewController
        dest.sender = self
        dest.senderSegue = segue.identifier
    }
    
    func wheelBeanSelected() {
        print("Wheel bean selected")
    }
    
    func beerBeanSelected() {
        print("Beer bean selected")
    }

}
