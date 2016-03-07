import java.util.Scanner;

public class LeastSubTri {
	public static void main(String[] args){
		Scanner sc = new Scanner(System.in);
		System.out.println("Enter number of rows for your triangle.");
		int rows = sc.nextInt();
		System.out.println("Enter Seed for your triange. (Seed != 0) (-50 < seed < 50)");
		int seed = sc.nextInt();
		
		System.out.print("\n Your Triangle:");
		int[][] newTri = TriGenerator.newModular(rows, seed);
		for(int i=0; i<newTri.length; i++){
			System.out.println();
			for(int j=0; j<newTri[i].length; j++){
				System.out.print(newTri[i][j] + " ");
			}
		}
		System.out.println();
		
		int[][] partialSums = new int[rows][];
		for(int i=0; i<partialSums.length; i++){
			partialSums[i] = new int[i+1];
		}
		
		for(int i=0; i<partialSums.length; i++){
			for(int j=0; j<partialSums[i].length; j++){
				if(j==0){
					partialSums[i][j] = newTri[i][j];
				} else{
					partialSums[i][j] = partialSums[i][j-1] + newTri[i][j];
				}
			}
		}
		
		int minSum = 100000;
		int tempSum = 0;
		
		
		//needs reworked, forgot exact algorithm, working on producing it
		
		for(int i=0; i<partialSums.length; i++){
			tempSum = 0;
			for(int j=i; j<partialSums.length; j++){
				tempSum += partialSums[j][j];
				if(tempSum < minSum){
					minSum = tempSum;
				}
			}
		}
	}
}