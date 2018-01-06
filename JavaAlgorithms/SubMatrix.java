/**
matrix = [[1, 0, 0, 2], 
          [0, 5, 0, 1], 
          [0, 0, 3, 5]]
rowsToDelete = [1] and columnsToDelete = [0, 2], the output should be

constructSubmatrix(matrix, rowsToDelete, columnsToDelete) = [[0, 2],
                                                             [0, 5]]
*/
class SubMatrix {
	
	public static void main(String[] args) {
		int[][] matrix = {{1,0,0,2},
						  {0,5,0,1},
						  {0,0,3,5}};
		int[] rowsToDelete = {1};
		int[] columnsToDelete = {0,2};
		
		int[][] subMatrix;
		subMatrix = constructSubmatrix(matrix, rowsToDelete, columnsToDelete);
		
		for(int i = 0; i < matrix.length; i++) {
			for(int j = 1; j < matrix[0].length; j++) {
				System.out.print(subMatrix[i][j]);
			}
			System.out.println();
		}
	}
	
	public static int[][] constructSubmatrix(int[][] matrix, int[] rowsToDelete, int[] columnsToDelete){
		int[][] temp = new int[matrix.length - rowsToDelete.length][matrix[0].length - columnsToDelete.length];
		
		for(int i = 0; i < temp.length; i++) {
			if(i == rowsToDelete[i]) {
			 	continue;
			}
			else {
				temp[i][0] = matrix[i][0];
			}
		
		
			for(int j = 0; j < temp[0].length; j++) {
				if(j == columnsToDelete[j]) {
					continue;
				}
				else {
					temp[i][j] = matrix[i][j];
				}
			}
		}
		
		matrix = temp;
		return matrix;
	}
}













