//
//  Markdown.swift
//  ITLab
//
//  Created by Mikhail Ivanov on 25.05.2021.
//

import SwiftUI
import UIKit
import Down

class MarkdownObservable: ObservableObject {
    let textView = UITextView()
    private let text: String
    
    @Published var isLoading: Bool = true
    
    init(text: String) {
        
        self.text = text
        
        loadingDown()
    }
    
    private func loadingDown() {
        let down = Down(markdownString: text)
        self.isLoading = true
        DispatchQueue(label: "markdownParse").async {
            let attributedText = try? down.toAttributedString(styler: ITLabStyler(
                                                                configuration: .init(
                                                                    fonts: ITLabFontCollection())))
            
            DispatchQueue.main.async {
                self.textView.attributedText = attributedText
                
                self.isLoading = false
            }
        }
    }
}

struct MarkdownRepresentable: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme
    @Binding var dynamicHeight: CGFloat
    @EnvironmentObject var markdownObject: MarkdownObservable
    
    init(height: Binding<CGFloat>) {
        self._dynamicHeight = height
    }
    
    func makeUIView(context: Context) -> UITextView {
        
        markdownObject.textView.textAlignment = .left
        markdownObject.textView.isScrollEnabled = false
        markdownObject.textView.isUserInteractionEnabled = true
        markdownObject.textView.showsVerticalScrollIndicator = false
        markdownObject.textView.showsHorizontalScrollIndicator = false
        markdownObject.textView.isEditable = false
        markdownObject.textView.backgroundColor = .clear
        markdownObject.textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        markdownObject.textView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        return markdownObject.textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        DispatchQueue.main.async {
            uiView.textColor = colorScheme == .dark ? UIColor.white : UIColor.black
            dynamicHeight = uiView.sizeThatFits(CGSize(width: uiView.bounds.width,
                                                       height: CGFloat.greatestFiniteMagnitude))
                .height
        }
    }
}

struct Markdown: View {
    @ObservedObject private var markdownObject: MarkdownObservable
    private var text: String
    @State private var isLoading: Bool = false
    @State private var height: CGFloat = .zero
    
    init(text: String) {
        self.text = text
        self.markdownObject = MarkdownObservable(text: text)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if isLoading {
                GeometryReader { geometry in
                    ProgressView()
                        .frame(width: geometry.size.width,
                               height: geometry.size.height,
                               alignment: .center)
                }
            } else {
                ScrollView {
                    MarkdownRepresentable(height: $height)
                        .frame(height: height)
                        .environmentObject(markdownObject)
                }
            }
        }.onReceive(markdownObject.$isLoading, perform: { bool in
            isLoading = bool
        })
    }
}

// TODO: Waiting for my PR to be accepted into the Down library repository
final class ITLabStyler: DownStyler {
    override func style(image str: NSMutableAttributedString, title: String?, url: String?) {
        if let urlImg = URL(string: url!) {
            let semaphore = DispatchSemaphore(value: 0)
            URLSession.shared.dataTask(with: urlImg) { data, _, _ in
                if let data = data,
                   let img = UIImage(data: data) {
                    let image1Attachment = NSTextAttachment()
                    
                    image1Attachment.image = self.resizeImg(img: img)
                    
                    let image1String = NSAttributedString(attachment: image1Attachment)
                    
                    str.setAttributedString(image1String)
                }
                
                semaphore.signal()
            }.resume()
            
            semaphore.wait()
        }
    }
    
    func resizeImg(img: UIImage) -> UIImage {
        
        if UIScreen.main.bounds.width < img.size.width {
            
            let newImg = img.scalePreservingAspectRatio(width: UIScreen.main.bounds.width - 10)
            
            return newImg
        }
        
        return img
    }
}

extension UIImage {
    
    func scalePreservingAspectRatio(width: CGFloat) -> UIImage {
        let widthRatio = size.width / width
        let heightRatio = size.height / widthRatio
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: width,
            height: heightRatio
        )
        
        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )
        
        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
    
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )
        
        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )
        
        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
}

struct ITLabFontCollection: FontCollection {
    
    public var heading1: DownFont
    public var heading2: DownFont
    public var heading3: DownFont
    public var heading4: DownFont
    public var heading5: DownFont
    public var heading6: DownFont
    public var body: DownFont
    public var code: DownFont
    public var listItemPrefix: DownFont
    
    public init(
        heading1: DownFont = .boldSystemFont(ofSize: 24),
        heading2: DownFont = .boldSystemFont(ofSize: 20),
        heading3: DownFont = .boldSystemFont(ofSize: 18),
        heading4: DownFont = .boldSystemFont(ofSize: 16),
        heading5: DownFont = .boldSystemFont(ofSize: 14),
        heading6: DownFont = .boldSystemFont(ofSize: 12),
        body: DownFont = .systemFont(ofSize: 12),
        code: DownFont = DownFont(name: "menlo", size: 12) ?? .systemFont(ofSize: 12),
        listItemPrefix: DownFont = DownFont.monospacedDigitSystemFont(ofSize: 12, weight: .regular)
    ) {
        self.heading1 = heading1
        self.heading2 = heading2
        self.heading3 = heading3
        self.heading4 = heading4
        self.heading5 = heading5
        self.heading6 = heading6
        self.body = body
        self.code = code
        self.listItemPrefix = listItemPrefix
    }
}
