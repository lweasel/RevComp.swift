import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    // the status bar item
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)
    
    // popover window to be shown when status bar item is clicked
    let popover = NSPopover()
    
    // controller class for the view shown inside the popover window
    var rcViewController: RevCompViewController?
    
    // monitors for clicks outside the popover window (which should dismiss it)
    var eventMonitor: EventMonitor?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        setupMenuIcon()
        setupViewController()
        setupEventMonitor()
    }
    
    func setupMenuIcon() {
        // set image and action to be performed for status bar icon
        if let button = statusItem.button {
            button.image = NSImage(named: "ACGTImage")
            button.action = Selector("togglePopover:")
        }
    }
    
    func setupViewController() {
        rcViewController = RevCompViewController(nibName: "RevCompViewController", bundle: nil)
        popover.contentViewController = rcViewController
    }
    
    func setupEventMonitor() {
        eventMonitor = EventMonitor(mask: [.LeftMouseDownMask, .RightMouseDownMask]) { [unowned self] event in
            if self.popover.shown {
                self.closePopover(event)
            }
        }
    }
    
    func togglePopover(sender: AnyObject?) {
        // when the menu icon is clicked, show or hide the popover 
        // depending on its current state
        if popover.shown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    
    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
        
        // stop monitoring for clicks outside the popover window
        eventMonitor?.stop()
    }
    
    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
        }
        
        // tell the view controller that the popover has been shown
        rcViewController?.hasBeenShown()
        
        // start monitoring for clicks outside the popover window
        eventMonitor?.start()
    }
}

