//
//  OnBoardingScreen.swift
//  Animations
//
//  Created by joshua on 12/19/22.
//

import SwiftUI
import Lottie

struct OnBoardingScreen: View {
    //MARK OnBoarding SLides Model Data
    @State var onboardingItems : [OnBoardingItem] = [
        .init(title: "Welcome To Futura™", subTitle: "The next big thing in cryptocurrency. ", lottieView: .init(name:"Circlecrypto",bundle: .main)),
        
        .init(title: "Public Trust Is #1", subTitle: "Here at futura, we put safety the of our customers first. Backed by our 100% Satisfaction guarantee*, customers can safely deposit funds on our platform.", lottieView: .init(name:"Handshake",bundle: .main)),

        
        .init(title: "Ready To Start?", subTitle: "Let's go on this financial journey together. Start by logging in!", lottieView: .init(name:"GetStarted",bundle: .main)),
        ]
    
    //MARK Current Slide Index
    @State var currentIndex : Int = 0
    
    var body: some View {
        GeometryReader{
            let size = $0.size
            HStack(spacing : 0){
                ForEach($onboardingItems){ $item in
                    let isLastSlide = (currentIndex == onboardingItems.count - 1)
                    VStack{
                        //Mark Top Nav Bar
                        HStack{
                            Button("Back"){
                                if currentIndex > 0{
                                    currentIndex-=1
                                    playAnimation()
                                }
                                
                            }
                            .opacity(currentIndex > 0 ? 1 : 0)
                            //.animation(.easeInOut)
                            Spacer(minLength: 0)
                            Button("Skip"){
                                currentIndex = onboardingItems.count - 1
                                playAnimation()
                            }
                            .opacity(isLastSlide ? 0 : 1)
                        }
                        .tint(Color("Green"))
                        .fontWeight(.bold)
                        
                        
                        //Mark Movable SLides
                        VStack(spacing:15){
                            let offset = -CGFloat(currentIndex)*size.width
                            //MARK Resizable Lottie View
                            ResizableLottieView(onboardingItem: $item)
                                .frame(height: size.width)
                                .onAppear{
                                    //MARK INitially Playing First Slide Animation
                                    if currentIndex == indexOf(item){
                                        item.lottieView.play()
                                    }
                                   
                                }
                                .offset(x:offset)
                                .animation(.easeInOut(duration: 0.5),value: currentIndex)
                            Text(item.title)
                                .font(.title.bold())
                                .offset(x:offset)
                                .animation(.easeInOut(duration: 0.5).delay(0.1),value: currentIndex)
                            Text(item.subTitle)
                                .font(.system(size:14))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal,15)
                                .foregroundColor(.gray)
                                .offset(x:offset)
                                .animation(.easeInOut(duration: 0.5).delay(0.1),value: currentIndex)
                        }
                        Spacer()
                        // MARK Next /Login Button
                        VStack(spacing:15){
                            Text(isLastSlide ? "Login" : "Next")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical,isLastSlide ? 13 : 12.0)
                                .frame(maxWidth:.infinity)
                                .background{
                                    Capsule()
                                        .fill(.black)
                                        //.frame(width:300)
                                }
                                .padding(.horizontal,isLastSlide ? 30 : 100)
                                .onTapGesture{
                                    //MARK Updating to
                                    if currentIndex<onboardingItems.count - 1{
                                        //MARK Pausing Previous Animation
                                        let currentProgress = onboardingItems[currentIndex].lottieView.currentProgress
                                        onboardingItems[currentIndex].lottieView.currentProgress = (currentProgress == 0 ? 0.7 : currentProgress)
                                        currentIndex+=1
                                        //MARK: Play next lottie
                                        playAnimation()
                                    }
                                }
                            
                            HStack{
                                Text("Terms of Service")
                                    
                                Text("Privacy Policy")
                            }
                            .font(.caption2)
                            .underline(true,color: .primary)
                            .offset(y:5)
                        }
                        
                    }
                    .animation(.easeInOut, value: isLastSlide)
                    .padding(15)
                    .frame(width:size.width,height:size.height)
                }
            }
            .frame(width:size.width*CGFloat(onboardingItems.count),alignment:.leading)
        }
    }
    
    func playAnimation(){
        onboardingItems[currentIndex].lottieView.currentProgress = 0
        onboardingItems[currentIndex].lottieView.play( )
    }
    
    // Mark Retreving Index of the Item in the Array
    func indexOf(_ item: OnBoardingItem)->Int{
        if let index = onboardingItems.firstIndex(of: item){
            return index
        }
        return 0
    }
}

struct OnBoardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingScreen()
    }
}


//MARK ResizableLottie View WITHOUT BACKGROUND
struct ResizableLottieView : UIViewRepresentable{
    @Binding var onboardingItem : OnBoardingItem
    func makeUIView(context: Context) ->  UIView {
        let view = UIView()
        view.backgroundColor = .clear
        setupLottieView(view)
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {
            
    }
    
    func setupLottieView(_ to:UIView){
        let lottieView = onboardingItem.lottieView
        lottieView.backgroundColor = .clear
        lottieView.loopMode = .loop
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        //Mark Applying Constarints
        let constraints = [
            lottieView.widthAnchor.constraint(equalTo: to.widthAnchor),
            lottieView.heightAnchor.constraint(equalTo: to.heightAnchor)
        ]
        to.addSubview(lottieView)
        to.addConstraints(constraints)
    }
}
