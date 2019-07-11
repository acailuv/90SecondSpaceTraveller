public class StringRandomizer {

    protected final int[] lowerCaseAsciiBounds = {97, 122};
    protected final int[] upperCaseAsciiBounds = {65, 90};
    protected int randomNumber;
    private int mode;

    public StringRandomizer(int mode) {
        this.mode = mode;
        //mode 0 -> lowercase;
        //mode 1 -> uppercase;
    }
    
    public StringRandomizer() {
        //do nothing;
    }

    public String generateString(int len) {
        String result = "";

        for (int i=0; i<len; i++) {
            if (this.mode == 0) { //lowercase
                randomNumber = (int)random(lowerCaseAsciiBounds[0], lowerCaseAsciiBounds[1]);
            } else { //uppercase
                randomNumber = (int)random(upperCaseAsciiBounds[0], upperCaseAsciiBounds[1]);
            }
            result += Character.toString((char)randomNumber);
        }
        return result;
    }

    public Character generateChar(int mode) {
        if (mode==0) { //lowercase
            randomNumber = (int)random(lowerCaseAsciiBounds[0], lowerCaseAsciiBounds[1]);
        } else { //uppercase
            randomNumber = (int)random(upperCaseAsciiBounds[0], upperCaseAsciiBounds[1]);
        }

        return (char)randomNumber;
    }

    private boolean checkVowel(Character c) {
        Character[] vowels = {'a', 'i', 'u', 'e', 'o', 'A', 'I', 'U', 'E', 'O'};
        for (int i=0; i<5; i++) {
            if (c==vowels[i]) {
                return true;
            }
        }
        return false;
    }

    public String generatePlanetName(int len) {
        String result = "";
        Character currentChar;

        for (int i=0; i<len; i++) {
            if (i==0) {
                do {
                    currentChar = generateChar(1);
                } while (checkVowel(currentChar));
            } else {
                if (i%2==1) {
                    do {
                        currentChar = generateChar(0);
                    } while (!checkVowel(currentChar));
                } else {
                    do {
                        currentChar = generateChar(0);
                    } while (checkVowel(currentChar));
                }
            }
            result += Character.toString(currentChar);
        }
        return result;
    }
}
