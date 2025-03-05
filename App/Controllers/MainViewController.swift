import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Crea l'immagine di sfondo
        let sfondoImageView = UIImageView(image: UIImage(named: "sfondo2"))
        sfondoImageView.frame = view.bounds
        sfondoImageView.contentMode = .scaleAspectFill
        view.addSubview(sfondoImageView)
        view.sendSubviewToBack(sfondoImageView)

        // Crea il pulsante "signHere"
        let signHereButton = UIButton(type: .custom)
        signHereButton.setImage(UIImage(named: "signHere"), for: .normal)
        signHereButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100) // Imposta le dimensioni dell'icona
        signHereButton.addTarget(self, action: #selector(mostraLogin), for: .touchUpInside)
        view.addSubview(signHereButton)

        // Configura il layout del pulsante "signHere" al centro in basso
        signHereButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signHereButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signHereButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80), // Spazio dal bordo inferiore
            signHereButton.widthAnchor.constraint(equalToConstant: 100),
            signHereButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    @objc func mostraLogin() {
        // Azione da eseguire quando il pulsante viene cliccato
        // Presenta la LoginViewController modalmente
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen // Puoi scegliere un altro stile di presentazione
        present(loginViewController, animated: true, completion: nil)
    }
}
