import SwiftUI

struct ContentView: View {
    @State private var countrySet = Set(["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]).shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showScore: Bool = false
    @State private var score: Int = 0
    @State private var totalRounds: Int = 0
    @State private var alertTitle: String = ""
    
    func answer(with number: Int) {
        if number == correctAnswer {
            score += 1
            alertTitle = "Yup"
        } else {
            alertTitle = "Nope"
        }
        
        totalRounds += 1
        showScore = true
    }
    
    func continueGame() {
        countrySet.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        score = 0
        totalRounds = 0
        continueGame()
    }
    
    var body: some View {
        ZStack {
            RadialGradient(
                stops: [.init(color: .indigo, location: 0), .init(color: .pink, location: 1.7)],
                center: .top,
                startRadius: 120,
                endRadius: 769)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Spacer()
                
                Text("Guess The Flag")
                    .font(.largeTitle.weight(.semibold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 27) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                        
                        Text(countrySet[correctAnswer])
                            .font(.largeTitle.weight(.bold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            answer(with: number)
                        } label: {
                            Image(countrySet[number])
                                .renderingMode(.original)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .padding(.horizontal, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                
                Text(totalRounds > 0 ? "Score: \(score)/\(totalRounds)" : "Score: \(score)")
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding(.bottom, 7)
            }
            .padding()
            .alert(alertTitle, isPresented: $showScore) {
                if alertTitle == "Nope" {
                    Button("Reset", role: .destructive, action: resetGame)
                }
                
                Button("Continue", role: .cancel, action: continueGame)
            } message: {
                Text("Your score is: \(score)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
