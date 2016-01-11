import UIKit
import SwiftHEXColors
import Bean_iOS_OSX_SDK

class ViewController: UIViewController {

    @IBOutlet weak var wheel: UIButton!
    @IBOutlet weak var beer: UIButton!
    
    let red = UIColor(hexString: "e74c3c")
    let orange = UIColor(hexString: "f39c12")
    let green = UIColor(hexString: "2ecc71")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beer.tintColor = red
        wheel.tintColor = red
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! SelectBeanTableViewController
        dest.sender = self
        dest.senderSegue = segue.identifier
    }
    
    func wheelBeanSelected(bean: PTDBean) {
        print("Wheel bean selected: \(bean.name)")
    }
    
    func beerBeanSelected(bean: PTDBean) {
        print("Beer bean selected: \(bean.name)")
    }

}
