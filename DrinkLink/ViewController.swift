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
    
    func disconnectFromBean(bean: PTDBean?) {
        if bean == nil {
            return
        }
        var error: NSError?
        beanManager?.disconnectBean(bean!, error: &error)
        if let e = error {
            print(e)
        }
    }
    
    func connectToWheelBean(bean: PTDBean) {
        disconnectFromBean(wheelBean)
        wheelBean = bean
        wheel.tintColor = orange
        connectToBean(wheelBean!)
    }
    
    func connectToBeerBean(bean: PTDBean) {
        disconnectFromBean(beerBean)
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
        bean.delegate = self
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
    
    func bean(bean: PTDBean!, serialDataReceived raw: NSData!) {
        if bean.identifier != beerBean?.identifier {
            return
        }
        if let wb = wheelBean, rcvd = NSString(data: raw, encoding: NSUTF8StringEncoding) {
            if rcvd.containsString("1") {
                // drink was picked up
                // Send a few commands; sometimes Bean doesn't wake up on the first one
                wb.sendSerialString("1")
                wb.sendSerialString("\n")
                wb.sendSerialString("\n")
                wb.sendSerialString("\n")
            } else if rcvd.containsString("0") {
                // drink was set down
                wb.sendSerialString("0")
                wb.sendSerialString("\n")
                wb.sendSerialString("\n")
                wb.sendSerialString("\n")
            }
        }
    }

}
