String inputText = "Sphinx of black quartz, judge my vow!"; //Contains every letter in the english alphabet. You can copy and paste text into here
//String inputText = "abcdabcd";
char[] cipherText = inputText.toCharArray(); //Converts input intto an array of chars
char[] plainText; // This is the 'output'
//Full alphabet below with lowercase, uppercase and punctuation, add anything you think is necessary
//char[] alphabet   = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z', ' ', ',', '.', '\'', '?', '!', '\"', '(', ')'};
//simplified alphabet below
char[] alphabet     = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z', ' ', ',', '.', '\'', '?', '!', '\"', '(', ')'};
//Only lowercase letters for frequency analysis
char[] alphabet_low = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
//Substitution alphabet for the substitution cipher, line up with actual alphabet (In lower case at moment, might be better to also inclued uppercase)
//--------------------{'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'}
char[] sub          = {'z','y','x','w','v','u','t','s','r','q','p','o','n','m','l','k','j','i','h','g','f','e','d','c','b','a', ' ', ',', '.', '\'', '?', '!', '\"', '(', ')'};

//Letter frequencies in normal english
//                           A      B      C      D      E       F      G      H      I      J      K      L      M      N      O      P      Q      R      S      T      U      V      W      X      Y      Z
float[] letterFrequencies = {8.167, 1.492, 2.782, 4.253, 12.702, 2.228, 2.015, 6.094, 6.966, 0.153, 0.772, 4.025, 2.406, 6.749, 7.507, 1.929, 0.095, 5.987, 6.327, 9.056, 2.758, 0.978, 2.360, 0.150, 1.974, 0.074};

PrintWriter output;

void setup(){
  surface.setVisible(false);//Removes window
  
  output = createWriter("example2.txt");
  //Takes input from .txt file in same folder
  String[] inputTXT = loadStrings("example.txt");
  String input = join(inputTXT, " "); 
  
  noLoop();
}

void draw(){
  //Put code in here
  
  
}

//----------------------------------------------------------------------------------------------

void printLetterFrequency(char[] input){ //Outputs letter frequencies of input char array
  float[] temp = frequencyAnalysis(input);
  int counter = 0;
  
  println("English: \t\t" + "CipherText:");
  for(int i = 0; i < temp.length; i++){
     print(char(counter + 97) + ": ");
     print(letterFrequencies[i] + "% \t\t");
     print(char(counter + 97) + ": ");
     println(temp[i] * 100 + "% \t\t");
     counter++;
  }
}

char[] substitution(char[] input, char[] sub_alphabet){//Substitutes letters in input with letters in sub_alphabet from above
  char[] output = new char[input.length];
  
  for(int i = 0; i < input.length; i++){
    for(int j = 0; j < alphabet.length; j++){
      if(input[i] == alphabet[j]){
        output[i] = sub_alphabet[j];
      }
    }
  }
  
  return output;
}

char[] shift(char[] input, int shift){//Shifts every letter along by int shift (i.e. ceaser cipher)
  //WARNING: doesn't work with negative shift values
  char[] output = new char[input.length];
  
  for(int i = 0; i < input.length; i++){
    int temp = (i+shift)%input.length;
    output[temp] = input[i];
  }
  
  return output;
}

float[] frequencyAnalysis(char[] in){//Does frequency analysis of letters in char[] in
  float[] output = new float[26];
  char [] input = new char[in.length];
  input = tLC(new String(in));
  
  for (char c : input){
    for(int j = 0; j < alphabet_low.length; j++){
      if(c == alphabet_low[j]){
        output[j]++;
      }
    }
  }
  
  println(input.length);
  
  for(int i = 0; i < output.length; i++){
    output[i] = output[i]/input.length; 
  }
  
  return output;
}

char[] tLC(String in){//Takes input String in and returns a char array of only letters, all converted to lowercase
  in = in.toLowerCase();
  //print(in);
  //print("\n");
  char[] input = in.toCharArray();
  //char temp[] = new char[input.length];
  ArrayList<Character> temp = new ArrayList<Character>();
  //int pointer = 0;
  for(char c : input){
    for(char c1 : alphabet_low){
      if(c == c1){
        //temp[pointer] = c;
        temp.add(c);
      }
    }
  }
  char[] output = new char[temp.size()];
  for(int i = 0; i < temp.size(); i++){
    output[i] = temp.get(i); 
  }
  return output;
}

//Add more functions here
