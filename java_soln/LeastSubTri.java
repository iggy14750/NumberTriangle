import java.util.Scanner;

public class LeastSubTri {
	public static void main(String[] args){
		//Scanner sc = new Scanner(System.in);
		//System.out.println("Enter number of rows for your triangle.");
		int rows = Integer.parseInt(args[0]);//sc.nextInt();
		//System.out.println("Enter Seed for your triange. (Seed != 0) (-50 < seed < 50)");
		int seed = Integer.parseInt(args[1]);//sc.nextInt();
		
		System.out.print("\nYour Triangle:\n");
		int[][] newTri = TriGenerator.newModular(rows, seed);
		for(int i=0; i<newTri.length; i++){
			//System.out.println();
			for(int j=0; j<newTri[i].length; j++){
				//System.out.print(newTri[i][j] + " ");
			}
		}
		//System.out.println();
		
		int[][] partialSums = new int[rows][];
		for(int i=0; i<partialSums.length; i++){
			partialSums[i] = new int[i+2];
		}
		
        System.out.println("\nThe Partial Sums Triangle:\n");
		for(int i=0; i<partialSums.length; i++){
			for(int j=0; j<partialSums[i].length; j++){
				if(j==0){
					partialSums[i][j] = 0;
				} else{
					partialSums[i][j] = partialSums[i][j-1] + newTri[i][j-1];
				}
                //System.out.print(partialSums[i][j] + " ");
			}
            //System.out.println();
		}
		
		int minSum = 100000;
		int tempSum = 0;
		
		
		//needs reworked, forgot exact algorithm, working on producing it
		
		for(int i=0; i<partialSums.length; i++){
			for(int j=0; j<(partialSums[i].length-1); j++){
                tempSum = 0;
                for (int k = i; k<(partialSums.length); k++) {
                    tempSum += (partialSums[k][k-i+j+1] - partialSums[k][j]);
                    if (tempSum < minSum) {
                        minSum = tempSum;
                    }
                    //System.out.println("minSum: " + minSum + " tempSum: " + tempSum);
                }
			}
		}
        
        System.out.println("Here is my answer: " + minSum);
	}
}