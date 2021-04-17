//
//  TextView.swift
//  FastWay
//
//  Created by Shahad AlOtaibi on 13/07/1442 AH.
//
import SwiftUI

struct TextView: UIViewRepresentable {
    
    @Binding var txt: String
    func makeCoordinator() -> TextView.coordinator {
        return TextView.coordinator(parent1: self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        
        let textView = UITextView()
        
        textView.isUserInteractionEnabled = true
        textView.isEditable = true
        
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: fontSize(num: 18))//
        textView.delegate = context.coordinator
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.textColor = .black
        
    }
    
    class coordinator: NSObject,UITextViewDelegate{
        
        var parent : TextView
        
        init(parent1 : TextView) {
            parent = parent1
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
            textView.textColor = .black
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.txt = textView.text
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return textView.text.count + (text.count - range.length) <= 80
        }
        
    }
    
}
