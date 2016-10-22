public class Puzzle
{
  protected static String[] grid;
  private int wordLen;
  private static final int MAX_GRID = 100;
  public Puzzle(String[] _grid, int size)
  {
    if (size < MAX_GRID)
    {
      grid = _grid;
      wordLen = size;
    }
    else
      grid = new String[MAX_GRID];
  }
  public void setGridRow(String str, int row)
  {
    grid[row] = str;
  }

  //Helpers for each direction of search.
  protected boolean horizontalLTR(String word)
  {
    int len = word.length();
    String tmpWord = "";
    for (int i = 0; i < grid.length; i++) //i is row
    {
      tmpWord = "";
      for (int j = 0; j < grid.length; j++) //j is col
      {
        tmpWord = tmpWord + grid[i].charAt(j); //i and j changes for vertical.
        if (tmpWord.length() > word.length())
          tmpWord = tmpWord.substring(1, tmpWord.length());
        if (word.equals(tmpWord))
        {
          int startCol = j - len + 1;
          System.out.println(word + " found at start: " + i + ", " + startCol + " end: " + i + ", " + j);
          return true;
        }
      }
    }
    return false;
  }
  protected boolean horizontalRTL(String word)
  {
    int len = word.length();
    String tmpWord = "";
    for (int i = 0; i < grid.length; i++) //i is row
    {
      tmpWord = "";
      for (int j = grid.length - 1; j > -1; j--) //j is col
      {
        tmpWord = tmpWord + grid[i].charAt(j); //i and j changes for vertical.
        if (tmpWord.length() > word.length())
          tmpWord = tmpWord.substring(1, tmpWord.length());
        if (word.equals(tmpWord))
        {
          int startCol = j + len - 1;
          System.out.println(word + " found at start: " + i + ", " + startCol + " end: " + i + ", " + j);
          return true;
        }
      }
    }
    return false;
  }
  protected boolean verticalTTB(String word)
  {
    int len = word.length();
    String tmpWord = "";
    for (int i = 0; i < grid.length; i++) //i is col
    {
      tmpWord = "";
      for (int j = 0; j < grid.length; j++) //j is row
      {
        tmpWord = tmpWord + grid[j].charAt(i); //i and j changes for vertical.
        if (tmpWord.length() > word.length())
          tmpWord = tmpWord.substring(1, tmpWord.length());
        if (word.equals(tmpWord))
        {
          int startRow = j - len + 1;
          System.out.println(word + " found at start: " + startRow + ", " + i + " end: " + j + ", " + i);
          return true;
        }
      }
    }
    return false;
  }
  protected boolean verticalBTT(String word)
  {
    int len = word.length();
    String tmpWord = "";
    for (int i = 0; i < grid.length; i++) //i is col
    {
      tmpWord = "";
      for (int j = grid.length - 1; j > -1; j--) //j is row
      {
        tmpWord = tmpWord + grid[j].charAt(i); //i and j changes for vertical.
        if (tmpWord.length() > word.length())
          tmpWord = tmpWord.substring(1, tmpWord.length());
        if (word.equals(tmpWord))
        {
          int startRow = j + len - 1;
          System.out.println(word + " found at start: " + startRow + ", " + i + " end: " + j + ", " + i);
          return true;
        }
      }
    }
    return false;
  }
  protected boolean diagonals(String word)
  {
    int len = word.length(), diagLen = 0;
    String tmpWord = "";
    String tmpWord2 = "";
    String tmpWord3 = "";
    String tmpWord4 = "";
    for(int i = 0 ; i < grid.length; i++ )
    {
      tmpWord = "";
      tmpWord2 = "";
      tmpWord3 = "";
      tmpWord4 = "";
        for( int diag = 0; diag <= diagLen ; diag++ )
        {
            //first half BRTTL
            tmpWord = tmpWord + grid[grid.length - 1 - diag].charAt(i - diag);
            if (tmpWord.length() > word.length())
              tmpWord = tmpWord.substring(1, tmpWord.length());

            if (word.equals(tmpWord))
            {
              int endRow = grid.length - 1 - diag;
              int endCol = i - diag;
              int startRow = len + endRow - 1;
              int startCol = len + endCol - 1;
              System.out.println(word + " found at start: " + startRow + ", " + startCol + " end: " + endRow + ", " + endCol);
              return true;
            }
            //second half BRTTL
            tmpWord2 = tmpWord2 + grid[i - diag].charAt(grid.length - 1 - diag);//swapped
            if (tmpWord2.length() > word.length())
              tmpWord2 = tmpWord2.substring(1, tmpWord2.length());

            if (word.equals(tmpWord2))
            {
              int endRow = i - diag;
              int endCol = grid.length - 1 - diag;
              int startRow = len + endRow - 1;
              int startCol = len + endCol - 1;
              System.out.println(word + " found at start: " + startRow + ", " + startCol + " end: " + endRow + ", " + endCol);
              return true;
            }

            //first half BLTTR
            tmpWord3 = tmpWord3 + grid[i - diag].charAt(diag);
            if (tmpWord3.length() > word.length())
              tmpWord3 = tmpWord3.substring(1, tmpWord3.length());

            if (word.equals(tmpWord3))
            {
              int endRow = i - diag;
              int endCol = diag;
              int startRow = endRow + len - 1;
              int startCol = endCol - len + 1;
              System.out.println(word + " found at start: " + startRow + ", " + startCol + " end: " + endRow + ", " + endCol);
              return true;
            }
            //Second half BLTTR
            tmpWord4 = tmpWord4 + grid[grid.length - diag - 1].charAt(grid.length - i + diag - 1);
            if (tmpWord4.length() > word.length())
              tmpWord4 = tmpWord4.substring(1, tmpWord4.length());

            if (word.equals(tmpWord4))
            {
              int endRow = grid.length - diag - 1;
              int endCol = grid.length - i + diag - 1;
              int startRow = endRow + len - 1;
              int startCol = endCol - len + 1;
              System.out.println(word + " found at start: " + startRow + ", " + startCol + " end: " + endRow + ", " + endCol);
              return true;
            }
        }
        diagLen++;
    }

    diagLen = 0;
    for(int i = 0 ; i < grid.length; i++ )
    {
      tmpWord = "";
      tmpWord2 = "";
      tmpWord3 = "";
      tmpWord4 = "";
        for( int diag = diagLen; diag >= 0 ; diag-- )
        {
            //first half TLTBR
            tmpWord = tmpWord + grid[grid.length - 1 - diag].charAt(i - diag);
            if (tmpWord.length() > word.length())
              tmpWord = tmpWord.substring(1, tmpWord.length());
            if (word.equals(tmpWord))
            {
              int endRow = grid.length - 1 - diag;
              int endCol = i - diag;
              int startRow = endRow - len + 1;
              int startCol = endCol - len + 1;
              System.out.println(word + " found at start: " + startRow + ", " + startCol + " end: " + endRow + ", " + endCol);
              return true;
            }
            //second half TLTBR
            tmpWord2 = tmpWord2 + grid[i - diag].charAt(grid.length - 1 - diag);//swapped
            if (tmpWord2.length() > word.length())
              tmpWord2 = tmpWord2.substring(1, tmpWord2.length());
            if (word.equals(tmpWord2))
            {
              int endRow =i - diag;
              int endCol = grid.length - 1 -diag;
              int startRow = endRow - len + 1;
              int startCol = endCol - len + 1;
              System.out.println(word + " found at start: " + startRow + ", " + startCol + " end: " + endRow + ", " + endCol);
              return true;
            }

            //first half TRTBL
            tmpWord3 = tmpWord3 + grid[i - diag].charAt(diag);
            if (tmpWord3.length() > word.length())
              tmpWord3 = tmpWord3.substring(1, tmpWord3.length());

            if (word.equals(tmpWord3))
            {
              int endRow = i - diag;
              int endCol = diag;
              int startRow = endRow - len + 1;
              int startCol = endCol + len - 1;
              System.out.println(word + " found at start: " + startRow + ", " + startCol + " end: " + endRow + ", " + endCol);
              return true;
            }
            //Second half TRTBL
            tmpWord4 = tmpWord4 + grid[grid.length - diag - 1].charAt(grid.length - i + diag - 1);
            if (tmpWord4.length() > word.length())
              tmpWord4 = tmpWord4.substring(1, tmpWord4.length());

            if (word.equals(tmpWord4))
            {
              int endRow = grid.length - diag - 1;
              int endCol = grid.length - i + diag - 1;
              int startRow = endRow - len + 1;
              int startCol = endCol + len - 1;
              System.out.println(word + " found at start: " + startRow + ", " + startCol + " end: " + endRow + ", " + endCol);
              return true;
            }
        }
        diagLen++;
    }
    return false;
  }
}