import Foundation
import PDFKit

struct TextEditor {
    init(text: String) {}
}
struct HTMLParser {
    func parse(_ data: Data) -> String { String(data: data, encoding: .utf8) ?? "" }
}
struct HTMLEditor {
    init(html: String) {}
}

let textData = "HelloWorld".data(using: .utf8)!
let htmlData = "<!DOCTYPE html><html><head><title>Index</title></head><body><p>Hello World</p></body></html>".data(using: .utf8)!
let pdfData = PDFDocument(url: Bundle.main.url(forResource: "sample", withExtension: "pdf")!)!.dataRepresentation()!

//struct Document {
//    enum Format {
//        case text
//        case html
//        case pdf
//    }
//
//    var format: Format
//    var data: Data
//}
//
//struct UsingDocument {
//    private func openTextEditor(for document: Document) {
//        let text = String(decoding: document.data, as: UTF8.self)
//        let editor = TextEditor(text: text)
//    }
//    private func openHTMLEditor(for document: Document) {
//        let parser = HTMLParser()
//        let html = parser.parse(document.data)
//        let editor = HTMLEditor(html: html)
//    }
//    func openPreview(for document: Document) {
//        let pdfView = PDFView()
//        pdfView.document = PDFDocument(data: document.data)
//    }
//    func openEditor(for document: Document) {
//        switch document.format {
//        case .text:
//            openTextEditor(for: document)
//        case .html:
//            openHTMLEditor(for: document)
//        case .pdf:
//            assertionFailure("Cannot edit PDF documents")
//        }
//    }
//}
//
//let textDoc = Document(format: .text, data: textData)
//let htmlDoc = Document(format: .html, data: htmlData)
//let pdfDoc = Document(format: .pdf, data: pdfData)
//UsingDocument().openEditor(for: textDoc)
//UsingDocument().openEditor(for: htmlDoc)
//UsingDocument().openPreview(for: pdfDoc)


//protocol Document {
//    var data: Data { get }
//}
//struct TextDocument: Document {
//    var data: Data
//    func openTextEditor(for document: TextDocument) {
//        let text = String(decoding: document.data, as: UTF8.self)
//        let editor = TextEditor(text: text)
//    }
//}
//struct HTMLDocument: Document {
//    var data: Data
//    func openTextEditor(for document: HTMLDocument) {
//        let text = String(decoding: document.data, as: UTF8.self)
//        let editor = TextEditor(text: text)
//    }
//}




enum DocumentFormat {
    enum Text{}
    enum HTML{}
    enum PDF{}
}
struct Document<Format> {
    var data: Data
}

//struct UsingDocument<DocumentType> where DocumentType: Document {
//    func open(for document: Document<DocumentFormat.Text>) {
//        let text = String(decoding: document.data, as: UTF8.self)
//        let editor = TextEditor(text: text)
//    }
//    func open(for document: Document<DocumentFormat.HTML>) {
//        let parser = HTMLParser()
//        let html = parser.parse(document.data)
//        let editor = HTMLEditor(html: html)
//    }
//    func open(for document: Document<DocumentFormat.PDF>) {
//        let pdfView = PDFView()
//        pdfView.document = PDFDocument(data: document.data)
//    }
//    func save<T>(_ document: Document<T>) {
//        
//    }
//}

extension Document where Format == DocumentFormat.Text {
    func open() {
        let text = String(decoding: self.data, as: UTF8.self)
        let editor = TextEditor(text: text)
    }
}
extension Document where Format == DocumentFormat.HTML {
    func open() {
        let parser = HTMLParser()
        let html = parser.parse(self.data)
        let editor = HTMLEditor(html: html)
    }
}
extension Document where Format == DocumentFormat.PDF {
    func open() {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(data: self.data)
    }
}
extension Document {
    func save(_ document: Document) {
        
    }
}

let textDoc = Document<DocumentFormat.Text>(data: textData)
let htmlDoc = Document<DocumentFormat.HTML>(data: htmlData)
let pdfDoc = Document<DocumentFormat.Text>(data: pdfData)
UsingDocument().open(for: textDoc)
//textDoc.open()
//htmlDoc.open()
//pdfDoc.open()




let m = Measurement<UnitTemperature>(value: 5, unit: .celsius)
