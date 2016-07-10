import UIKit

class ViewController: UIViewController {

    @IBOutlet var logTextView: UITextView!
    
    var a:A?
    var b:B?
    weak var holdOnToB: B?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didTapRefresh(self)
    }

    @IBAction func didTapRefresh(sender: AnyObject) {
        logTextView.text = RetainCycleLogger.sharedInstance.allCounts()
    }
    
    @IBAction func didTapBasicRetain(sender: AnyObject) {
        let a = A()
        let b = B()
        a.b = b
        b.a = a
        didTapRefresh(self)
    }
    
    @IBAction func BDoesNotReferenceADidTap(sender: AnyObject) {
        let a = A()
        let b = B()
        a.b = b
        didTapRefresh(self)
    }
    
    @IBAction func selfaADidTap(sender: AnyObject) {
        self.a = A()
        logTextView.text = RetainCycleLogger.sharedInstance.allCounts()

    }
    
    @IBAction func selfbBDidTap(sender: AnyObject) {
        self.b = B()
        self.holdOnToB = self.b
        logTextView.text = RetainCycleLogger.sharedInstance.allCounts()
    }
    
    @IBAction func selfaNilDidTap(sender: AnyObject) {
        self.a = nil
        logTextView.text = RetainCycleLogger.sharedInstance.allCounts()
    }
    
    @IBAction func selfbNilDidTap(sender: AnyObject) {
        self.b = nil
        logTextView.text = RetainCycleLogger.sharedInstance.allCounts()
    }
    
    @IBAction func selfabEqualSelfbDidTap(sender: AnyObject) {
        self.a?.b = self.b
        logTextView.text = RetainCycleLogger.sharedInstance.allCounts()
    }
    
    @IBAction func selfbaEqualSelfaDidTap(sender: AnyObject) {
        self.b?.a = self.a
        logTextView.text = RetainCycleLogger.sharedInstance.allCounts()
    }
    
    @IBAction func selfHoldOnToBAEqualToNilDidTap(sender: AnyObject) {
        if let weakB = self.holdOnToB {
            weakB.a = nil
        }
        logTextView.text = RetainCycleLogger.sharedInstance.allCounts()
    }
}


class LoggedClass {
    init() {
        RetainCycleLogger.sharedInstance.addObject(self)
    }
}


class A: LoggedClass {
    var b:B?
}

class B: LoggedClass {
    var a:A?
}
