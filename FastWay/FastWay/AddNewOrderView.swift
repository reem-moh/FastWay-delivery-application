//
//  AddNewOrderView.swift
//  FastWay
//
//  Created by Raghad AlOtaibi on 20/06/1442 AH.
//

import SwiftUI
import Firebase
import FirebaseFirestore
struct AddNewOrderView: View {

    @State var name = ""
    @State var location = ""
    
    
    
    @State var error = false
    @State var nErr = ""
    
    var body: some View {
        //pick up location
        ZStack{
        
        VStack{
            //background image
            Image("Rectangle 49").ignoresSafeArea()
            Spacer()
        }
        
        VStack{
            //white rectangle
            Spacer(minLength: 100)
            Image("Rectangle 48").resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
        }
        

     
       VStack{
        
        
        Text("DROP OFF LOCATION ").font(.custom("Roboto Medium", size: 25)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0).offset(x:0 ,y:-360)
        
       }
                
        
       
        

        VStack(alignment: .leading){
            
           
            
                 Image(uiImage: #imageLiteral(resourceName: "location"))
                     .resizable()
                     .aspectRatio(contentMode: .fill)
                     .frame(width: 25, height: 25)
                     .clipped()
                     .offset(x:20 ,y:490)
            
            Group{
                
                Image(uiImage: #imageLiteral(resourceName: "map"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 360, height: 292)
                    .clipped()
                    .position(x:188,y:280).offset(x:0 ,y:-10)
                
                
   
            
         
                
            //Show Error message if the email feild empty
                Text(nErr).font(.custom("Roboto Regular", size: 18))
                    .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 10,y: -170)
                
            TextField("", text: $location)
                .font(.system(size: 18))
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).keyboardType(.emailAddress).padding(.horizontal, 11.0).offset(x:0 ,y:-180)
            }
            
            
            Group{
                
            Text("Details location").font(.custom("Roboto Medium", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.37, blue: 0.37, alpha: 1)))
                .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0).offset(x:0 ,y:-165)
                
            
                    
                //Show Error message if the email feild empty
                    Text(nErr).font(.custom("Roboto Regular", size: 18))
                        .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 10,y: -170)
            
            TextField("bulding, floor, room numbers", text: $location)
                .font(.system(size: 18))
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).keyboardType(.emailAddress).padding(.horizontal, 11.0).offset(x:0 ,y:-180)

            
            }
            
            
        
                
                Button(action: {
                    self.PICKUPlocation()
                })   {
                    Text("NEXT").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center).padding(1.0).frame(width: UIScreen.main.bounds.width - 50).textCase(.uppercase)
                                    }
                .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
                .padding(.top,25).offset(x: 25,y:-130)
                
            }
    
}
    
    }
        
    
    
    func PICKUPlocation() {
        self.error = false
        if self.location.count <= 0 {
            self.nErr="*must be more than one characters"
            self.error = true
        }

}
    
struct AddNewOrderView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewOrderView()
    }
}
}
