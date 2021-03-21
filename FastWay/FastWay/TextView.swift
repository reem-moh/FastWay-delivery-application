//
//  TextView.swift
//  FastWay
//
//  Created by Shahad AlOtaibi on 13/07/1442 AH.
//
import SwiftUI

struct TextView: UIViewRepresentable {
    
    /* func makeCoordinator() -> TextView.Coordinator {
     return TextView.coordinator(parent1 : self)
     }*/
    
    //  @EnvironmentObject var obj : observe
    @Binding var txt: String
    // @Binding var textStyle: UIFont.TextStyle
    func makeCoordinator() -> TextView.coordinator {
        return TextView.coordinator(parent1: self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        
        let textView = UITextView()//
        
        //   textView.font = UIFont.preferredFont(forTextStyle: textStyle)
        //  textView.autocapitalizationType = .sentences
        // textView.isSelectable = true
        textView.isUserInteractionEnabled = true//
        textView.isEditable = true//
        //  textView.text = "order here"//
        // textView.textColor = .gray//
        // textView.textColor = UIColor.black.withAlphaComponent(2)//
          // textView.textContainer.maximumNumberOfLines = 5
        //   textView.textContainer.lineBreakMode = .byTruncatingTail
        //textView.isEditable = false
        // font(.system(size: 18))
        //  .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1))
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: fontSize(num: 18))//
        textView.delegate = context.coordinator
        // textFieldStyle(background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)))
        
        // textView.max
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        // uiView.text = ""
        uiView.textColor = .black
        /* if(uiView.text.count > 2){
         uiView.isEditable = false
         }*/
        
        // uiView.text = text
        //  uiView.font = UIFont.preferredFont(forTextStyle: textStyle)
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
        
        /*  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
         let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
         let numberOfChars = newText.count
         return numberOfChars < 10    // 10 Limit Value
         }*/
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return textView.text.count + (text.count - range.length) <= 80
        }
        
    }
    
}
