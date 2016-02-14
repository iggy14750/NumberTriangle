import java.util.Random;

public class NumTriangle {
    final int BOUND=50;
    public static int[][] newModular(int numRows, int seed) {
        int[][] myTriangle = new int[numRows][];
        int t = seed;
        
        for (int i = 0; i<numRows; i++) {
            myTriangle[i] = new int[i+1];
            for (int j = 0; j<(i+1); j++) {
                t = (109*t)%(2*BOUND);
                myTriangle[i][j] = t-BOUND;
            }
        }
        return myTriangle;
    }
    
    public static int[][] newRandom(int numRows) {
        int[][] myTriangle = new int[numRows][];
        Random aynRand = new Random();
        for (int i = 0; i<numRows; i++) {
            myTriangle[i] = new int[i+1];
            for (int j = 0; j<(i+1); j++) {
                myTriangle[i][j] = aynRand.nextInt(2*BOUND)-BOUND;
            }
        }
        return myTriangle;
    }
}
