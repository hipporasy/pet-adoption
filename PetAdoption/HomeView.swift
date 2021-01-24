//
//  HomeView.swift
//  PetAdoption
//
//  Created by Marasy Phi on 23/1/21.
//

import SwiftUI

struct HomeView: View {
    
    @State private var _selectedPetType: Pet.PetType = .dogs
    
    var profileView: some View {
        Image("profile")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 36, height: 36)
            .clipShape(Circle())
    }
    
    init() {
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search", text: .constant(""))
                    .foregroundColor(.gray)
                    .font(.system(size: 16, weight: .regular))
                    .padding()
                Image(systemName: "magnifyingglass")
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                    .background(Color.primaryColor)
                    .cornerRadius(10)
            }
            .frame(height: 40)
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.lightGrey, lineWidth: 1))
            .padding()
            PetTypeView(selectedPetType: $_selectedPetType)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(_selectedPetType.pets) { pet in
                        PetView(pet: pet)
                    }
                }
            }
            Spacer()
        }
        .background(Color.white)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(trailing: profileView)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Image("location")
                        .foregroundColor(.primaryColor)
                    TextField("Search for Location", text: .constant("Phnom Penh, KH"))
                        .foregroundColor(.darkText)
                    Spacer().frame(width: 50)
                    Image(systemName: "xmark")
                        .foregroundColor(.darkText)
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .frame(width: 280, height: 36)
                .background(Color.primaryLight)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        })
    }
    
}

private extension Pet.PetType {
    
    var pets: [Pet] {
        switch self {
        case .dogs:
            return Pet.dogs
        case .cats:
            return Pet.cats
        default:
            return []
        }
    }
    
}

struct PetTypeView: View {
    
    @Binding var selectedPetType: Pet.PetType
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Pet.PetType.allCases) { petType in
                    Button(action: {
                        selectedPetType = petType
                    }) {
                        VStack {
                            Image(petType.rawValue)
                                .foregroundColor(selectedPetType == petType ? .secondaryDark : .darkText)
                                .frame(width: 64, height: 64)
                                .background(selectedPetType == petType ? Color.secondaryColor : .clear)
                                .cornerRadius(15)
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.lightGrey, lineWidth: 1))
                            Text(petType.id)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.darkText)
                        }
                    }
                }
            }
            .padding(.leading)
            .padding(.trailing)
        }
    }
    
}

struct PetView: View {
    
    let pet: Pet
    
    @State var isFavorite: Bool = false
    
    var body: some View {
        NavigationLink(
            destination: PetDetailView(pet: pet)) {
            VStack {
                ZStack(alignment: .topTrailing) {
                    Image(pet.images.first!)
                        .resizable()
                        .frame(height: 160)
                        .clipShape(RoundedCorner(radius: 15, corners: [.topLeft, .topRight]))
                    Button(action: {
                        isFavorite.toggle()
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(.primaryColor)
                            .frame(width: 32, height: 32)
                            .background(Color.white)
                            .clipShape(Circle())
                            .padding(10)
                    }
                }
                HStack {
                    Text(pet.displayType)
                        .frame(width: 70, height: 22)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(pet.isAdult ? .primaryYellow : .primaryColor)
                        .background(pet.isAdult ? Color.secondaryYellow : Color.primaryLight)
                        .cornerRadius(10)
                    Spacer()
                    Image(pet.gender.rawValue)
                        .foregroundColor(pet.isAdult ? Color.primaryYellow : Color.primaryColor)
                }
                .padding(.leading)
                .padding(.trailing)
                
                VStack(spacing: 4) {
                    Text(pet.name)
                        .font(.system(size: 18, weight: .medium))
                    Text(pet.breed.description)
                        .font(.system(size: 14, weight: .regular))
                }
                .foregroundColor(.darkText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .padding(.bottom, 10)
            }
            .background(RoundedRectangle(cornerRadius: 15).stroke(Color.lightGrey, lineWidth: 1))
            .padding(.leading)
            .padding(.trailing)
        }
    }
    
}

struct HomeViewPreviewProvider: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
    
}
