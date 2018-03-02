//: Playground - noun: a place where people can play

import UIKit
//enum Block {
//    case heading(String)
//    case paragraph(String)
//}
//
//extension Block {
//    func renderHTML() -> String {
//        switch self {
//        case let .heading(text): return "<h1>\(text)</h1>"
//        case let .paragraph(text): return "<p>\(text)</p>"
//        }
//    }
//}

protocol Block {
    static func heading(_ text: String) -> Self
    static func paragraph(_ text: String) -> Self
}

struct HTMLRenderer {
    let rendered: String
}

extension HTMLRenderer: Block {
    static func heading(_ text: String) -> HTMLRenderer {
        return HTMLRenderer(rendered: "<h1>\(text)</h1>")
    }

    static func paragraph(_ text: String) -> HTMLRenderer {
        return HTMLRenderer(rendered: "<p>\(text)</p>")
    }
}

func createDocument<B: Block>() -> [B] {
    return [B.heading("Hello World!"), B.paragraph("My First Document.")]
}

func renderHTML(_ renderers: [HTMLRenderer]) -> String {
    return renderers.map { $0.rendered }.joined(separator: "\n")
}

print(renderHTML(createDocument()))

// Latex
struct LatexRenderer {
    let rendered: String
}

extension LatexRenderer: Block {
    static func heading(_ text: String) -> LatexRenderer {
        return LatexRenderer(rendered: "\\section{\(text)}")
    }

    static func paragraph(_ text: String) -> LatexRenderer {
        return LatexRenderer(rendered: text )
    }
}

protocol LatexBlock {
    static func pageBreak() -> Self
}

extension LatexRenderer: LatexBlock {
    static func pageBreak() -> LatexRenderer {
        return LatexRenderer(rendered: "\\pagebreak")
    }
}

func createLatexDocument<B: Block & LatexBlock>() -> [B] {
    return [B.heading("Hello World!"), B.paragraph("My first document."), B.pageBreak(), B.paragraph("Second page.")]
}

func renderLatex(_ renderers: [LatexRenderer]) -> String {
    return renderers.map { $0.rendered }.joined(separator: "\n\n")
}

print(renderLatex(createLatexDocument()))












