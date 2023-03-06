
import UIKit

class ModalViewController: UIViewController {
    
    private var panGestureRecognizer: UIPanGestureRecognizer?
    private let swipeThreshold: CGFloat = 0.5 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
        self.panGestureRecognizer = panGestureRecognizer
        
        let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeDownGestureRecognizer.direction = .down
        view.addGestureRecognizer(swipeDownGestureRecognizer)
    }
    
    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: view)
        let progress = abs(translation.y / view.bounds.height)
        
        switch gestureRecognizer.state {
        case .changed:
            view.transform = CGAffineTransform(translationX: 0, y: translation.y)
        case .ended:
            if progress >= swipeThreshold {
                dismiss(animated: true) {
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: NSNotification.Name("modalDismissed"), object: nil)
                    }
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.transform = .identity
                }
            }
        default:
            break
        }
    }
    
    @objc func handleSwipeGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        
        if gestureRecognizer.state == .ended {
            dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name("modalDismissed"), object: nil)
        }
    }
    
}

