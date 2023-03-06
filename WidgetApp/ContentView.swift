//
//  ContentView.swift
//  WidgetApp
//
//  Created by Najla on 12/09/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var meme: Meme? = nil
    
    var body: some View {
        
        VStack{
        Text("want a meme?")
            .font(.title)
            .padding()
            
            AsyncImage(url: meme?.url){ image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
            } placeholder: {
                ProgressView()
                Text("cooking a fresh meme ...")
            }
            Button("give me another meme"){
                Task{
                    do{
                        meme = try await MemeService.shared.getMeme()
                    } catch{
                        print(error)
                    }
                }
            }
        }
        .task {
            do{
                meme = try await MemeService.shared.getMeme()
            } catch{
                print(error)
            }

        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
