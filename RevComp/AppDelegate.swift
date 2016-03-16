import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    var eventMonitor: EventMonitor?
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)
    
    let popover = NSPopover()
    var rcViewController: RevCompViewController?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        if let button = statusItem.button {
            button.image = NSImage(named: "ACGTImage")
            button.action = Selector("togglePopover:")
        }
        
        rcViewController = RevCompViewController(nibName: "RevCompViewController", bundle: nil)
        popover.contentViewController = rcViewController
        
        eventMonitor = EventMonitor(mask: [.LeftMouseDownMask, .RightMouseDownMask]) { [unowned self] event in
            if self.popover.shown {
                self.closePopover(event)
            }
        }
        
        eventMonitor?.start()
    }

    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
        }
        
        rcViewController!.hasBeenShown()
        
        eventMonitor?.start()
    }
    
    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
    
    func togglePopover(sender: AnyObject?) {
        if popover.shown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
}

