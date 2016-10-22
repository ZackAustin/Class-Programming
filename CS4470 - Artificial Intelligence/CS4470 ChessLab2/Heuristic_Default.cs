using UvsChess;

namespace StudentAI
{
    class Heuristic_Default
    {
        private static readonly int CHESSBOARD_SIZE = 8;

        private Heuristic_Default() { }

        public static int GetHeuristicValue(ChessBoard chessboard, ChessColor color)
        {
            int heuristicValue = 0;

            for (int row = 0; row < CHESSBOARD_SIZE; row++)
            {
                for (int column = 0; column < CHESSBOARD_SIZE; column++)
                {
                    if (chessboard[row, column] != ChessPiece.Empty)
                    {
                        heuristicValue += GetChessPieceValue(chessboard[row, column], PieceOwnedByColor(chessboard[row, column], color));
                    }
                }
            }

            return heuristicValue;
        }

        private static bool PieceOwnedByColor(ChessPiece chessPiece, ChessColor color)
        {
            if (chessPiece.ToString().Contains(color.ToString()))
            {
                return true;
            }
            return false;
        }

        private static int GetChessPieceValue(ChessPiece chessPiece, bool isMyPiece)
        {
            int value = 0;
            if (chessPiece == ChessPiece.BlackPawn || chessPiece == ChessPiece.WhitePawn)
            {
                value = 10;
            }
            else if (chessPiece == ChessPiece.BlackBishop || chessPiece == ChessPiece.WhiteBishop || chessPiece == ChessPiece.BlackKnight || chessPiece == ChessPiece.WhiteKnight)
            {
                value = 40;
            }
            else if (chessPiece == ChessPiece.BlackQueen || chessPiece == ChessPiece.WhiteQueen)
            {
                value = 100;
            }
            else if (chessPiece == ChessPiece.BlackRook || chessPiece == ChessPiece.WhiteRook)
            {
                value = 50;
            }
            else if (chessPiece == ChessPiece.BlackKing || chessPiece == ChessPiece.WhiteKing)
            {
                if (isMyPiece)
                    value += 1;
                else value -= 1;
            }

            if (!isMyPiece)
            {
                value *= -1;
            }

            return value;
        }
    }
}
