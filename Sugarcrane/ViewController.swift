import UIKit
import SwiftHEXColors
import Bean_iOS_OSX_SDK

class ViewController: UIViewController, PTDBeanManagerDelegate, PTDBeanDelegate {

    @IBOutlet weak var quadcopter: UIButton!
    
    let red = UIColor(hexString: "e74c3c")
    let orange = UIColor(hexString: "f39c12")
    let green = UIColor(hexString: "2ecc71")
    
    var beanManager: PTDBeanManager?
    var quadcopterBean: PTDBean?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        beanManager = appDelegate.beanManager!
        quadcopter.tintColor = red
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! SelectBeanTableViewController
        dest.sender = self
        dest.senderSegue = segue.identifier
    }
    
    @IBAction func closePressed(sender: AnyObject) {
        if let qb = quadcopterBean {
            qb.sendSerialString("0");
            qb.sendSerialString("\n");
            qb.sendSerialString("\n");
            qb.sendSerialString("\n");
        }
    }
    
    @IBAction func openPressed(sender: AnyObject) {
        if let qb = quadcopterBean {
            qb.sendSerialString("1");
            qb.sendSerialString("\n");
            qb.sendSerialString("\n");
            qb.sendSerialString("\n");
        }
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
    
    func connectToQuadcopterBean(bean: PTDBean) {
        disconnectFromBean(quadcopterBean)
        quadcopterBean = bean
        quadcopter.tintColor = orange
        connectToBean(quadcopterBean!)
    }
    
    func quadcopterBeanSelected(bean: PTDBean) {
        connectToQuadcopterBean(bean)
    }
    
    func beanManager(beanManager: PTDBeanManager!, didConnectBean bean: PTDBean!, error: NSError!) {
        bean.delegate = self
        quadcopter.tintColor = green
    }
    
    func beanManager(beanManager: PTDBeanManager!, didDisconnectBean bean: PTDBean!, error: NSError!) {
        connectToQuadcopterBean(bean)
    }

}
