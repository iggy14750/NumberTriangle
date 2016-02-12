import java.io.*;
import java.util.*;

public class BruteForce {
    
    public static void main(String[] args) {
        final int ARBITRARY_STARTING_SUM = 5318008;

        while (true) {
        Scanner sc = new Scanner(System.in);
        System.out.print("How many rows in this one?");
        int wantedRows = sc.nextInt();
        Triangle t = Triangle.getRandomTriangle(Triangle.elements(wantedRows));
        // try {
            // int[] messyData;
            // messyData = readArrayFile("data.txt");
            // t = new Triangle(messyData);
        // } catch (IOException ioex) {
            // System.out.println(ioex.toString());
        // }
        System.out.println(t.toString());
        int currentSum = ARBITRARY_STARTING_SUM;
        Triangle bestT = t.getRandomTriangle(3);
        /*for (Triangle eachPossibleSubTriangle: t) {
            if (eachPossibleSubTriangle.sum()<currentSum) {
                currentSum = eachPossibleSubTriangle.sum();
            }
        }
        */
        int runningCount = 0;
        for (int i = 0; i<t.height();i++){
            
            for (int j = 0;j <= i; j++) {
                int n = 2;
                
                while (t.getSubTriangle(i,j,n)!=null ) {
                    Triangle q = t.getSubTriangle(i,j,n);
                    //DEBUGGING
                    runningCount++;
                    //System.out.println(q.toString());
                    if (q.sum()<currentSum) {
                        currentSum = q.sum();
                        //DEBUGGING
                        System.out.println("changed sum to: " + currentSum + "\nat sub-t: " + runningCount);
                        bestT = q;
                    } 
                    n++;
                }
            }
        }
        //*/
        
        
        System.out.println("We have a winner! Sum: " + Integer.toString(currentSum)+"\nWe needed to test " + runningCount + " sub-ts to do this.");
        //System.out.print(bestT.toString());
        }
    }
    
    private static int[] readArrayFile(String filename) throws IOException {
        //Reads in our data from a file in TSV or CSV, I think .next() handles both
        //This can easily be modified to separate data via newLines
        File f = new File(filename);
        Scanner sc = new Scanner(f);
        ArrayList<String> strData = new ArrayList<String>();
        
        while (sc.hasNext()){
            strData.add(sc.next());
        }
        
        int[] intData = new int[strData.size()];
        for (int i = 0; i<strData.size();i++) {
            intData[i] = Integer.parseInt(strData.get(i));
        }
        
        sc.close();
        strData = null;
        return intData;
    }
    
}