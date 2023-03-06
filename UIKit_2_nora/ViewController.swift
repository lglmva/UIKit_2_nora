

import UIKit




class ViewController: UIViewController {
    
    private var buttonColors: [UIColor] = [.systemPink, .systemCyan, .systemMint]
    
    @IBOutlet var buttonFirst: UIButton!
    @IBOutlet var buttonSecond: UIButton!
    @IBOutlet var buttonThird: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleModalDismissed), name: NSNotification.Name("modalDismissed"), object: nil)
            
        
        
        configureButton(button: buttonFirst, title: "First Button", color: .systemPink)
        configureButton(button: buttonSecond, title: "Second Middle Button", color: .systemCyan)
        configureButton(button: buttonThird, title: "Third", color: .systemMint)
        
        
        NSLayoutConstraint.activate([
            buttonFirst.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonFirst.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            buttonSecond.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonSecond.topAnchor.constraint(equalTo: buttonFirst.bottomAnchor, constant: 10),
            buttonThird.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonThird.topAnchor.constraint(equalTo: buttonSecond.bottomAnchor, constant: 10)
        ])
        
    }
    
    func configureButton(button: UIButton, title: String, color: UIColor) {
        button.setImage(UIImage(systemName: "arrow.forward.circle.fill"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.configuration?.title = title
        button.layer.cornerRadius = 15
        button.backgroundColor = color
        button.tintColor = .white
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14)
        button.configuration?.imagePadding = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.layoutIfNeeded()
    }
    
    
    @objc func handleModalDismissed() {
        
        print("Modal dismissed")
        resetButtonColors()
        }

    
    
    
    private func animateButton(_ button: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
            button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                button.transform = CGAffineTransform.identity
            }
        })
    }
    
    func showModal() {
        let modalVC = ModalViewController()
        present(modalVC, animated: true, completion: nil)
    }
    
    
    func resetButtonColors() {
        buttonFirst.backgroundColor = buttonColors[0]
        buttonSecond.backgroundColor = buttonColors[1]
        buttonThird.backgroundColor = buttonColors[2]
    }
    
    @IBAction func actionButtonFirst(_ sender: UIButton) {
        animateButton(sender)
    }
    
    @IBAction func actionButtonSecond(_ sender: UIButton) {
        animateButton(sender)
    }
    
    @IBAction func actionButtonThird(_ sender: UIButton) {
        animateButton(sender)
        buttonFirst.backgroundColor = .systemGray
        buttonSecond.backgroundColor = .systemGray
        buttonThird.backgroundColor = .systemGray
        showModal()
    }
    
    
}


