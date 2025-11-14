//
//  main.swift
//  helloWorldApp
//
//  Created by IGOR TEIXEIRA CARRASCO on 10/11/25.
//

import Foundation

enum gameError: Error {
    case nv
}

func checkScore(_ score: Int) throws -> String {
    if score < 5 {
        throw gameError.nv
    }
    return "All good"
}

func apresentacao() -> String {
    print("-------------------")
    print("|    Mon Ke Po    |")
    print("-------------------")
    print("\nBem vindo ao mundo de Mon Ke Po!")
    print("Primeiro, me diga qual é o seu nome?\n")
    
    let input = readLine() ?? "Aventureiro sem nome"
    
    if input == "" {
        print("Por favor, me diga um nome. Diga alguma coisa! Vamos tentar de novo\n")
        return apresentacao()
    }
    
    print("\nMuito prazer, \(input)!\nNosso reino esta cercado por criaturas do mal e tem um dragao magico responsavel por tudo isso. Acreditamos que voce tem tudo o que precisa para derrotar o grande Dragao Laranja. Contamos com voce, por favor, nos ajude!\n")
    print("Cada batalha voce enfrentara um inimigo aleatorio. Ao ganhar de um inimigo voce recebe 2 de Score e ao perder, perde 1. Junte 5 pontos e salve o reino de Mon Ke Po!")
    return input
}

func getEscolha(_ score: Int) -> String {
    print("\nScore: \(score)")
    print("O que voce quer fazer? (Digite apenas o numero)")
    print("[ 1 ] - Batalha")
    print("[ 2 ] - Desafiar o chefao")
    print("[ 3 ] - Sair do jogo")
    
    let input = readLine()
    switch input {
    case "1":
        return "batalha"
    case "2":
        return "chefao"
    case "3":
        return "sair"
    default:
        print("Digite um numero valido, de 1 a 3.")
        return getEscolha(score)
    }
}

func addScore(_ score: inout Int) -> Int {
    return score + 2
}

func subScore(_ score: inout Int) -> Int {
    return score - 1
}

func getEscolhaInimigo() -> String {
    var escolhaCom = ""
    let random = Int.random(in: 1...3)
    switch random {
    case 1:
        escolhaCom = "Bola de Fogo"
    case 2:
        escolhaCom = "Jato de Agua"
    case 3:
        escolhaCom = "Folhas Navalhas"
    default:
        print("Inimigo nao escolheu")
    }
    return escolhaCom
}

func getEscolhaPlayer() -> String {
    print("Escolha seu golpe:")
    print("[ 1 ] - Bola de Fogo")
    print("[ 2 ] - Jato de Agua")
    print("[ 3 ] - Folhas Navalhas\n")
    
    var escolhaPlayer = ""
    let inputPlayer = readLine() ?? " "
    switch inputPlayer {
    case "1":
        escolhaPlayer = "Bola de Fogo"
    case "2":
        escolhaPlayer = "Jato de Agua"
    case "3":
        escolhaPlayer = "Folhas Navalhas"
    default:
        print("Escolha um valor entre 1 e 3\n")
        return getEscolhaPlayer()
    }
    
    return escolhaPlayer
}

func batalha(_ score: inout Int, _ hpPlayer: inout Int, _ hpInimigo: inout Int) {
    let escolhaCom = getEscolhaInimigo()
        
    print("Vida Player: \(hpPlayer) / Vida Inimigo: \(hpInimigo)")
    let escolhaPlayer = getEscolhaPlayer()
        
    if (escolhaPlayer == "Bola de Fogo" && escolhaCom == "Folhas Navalhas") || (escolhaPlayer == "Jato de Agua" && escolhaCom == "Bola de Fogo") || (escolhaPlayer == "Folhas Navalhas" && escolhaCom == "Jato de Agua") {
        hpInimigo -= 10
        print("\nVoce venceu essa rodada! Seu oponente escolheu: \(escolhaCom) e perdeu 10 pontos de vida.")
    } else if escolhaPlayer == escolhaCom {
        print("\nEmpate, vamos outra vez")
    } else {
        hpPlayer -= 10
        print("\nVoce perdeu essa rodada! Seu oponente escolheu: \(escolhaCom). Voce perdeu 10 pontos de vida.")
    }
    
    if hpPlayer > 0 && hpInimigo > 0{
        batalha(&score, &hpPlayer, &hpInimigo)
    } else {
        print("\nA batalha terminou")
        if hpPlayer == 0 {
            print("\nVoce perdeu a batalha!")
            score = subScore(&score)
        } else if hpInimigo == 0 {
            print("\nVoce ganhou a batalha!")
            score = addScore(&score)
        }
    }
}

