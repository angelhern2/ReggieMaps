//
//  ContactView.swift
//  Reggie's Map
//
//  Created by angel hernandez on 6/23/25.
//
import SwiftUI

struct ContactView: View {
    
    var body: some View {
            HStack{
            Text("Connect with us! ").font(.largeTitle) .bold()
            Spacer()
        }
            ScrollView{
                Section(header: Text("Contact us").foregroundColor(.gray.opacity(0.9))){
                    HStack{ Text("Office") ;Spacer(); Text("Phone Number")} .padding(2) .foregroundColor(.black.opacity(0.7))
                    itemContactView(label: "Admissions Office", phoneNumber: "309-438-2181")
                    itemContactView(label: "Alumni Engagement", phoneNumber: "309-438-2586")
                    itemContactView(label: "Dining at Illinois State", phoneNumber: "309-438-8351")
                    itemContactView(label: "Dean of Students", phoneNumber: "309-438-2008")
                    itemContactView(label: "Student Access and Accommodation Services", phoneNumber: "309-438-5853")
                    itemContactView(label: "Financial Aid", phoneNumber: "309-438-2231")
                    itemContactView(label: "Honors Program", phoneNumber: "309-438-2559")
                    itemContactView(label: "Human Resources", phoneNumber: "309-438-8311")
                    itemContactView(label: "International Engagement", phoneNumber: "309-438-5365")
                    itemContactView(label: "Parent and Family Services", phoneNumber: "309-438-2008")
                    itemContactView(label: "Technology Support Center", phoneNumber: "309-438-4357")
                    itemContactView(label: "University Housing Services", phoneNumber: "309-438-8611")
                    itemContactView(label: "Veterans Services", phoneNumber: "309-438-2207")
                }// end contct us of section
                Section(header: Text("Follow our Socials").foregroundColor(.gray.opacity(0.9))){
                    HStack
                        {
                            
                            socialButton(buttonUrl: "https://www.facebook.com/IllinoisStateUniversity", buttonImage: "facebooklogo" )//FaceBook
                            Spacer()
                            socialButton(buttonUrl: "https://x.com/IllinoisStateU", buttonImage: "xlogo" )//X
                            Spacer()
                            socialButton( buttonUrl: "https://www.linkedin.com/school/illinois-state-university/", buttonImage: "inlogo" )//Linked-In
                            Spacer()
                            socialButton( buttonUrl: "https://www.youtube.com/IllinoisStateUniv", buttonImage: "ytlogo")//YouTube
                            Spacer()
                            socialButton( buttonUrl: "https://www.instagram.com/illinoisstateu/", buttonImage: "instagramlogo")//Instagram
                        }
                        HStack{
                            Spacer()
                            socialButton(buttonUrl: "https://www.flickr.com/photos/illinois_state", buttonImage: "flickerlogo")// Flicker
                            Spacer()
                            socialButton(buttonUrl: "https://www.snapchat.com/@illinoisstate", buttonImage: "snaplogo" )// Snapchat
                            Spacer()
                            socialButton( buttonUrl: "https://www.tiktok.com/@illinoisstateu?lan", buttonImage: "ttlogo")//Tik-Tok
                            Spacer()
                            socialButton(buttonUrl: "https://open.spotify.com/user/52bptpfzmse35fjaxv1alnhmp?si=28ba376d08304b46&nd=1&dlsi=a83e6ca82fac4217", buttonImage: "spotifylogo")// Spotify ned to link latr when i am signed out

                            Spacer()
                        }
                    Divider()
                } .padding(.horizontal, 10)// end of socials section
                    .padding(.vertical, 2)
            }
            .padding(.horizontal , 8)
            .frame(width: .infinity , height: .infinity ,alignment: .leading)// end of scrollview
        
    }// end of main view
    
    struct socialButton: View {

        var buttonUrl: String
        var buttonImage: String
        
        var body: some View {
            Link(destination: URL(string: buttonUrl)!)
                    {
                        Image(buttonImage)
                            .resizable()
                            .padding(5)
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .background(Color.SecondaryColor)
                            .clipShape(Circle())
                            .overlay( Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 2)
                    }
        }
    }
    
    // reusable ui for a phone item
    struct itemContactView: View {
        
        let label: String
        let phoneNumber: String
        var emailAddress: String?
        
        var body: some View {
                HStack{
                    Text(label)
                        .font(.headline)
                        .foregroundColor(.PrimaryColor)
                        Spacer()
                    HStack{
                    
                        Link("\(phoneNumber)", destination: URL(string: "tel://\(phoneNumber.replacingOccurrences(of: "-", with: ""))")!)
                    }
                }
            Divider()
        }
    }
    

    
    
    
}

#Preview {
    ContactView()
}
