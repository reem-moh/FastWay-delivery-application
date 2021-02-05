//
//  ContentView.swift
//  FastWay

import SwiftUI


struct ContentView: View {
   // @State var showSign = false
  // @State var showHomeCourier = false
    //@State var showHomeMember = false
    
    @State var showPickup = false
    @State var showDropOff = false
   @State var showSendOrder = false
    @State var showHomeMember = false

    
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                

                
                    
                //HomeMemberView
                NavigationLink(
                    destination: AddNewOrderView(showHomeMember: self.$showPickup ,showDropOff:self.$showDropOff),
                    isActive: self.$showPickup ){
                    Text("")
                }
                .hidden()
             
                
             

                
                      //AddNewOrderView
                      NavigationLink(
                          destination: DROPOFFlocationView(showPickup: self.$showDropOff ,showSendOrder:self.$showSendOrder),
                          isActive: self.$showDropOff ){
                          Text("")
                      }
                      .hidden()
                
            
                
                
                
                
                //DROPOFFlocationView
                            NavigationLink(
                                destination: SendOrderIView(showDropOff: self.$showSendOrder ,showHomeMember:self.$showHomeMember),
                                isActive: self.$showSendOrder ){
                                Text("")
                            }
                            .hidden()
                        
                          
      
                
 
                
                    //SendOrderIView
                               NavigationLink(
                                destination:  HomeMemberView(showSendOrder :self.$showSendOrder,showPickup: self.$showPickup ),
                                   isActive: self.$showHomeMember ){
                                   Text("")
                               }
                               .hidden()
               
         
                
               
                
      
                
        //The firstPage
        HomeMemberView(showSendOrder :self.$showSendOrder,showPickup: self.$showPickup )
                


            
            }
                  .navigationBarTitle("")
                  .navigationBarHidden(true)
                  .navigationBarBackButtonHidden(false)
                  
        
            
            
            }
            
            
    
        
        
        
        }//end of NavigationView



}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