func batalhaBoss(_ score: inout Int, _ hpPlayer: inout Int, _ hpInimigo: inout Int) -> String {
    let escolhaCom = getEscolhaInimigo()
        
    print("Vida Player: \(hpPlayer) / Vida Inimigo: \(hpInimigo)")
    let escolhaPlayer = getEscolhaPlayer()
        
    if (escolhaPlayer == "Bola de Fogo" && escolhaCom == "Folhas Navalhas") || (escolhaPlayer == "Jato de Agua" && escolhaCom == "Bola de Fogo") || (escolhaPlayer == "Folhas Navalhas" && escolhaCom == "Jato de Agua") {
        hpInimigo -= 10
        print("\nVoce venceu essa rodada! Seu oponente escolheu: \(escolhaCom) e perdeu 10 pontos de vida.")
    } else if escolhaPlayer == escolhaCom {
        print("\nEmpate, vamos outra vez")
    } else {
        hpPlayer -= 10
        print("\nVoce perdeu essa rodada! Seu oponente escolheu: \(escolhaCom). Voce perdeu 10 pontos de vida.")
    }
    
    var vitoria = ""
    
    if hpPlayer > 0 && hpInimigo > 0{
        return batalhaBoss(&score, &hpPlayer, &hpInimigo)
    } else {
        print("\nBatalha terminou")
        if hpPlayer == 0 {
            print("\nVoce perdeu a batalha!")
            vitoria = "derrota"
        } else if hpInimigo == 0 {
            print("\nVoce ganhou a batalha!")
            vitoria = "vitoria"
        }
    }
    return vitoria
}

func getMapa(_ inimigos: Dictionary<String, String>) {
    let random = Int.random(in: 1...5)
    var mapa = ""
    switch random {
    case 1:
        mapa = "praia"
    case 2:
        mapa = "floresta"
    case 3:
        mapa = "planicie"
    case 4:
        mapa = "montanha"
    case 5:
        mapa = "caverna"
    default:
        mapa = " "
    }
    
    print("\nVoce chegou na \(mapa) e encontrou \(inimigos["\(mapa)"] ?? " "). LUTEM!")
}

func jogo() {
    let nomePlayer = apresentacao()
    var score = 1
    var hpPlayer = 30
    var hpInimigo = 30
    
    let inimigos = [
        "praia": "um Mago Azul",
        "floresta": "uma Maga Verde",
        "planicie": "um Mago Branco",
        "montanha": "um Mago Vermelho",
        "caverna": "um Mago da Escuridao",
    ]
    
    var end = false
    while !end {
        let escolha = getEscolha(score)
        switch escolha {
        case "batalha":
            hpPlayer = 30
            hpInimigo = 30
            getMapa(inimigos)
            batalha(&score, &hpPlayer, &hpInimigo)
        case "chefao":
            do {
                let _ = try checkScore(score)
                print("\nVoce tem pontos o suficiente para enfrentar o Dragao Laranja! Pode entrar na caverna!\n\n")
                print("Voce encontrou o temivel Dragao Laranja! Derrote-o para ser o heroi do reino de Mon Ke Po!\n")
                hpPlayer = 50
                hpInimigo = 50
                let result = batalhaBoss(&score, &hpPlayer, &hpInimigo)
                if result == "vitoria" {
                    print("\nParabens, \(nomePlayer)! Voce conseguiu derrotar o Dragao Laranja e salvou o reino de Mon ke Po das forcas do mal! Seremos eternamente gratos e musicas sobre seus feitos serao cantadas por geracoes! Mais uma vez obrigado, Heroi \(nomePlayer)!\n")
                    end = true
                } else {
                    score -= 2
                }
            } catch gameError.nv {
                print("\nVoce ainda nao tem pontos o suficiente. Precisa de 5 e voce tem \(score)")
            } catch {
                print("Erro desconhecido")
            }
        case "sair":
            print("\nVoce saiu do jogo")
            end = true
        default:
            print("\nGame Over")
            end = true
        }
        
        if score < 1 {
            print("\nGame Over")
            end = true
        }
    }
}

jogo()
