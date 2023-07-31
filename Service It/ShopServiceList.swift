//
//  ShopCard.swift
//  Service It
//
//  Created by Rifatul Islam on 4/6/23.
//

import SwiftUI

struct ShopServiceList: View {
    @State var user_id : String
    @State var serviceName : String
    @State var serviceDetails : String
    @State var servicePrice : String
    @State var serviceTime : String
    @State var serviceRating : String

    
    var body: some View {
        VStack(alignment: .leading){
            NavigationLink{
                ServiceDetailScreen(user_id: self.user_id, serviceType: 0, shopId: "0")
            } label: {
                VStack (alignment: .leading, spacing: 4) {
                        Text(serviceName)
                            .font(.title3)
                            .bold()
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                        
//                    Text("Price : $\(servicePrice)")
//                        .font(.footnote)
//                        .foregroundColor(.gray)
//                        .multilineTextAlignment(.leading)
                }
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct ShopServiceList_Previews: PreviewProvider {
    static var previews: some View {
        ShopServiceList(user_id: "0", serviceName: "Name it is when name is too big", serviceDetails: "Details must be bigger then everything else there is in the world there is not to know", servicePrice: "0", serviceTime: "Time", serviceRating: "Rating")
    }
}
