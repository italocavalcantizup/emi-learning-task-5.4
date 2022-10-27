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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func botaoSalvarPressionado(_ sender: UIButton) {
        
        switch formularioValido() {
        case (false, let mensagem):
            exibirAlerta(title: "Erro", message: mensagem)
        default:
            cadastraAutor()
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
        
        guard let nomeAutor = nomeTextField.text, !nomeAutor.isEmpty else {
            return (false, "Informe o nome do autor.")
        }
        
        guard let bio = bioTextField.text, !bio.isEmpty else {
            return (false, "A bio do autor não pode estar em branco.")
        }
        
        guard let tecnologias = tecnologiasTextField.text, !tecnologias.isEmpty else {
            return (false, "Informe as tecnologias sobre as quais o autor escreve.")
        }
        
        return (true, nil)
    }
    
    func cadastraAutor() {
        let (nome, sobrenome) = formata(nomeDeAutor: nomeTextField.text!)
        let autor = Autor(
            fotoURL: fotoTextField.text!,
            nome: nome,
            sobrenome: sobrenome,
            bio: bioTextField.text!,
            tecnologias: tecnologiasTextField.text!
        )
        
        AutorRepository.salva(autor)
        exibirAlerta(title: "Feito", message: "Autor cadastrado com sucesso.")
        resetaCampos()
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
