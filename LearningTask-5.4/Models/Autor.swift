//
//  Autor.swift
//  LearningTask-5.4
//
//  Created by Italo cavalcanti on 27/10/22.
//

import Foundation

struct Autor {
    private(set) var fotoURL: String
    private(set) var nome: String
    private(set) var sobrenome: String
    private(set) var bio: String
    private(set) var tecnologias: String
    private(set) var nomeCompleto: String
    
    init(fotoURL: String, nome: String, sobrenome: String, bio: String, tecnologias: String, nomeCompleto: String) {
        self.fotoURL = fotoURL
        self.nome = nome
        self.sobrenome = sobrenome
        self.bio = bio
        self.tecnologias = tecnologias
        self.nomeCompleto = nomeCompleto
    }

}
