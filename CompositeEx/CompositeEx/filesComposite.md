#  <#Title#>

import UIKit

protocol File {
    var name: String {get}
    var description: String {get}
    
    func open()
}

class PDFFile: File {
    let name: String
    let author: String
    
    var description: String {
        return "ebook \(name) by \(author)"
    }
    
    init(name: String, author: String) {
        self.name = name
        self.author = author
    }
    
    func open() {
        print("opening \(description)")
    }
}


class MP3File: File {
    let name: String
    let author: String
    
    var description: String {
        return "music \(name) by \(author)"
    }
    
    init(name: String, author: String) {
        self.name = name
        self.author = author
    }
    
    func open() {
        print("opening \(description)")
    }
}


class Folder: File {
    let name: String
    var files: [File] = []
    
    var description: String {
        let filenames = files.compactMap{$0.description}.joined(separator: ",")
        return "folder \(name) with files \(filenames)"
    }
    
    init(name: String) {
        self.name = name
    }
    
    func open() {
        print("opening \(description)")
        print("then opening files:")
        files.forEach { $0.open() }
    }
}

let book = PDFFile(name: "War", author: "Tolstoy")
let book2 = PDFFile(name: "Onegin", author: "Pushkin")
let music = MP3File(name: "Yesterday", author: "Beatles")
let music2 = MP3File(name: "Bohemian Rapsody", author: "Queen")

let folder1 = Folder(name: "folder1")
let folder2 = Folder(name: "folder2")

folder1.files = [book, folder2]
folder2.files = [book2,music,music2]

folder1.open()
