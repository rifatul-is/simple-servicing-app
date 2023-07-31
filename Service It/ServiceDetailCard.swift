//
//  ServiceDetailCard.swift
//  Service It
//
//  Created by Rifatul Islam on 4/6/23.
//

import SwiftUI
import CoreLocation
import MapKit

struct ServiceDetailCard: View {
    
    @State var user_id : String
    
    @State var shopId : String
    @State var shopName : String
    
//    @State var location : String
//    @State var serviceName : String
//    @State var serviceDetails : String
//    @State var price : String
//    @State var requiredTime : String
//    @State var contact : String
//    @State var image : String
    
    @State var serviceDetails : ServiceDetails
    
    @State var rating : String
    
    var body: some View {
        
//        let locationArray = location.components(separatedBy: ", ")
//        let locationLat = locationArray[0]
//        let locationLong = locationArray[1]
        
        let locationArray = serviceDetails.shop_details.location.components(separatedBy: ", ")
        
        let locationlat = (locationArray[0] as NSString).doubleValue
        let locationlong = (locationArray[1] as NSString).doubleValue

        
        VStack(alignment: .leading){
            HStack(alignment: .top){
                
//                VStack {
//                    AsyncImage(url: URL(string: image)) { image in
//                              image
//                                  .resizable()
//                                  .aspectRatio(contentMode: .fill)
//
//                          } placeholder: {
//                              Color.gray
//                          }
//                          .frame(width: 100, height: 100)
//                          .cornerRadius(5)
//                      .padding(.trailing, 10)
//
//                    Text("Rating : \(rating) ☆")
//                        .bold()
//                        .foregroundColor(.gray)
//
//                }
                
                VStack (alignment: .leading, spacing: 4) {
                    Text(serviceDetails.service_name)
                        .font(.title3)
                        .bold()
                    
                    Text(serviceDetails.shop_details.shop_name)
                        .bold()
                        .font(.title3)
                        .foregroundColor(.gray)
                    
//                    Text("Time : \(requiredTime)")
//                        .foregroundColor(.gray)
                    
                    Text(serviceDetails.service_details)
                        .font(.footnote)
                        .foregroundColor(.gray)
                    

                }
            }
            
            Divider()
                .padding(.vertical)
            
            HStack{
                Text("Price : $\(serviceDetails.price)")
                    .bold()
                    .padding(.all, 10)
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
                
                Spacer()
                
                
                NavigationLink{
                    ServiceDetailsFromMap(loginId: self.user_id, shopId: self.shopId, serviceDetails: self.serviceDetails, region: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locationlat, longitude: locationlong), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))

                } label: {
                    Text("View Details")
                        .bold()
                        .padding(.all, 10)
                        .foregroundColor(.black)
                        .background(Color(.systemGray4))
                        .cornerRadius(5)
                }
                
                
                
            }
            
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 20, alignment: .leading)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .onAppear{
            
//            var locationLat = locationArray[0]
//            var locationLong = locationArray[1]
            //print(location)
            //print(locationArray)
//            print(locationLat)
//            print(locationLong)

        }
    }
}

struct ServiceDetailCard_Previews: PreviewProvider {
    static var previews: some View {
        ServiceDetailCard(user_id: "", shopId: "", shopName: "", serviceDetails: ServiceDetails(service_id: "", service_type_id: "", service_name: "", service_details: "", price: "", required_time: "", shop_id: "", shop_details: ShopDetails(shop_id: "", shop_name: "", location: "", contact_number: "", image: "", rating: "")), rating: "")
    }
}
