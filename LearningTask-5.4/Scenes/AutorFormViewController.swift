//
//  ViewController.swift
//  LearningTask-5.4
//
//  Created by rafael.rollo on 09/03/2022.
//

import UIKit

class AutorFormViewController: UIViewController {

    typealias MensagemValidacao = String

    @IBOutlet weak var fotoTextField: UITextField!
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var tecnologiasTextField: UITextField!
    
    var autor: Autor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func botaoSalvarPressionado(_ sender: UIButton) {
        
        switch formularioValido() {
        case (false, let mensagem):
            exibirAlerta(title: "Erro", message: mensagem)
        default:
            if let autor {
                AutorRepository.salva(autor)
            }
            resetaCampos()
        }
        
    }
    
    func nomeDeAutorValido(_ nome: String) -> Bool {
        let pattern = #"^[a-zA-Z-]+ ?.* [a-zA-Z-]+$"#
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: nome)
    }
    
    func formata(nomeDeAutor: String) -> (String, String) {
        let separador = " "
        let nomeCompleto = nomeDeAutor.components(separatedBy: separador)
        return (nomeCompleto.first!, nomeCompleto.dropFirst().joined(separator: separador))
    }
    
    func formularioValido() -> (Bool, MensagemValidacao?) {
        guard let foto = fotoTextField.text, !foto.isEmpty else {
            return (false, "Informe a URL da foto do autor.")
        }
        
        guard let nomeAutor = nomeTextField.text, nomeDeAutorValido(nomeAutor) else {
            return (false, "Informe o nome do autor.")
        }
        let nomeFormatado = formata(nomeDeAutor: nomeAutor)
        
        guard let bio = bioTextField.text, !bio.isEmpty else {
            return (false, "A bio do autor não pode estar em branco.")
        }
        
        guard let tecnologias = tecnologiasTextField.text, !tecnologias.isEmpty else {
            return (false, "Informe as tecnologias sobre as quais o autor escreve.")
        }
        autor = Autor(
            fotoURL: foto,
            nome: nomeFormatado.0,
            sobrenome: nomeFormatado.1,
            bio: bio,
            tecnologias: tecnologias,
            nomeCompleto: nomeAutor
        )
        
        return (true, nil)
    }
    
    func exibirAlerta(title: String?, message: MensagemValidacao?) {
        let alerta = UIAlertController(
            title: title,
            message: message ?? "Verifique os campos e tente novamente.",
            preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alerta, animated: true)
    }
    
    func resetaCampos() {
        fotoTextField.text = ""
        nomeTextField.text = ""
        bioTextField.text = ""
        tecnologiasTextField.text = ""
    }

}
