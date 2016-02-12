import java.lang.Math.*;
import java.util.Random;
public class Triangle {
    
    private int[][] data;
    private int numRows;
    
    public Triangle(int[] elements) {
        numRows = rows(elements.length);
        data = new int[numRows][];
        int element_getter = 0;
        
        /*Perhaps a bit messy. Arranges single list of numbers into ragged nested array.
        *For example,
        *[
        *[2],
        *[3,4],
        *[5,6,7],
        *[8,9,10,11],
        *[12,13,14,15,16]
        *]
        */
        for (int i = 0; i<numRows; i++ ) {
            data[i] = new int[i+1];
            for (int j = 0; j <= i; j++ ) {
                data[i][j] = elements[element_getter];
                element_getter++;
            }
        }
    }
    
    public Triangle(int[][] formElements) {
        data = formElements;
        numRows = data.length;
    }
    
    public Triangle getSubTriangle(int topRow, int leftColumn, int height) {
        //invalid if leftColumn is greater that topRow, or if topRow+height is greater than numRows.. or if any of them are negative.
        if (leftColumn>topRow || (topRow+height)>numRows || topRow<0 || leftColumn<0 || height<0) {
            return null;
        }
        int[][] newData = new int[height][];
        
        for (int i=0;i<height;i++) {
            
            newData[i] = new int[i+1];
            
            for (int j=0;j <= i; j++) {
                
                newData[i][j] = data[i+topRow][j+leftColumn];
                
            }
        }
        
        Triangle t = new Triangle(newData);
        return t;
    }
    
    public static Triangle getRandomTriangle(int bound) {
        int[] rando = new int[bound];
        int t = 100;
        Random aynRand = new Random();
        for (int i=0;i<bound; i++) {
            //t = (23*t+17)%100;
            
            rando[i] = aynRand.nextInt(t)-50;
        }
        return new Triangle(rando);
    }
    
    public int sum() {
        int sum = 0;
        
        for (int[] row: data) {
            for (int guy: row) {
                sum+=guy;
            }
        }
        
        return sum;
    }
    
    public String toString() {
        //StringBuilder sb = new StringBuilder();
        String thingy="";
        for (int i = 0; i<numRows;i++) {
            
            for (int guy: data[i] ) {
                thingy+=Integer.toString(guy)+",";
            }
            thingy+="\n";
        }
        return thingy;
    }
    
    public int height() {
        return numRows;
    }
    
    // public int[] whereIs(int elem) {
        // //TODO
        
        // return {5,3,1,8,0,0,8};
    // }
    
    public static int elements(int r) {
        return (int) (r*(r+1))/2;
    }
    
    public static int rows(int e) {
        return (int) (Math.sqrt(1+8*e)-1)/2;
    }

}