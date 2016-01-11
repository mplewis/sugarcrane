import UIKit
import SwiftHEXColors
import Bean_iOS_OSX_SDK

class ViewController: UIViewController, PTDBeanManagerDelegate, PTDBeanDelegate {

    @IBOutlet weak var wheel: UIButton!
    @IBOutlet weak var beer: UIButton!
    
    let red = UIColor(hexString: "e74c3c")
    let orange = UIColor(hexString: "f39c12")
    let green = UIColor(hexString: "2ecc71")
    
    var beanManager: PTDBeanManager?
    var wheelBean: PTDBean?
    var beerBean: PTDBean?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        beanManager = appDelegate.beanManager!
        beer.tintColor = red
        wheel.tintColor = red
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! SelectBeanTableViewController
        dest.sender = self
        dest.senderSegue = segue.identifier
    }
    
    func connectToBean(bean: PTDBean) {
        bean.delegate = self
        beanManager!.delegate = self
        var error: NSError?
        beanManager!.connectToBean(bean, error: &error)
        if let e = error {
            print(e)
        }
    }
    
    func connectToWheelBean(bean: PTDBean) {
        wheelBean = bean
        wheel.tintColor = orange
        connectToBean(wheelBean!)
    }
    
    func connectToBeerBean(bean: PTDBean) {
        beerBean = bean
        beer.tintColor = orange
        connectToBean(beerBean!)
    }
    
    func wheelBeanSelected(bean: PTDBean) {
        connectToWheelBean(bean)
    }
    
    func beerBeanSelected(bean: PTDBean) {
        connectToBeerBean(bean)
    }
    
    func beanManager(beanManager: PTDBeanManager!, didConnectBean bean: PTDBean!, error: NSError!) {
        if bean.identifier == wheelBean?.identifier {
            wheel.tintColor = green
        } else if bean.identifier == beerBean?.identifier {
            beer.tintColor = green
        }
    }
    
    func beanManager(beanManager: PTDBeanManager!, didDisconnectBean bean: PTDBean!, error: NSError!) {
        if bean.identifier == wheelBean?.identifier {
            connectToWheelBean(bean)
        } else if bean.identifier == beerBean?.identifier {
            connectToBeerBean(bean)
        }
    }

}
