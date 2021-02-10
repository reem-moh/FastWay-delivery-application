//
//  cardCourier.swift
//  FastWay
//
//  Created by Reem on 10/02/2021.
//
import SwiftUI


// CardView
struct CardView: View {
    @EnvironmentObject var model : CarouselViewModel
    var card: Card
    var animation: Namespace.ID
    var body: some View {
        
        VStack{
            
            Text("Monday 28 December")
                .font(.caption)
                .foregroundColor(Color.black.opacity(0.85))
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding()
                .padding(.top,10)
                .matchedGeometryEffect(id: "Date-\(card.id)", in: animation)
            
            HStack {
                Text("order 1")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .frame(width: 250, alignment: .leading)
                    .padding()
                    .matchedGeometryEffect(id: "Title-\(card.id)", in: animation)
                
                Spacer(minLength: 0)
            }
            
            Spacer(minLength: 0)
            
            HStack{
                
                Spacer(minLength: 0)
                
                if !model.showContent{
                    
                    Text("Read More")
                    
                    Image(systemName: "arrow.right")
                }
            }
            .foregroundColor(Color.gray.opacity(0.9))
            .padding(30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            card.cardColor
                .cornerRadius(25)
                .matchedGeometryEffect(id: "bgColor-\(card.id)", in: animation)
        )
        .onTapGesture {
            withAnimation(.spring()){
                
                model.selectedCard = card
                model.showCard.toggle()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    
                    withAnimation(.easeIn){
                        
                        model.showContent = true
                    }
                }
            }
        }
    }
}

// DetailView
struct DetailView: View {
    @EnvironmentObject var model: CarouselViewModel
    var animation: Namespace.ID
    var body: some View {
        
        ZStack {
            ScrollView{
                //content
                VStack{
                    
                    Text("Monday 28 December")
                        .font(.caption)
                        .foregroundColor(Color.black.opacity(0.85))
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding()
                        .padding(.top,10)
                        .matchedGeometryEffect(id: "Date-\(model.selectedCard.id)", in: animation)
                    
                    HStack {
                        Text("Order 1")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .frame(width: 250, alignment: .leading)
                            .padding()
                            .matchedGeometryEffect(id: "Title-\(model.selectedCard.id)", in: animation)
                        
                        Spacer(minLength: 0)
                    }
                    
                    // Detail Text Content....
                    // Showing content Some Delay For Better Animation...
                    
                    if model.showContent{
                        
                        Text(model.getOrderDetails())
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                            .padding()
                            .animation(.easeIn)
                    }
                    
                    Spacer(minLength: 0)
                    
                    // CLose Button..
                    VStack{
                        
                        if model.showContent{
                            
                            Button(action: CloseView, label: {
                                
                                Image(systemName: "arrow.down")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.blue)
                                    .padding()
                                    .background(Color.white.opacity(0.6))
                                    .clipShape(Circle())
                                    .padding(5)
                                    .background(Color.white.opacity(0.7))
                                    .clipShape(Circle())
                                    .shadow(radius: 3)
                            })
                            .padding(.bottom)
                        }
                        
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 630)
                .background(
                
                    model.selectedCard.cardColor
                        .cornerRadius(25)
                        .matchedGeometryEffect(id: "bgColor-\(model.selectedCard.id)", in: animation)
                        .ignoresSafeArea(.all, edges: .bottom)
                )
                
            }
        }
    }
    
    func CloseView(){
        
        withAnimation(.spring()){
            model.showCard.toggle()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                
                withAnimation(.easeIn){
                    
                    model.showContent = false
                }
            }
        }
    }
}

// CarouselViewModel
class CarouselViewModel: ObservableObject {
    

  @Published var cards = [

    Card(cardColor: Color("CardColor1"),title: ""),
    Card(cardColor: Color("CardColor2"),title: ""),
    Card(cardColor: Color("CardColor3"),title: ""),
    Card(cardColor: Color("CardColor4"), title: "Brush up on hygine."),
    Card(cardColor: Color("CardColor5"), title: "Neurobics for your mind."),
    ]
    
    @Published var swipedCard = 0
    
    // Detail Content....
    
    @Published var showCard = false
    @Published var selectedCard = Card(cardColor: .clear, title: "")
    
    @Published var showContent = false
    
    var content = "Humans have long used cognitive enhancement methods to expand the proficiency and range of the various mental activities that they engage in, including writing to store and retrieve information, and computers that allow them to perform myriad activities that are now commonplace in the internet age. Neuroenhancement describes the use of neuroscience-based techniques for enhancing cognitive function by acting directly on the human brain and nervous system, altering its properties to increase performance. Cognitive neuroscience has now reached the point where it may begin to put theory derived from years of experimentation into practice. This special issue includes 16 articles that employ or examine a variety of neuroenhancement methods currently being developed to increase cognition in healthy people and in patients with neurological or psychiatric illness.This includes transcranial electromagnetic stimulation methods, such as transcranial direct current stimulation (tDCS) and transcranial magnetic stimulation (TMS), along with deep brain stimulation, neurofeedback, behavioral training techniques, and these and other techniques in conjunction with neuroimaging."
    
    func getTitle(Id: String) -> String{
        return "gg";
    }
    
    func getOrderDetails() -> String{
        return content;
    }
    
}

struct Card: Identifiable {
    
    var id = UUID().uuidString
    var cardColor: Color
    var offset: CGFloat = 0
    var title: String
}


