import UIKit

class AdminViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Aggiungi componenti alla vista
        let button = UIButton(type: .system)
        button.setTitle("Pulsante", for: .normal)
        button.addTarget(self, action: #selector(premiPulsante), for: .touchUpInside)
        view.addSubview(button)
        
        // Configura la posizione e le dimensioni del pulsante
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func premiPulsante() {
        // Codice da eseguire quando il pulsante viene premuto
        print("Pulsante premuto")
    }
}
