using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UvsChess;

namespace StudentAI
{
    public class Util
    {
        // This is a map to easily determine the color of any given piece
        public static Dictionary<ChessPiece, ChessColor> PIECE_COLOR_MAP = new Dictionary<ChessPiece, ChessColor>
        {
	        {ChessPiece.BlackBishop, ChessColor.Black},
            {ChessPiece.BlackKing, ChessColor.Black},
            {ChessPiece.BlackKnight, ChessColor.Black},
            {ChessPiece.BlackPawn, ChessColor.Black},
            {ChessPiece.BlackQueen, ChessColor.Black},
            {ChessPiece.BlackRook, ChessColor.Black},
            {ChessPiece.WhiteBishop, ChessColor.White},
            {ChessPiece.WhiteKing, ChessColor.White},
            {ChessPiece.WhiteKnight, ChessColor.White},
            {ChessPiece.WhitePawn, ChessColor.White},
            {ChessPiece.WhiteQueen, ChessColor.White},
            {ChessPiece.WhiteRook, ChessColor.White}
        };

        public static int boardEvaluation(ChessBoard chessBoard)
        {
            int cost = 0;
            for (int row = 0; row < ChessBoard.NumberOfRows; row++)
            {
                for (int column = 0; column < ChessBoard.NumberOfColumns; column++)
                {
                    ChessPiece currentPiece = chessBoard[row, column];
                    if (currentPiece != ChessPiece.Empty)
                    {
                        if(PIECE_COLOR_MAP[currentPiece] == ChessColor.Black)
                        {
                            cost -= ((int)currentPiece % 6) + 1;
                        }
                        else
                        {
                            cost += (int)currentPiece % 6;
                        }
                    }
                }
            }

            return cost;
        }

        /// <summary>
        /// Looks at the current board to find the king's location.
        /// </summary>
        /// <param name="boardBeforeMove">The board as it currently is before making the move.</param>
        /// <param name="colorOfKing">The king we're looking for.</param>
        /// <returns>Returns a ChessLocation for that king.</returns>
        public static ChessLocation getKingLocation(ChessBoard boardBeforeMove, ChessColor colorOfKing)
        {
            for (int row = 0; row < ChessBoard.NumberOfRows; row++)
            {
                for (int column = 0; column < ChessBoard.NumberOfColumns; column++)
                {
                    ChessPiece currentPiece = boardBeforeMove[row, column];
                    if (colorOfKing == ChessColor.Black && currentPiece == ChessPiece.BlackKing)
                    {
                        return new ChessLocation(row, column);
                    }
                    else if (colorOfKing == ChessColor.White && currentPiece == ChessPiece.WhiteKing)
                    {
                        return new ChessLocation(row, column);
                    }
                }
            }
            return null;
        }

        /// <summary>
        /// Trys to set the check flag for a given move.
        /// </summary>
        /// <param name="boardBeforeMove">Chessboard before making the selected move.</param>
        /// <param name="moveToCheck"></param>The chess move of the moving piece we're investigating for causing check.
        /// <param name="kingLocation"></param>The location of the king piece being investigated.
        /// <param name="playerColor">Color of player causing check.</param>
        public static void setCheckFlagForMove(ChessBoard boardBeforeMove, ChessMove moveToCheck, ChessLocation kingLocation, ChessColor playerColor)
        {
            //setup board.
            ChessBoard boardAfterMove = boardBeforeMove.Clone();
            boardAfterMove.MakeMove(moveToCheck);

            //get the next set of moves as well to see if any of them cause check.
            List<ChessMove> possibleNextMoves = MoveGenerator.getAllMoves(boardAfterMove, playerColor, false);

            for (int i = 0; i < possibleNextMoves.Count; i++)
            {
                if (possibleNextMoves[i].To.X == kingLocation.X && possibleNextMoves[i].To.Y == kingLocation.Y)
                {
                    //flag for move should be set to 'check.'
                    moveToCheck.Flag = ChessFlag.Check;
                }
            }
        }

        /// <summary>
        /// Trys to set the checkmate flag for a given move.
        /// </summary>
        /// <param name="board">Chessboard after the move.</param>
        /// <param name="move">The move that might cause checkmate.</param>
        /// <param name="kingColor">Color for the king that has to find moves to not be checkmated.</param>
        public static void setCheckmateFlagForMove(ChessBoard board, ChessMove move, ChessColor kingColor)
        {
            //move must first cause check.
            if (move.Flag == ChessFlag.Check)
            {
                //find moves for king.
                List<ChessMove> kingMoves = MoveGenerator.getAllMoves(board, kingColor, false);

                //Legal moves to get out of this check.
                List<ChessMove> possibleMoves = MoveGenerator.getAllLegalMoves(board, kingMoves, kingColor);

                if (possibleMoves.Count < 1)
                {
                    //there are no possible moves. It is checkmate.
                    move.Flag = ChessFlag.Checkmate;
                }
            }
        }

        /// <summary>
        /// Trys to set the stalemate flag for a given move.
        /// </summary>
        /// <param name="board">Chessboard after the move.</param>
        /// <param name="move">The move that might cause stalemate.</param>
        /// <param name="kingColor">Color for the king that has to find moves to not be stalemated.</param>
        public static void setStalemateFlagForMove(ChessBoard board, ChessMove move, ChessColor kingColor)
        {
            //move must not cause check.
            if (move.Flag != ChessFlag.Check && move.Flag != ChessFlag.Checkmate)
            {
                //find moves for king.
                List<ChessMove> kingMoves = MoveGenerator.getAllMoves(board, kingColor, false);

                //Legal moves to get out of this check.
                List<ChessMove> possibleMoves = MoveGenerator.getAllLegalMoves(board, kingMoves, kingColor);

                if (possibleMoves.Count < 1)
                {
                    //there are no possible moves. It is Stalemate.
                    move.Flag = ChessFlag.Stalemate;
                }
            }
        }

        /// <summary>
        /// Validates if a move would flag check.
        /// </summary>
        /// <param name="boardBeforeMove">Chessboard before the move is made.</param>
        /// <param name="moveToCheck"></param>The chess move of the moving piece we're investigating for causing check.
        /// <param name="kingLocation"></param>The location of the king piece being investigated.
        /// <param name="playerColor">Color of player who's trying to cause check.</param>
        /// <returns>Returns a boolean if the check is true. Might be worthless.</returns>
        public static bool isValidCheck(ChessBoard boardBeforeMove, ChessMove moveToCheck, ChessLocation kingLocation, ChessColor playerColor)
        {
            //setup board.
            ChessBoard boardAfterMove = boardBeforeMove.Clone();
            boardAfterMove.MakeMove(moveToCheck);

            //get the next set of moves as well to see if any of them cause check.
            List<ChessMove> possibleNextMoves = MoveGenerator.getAllMoves(boardAfterMove, playerColor, false);

            for (int i = 0; i < possibleNextMoves.Count; i++)
            {
                if (possibleNextMoves[i].To.X == kingLocation.X && possibleNextMoves[i].To.Y == kingLocation.Y)
                    return true;
            }
            return false;
        }

        // Checks if any given piece is in danger of being captured by an opponent
        public static bool IsInDanger(ChessBoard chessboard, ChessLocation pieceLocation)
        {
            ChessColor color = PIECE_COLOR_MAP[chessboard[pieceLocation]] == ChessColor.Black ? ChessColor.Black : ChessColor.White;
            ChessPiece dangerousPiece;

            //List<ChessMove> possibleDangerLocations = getLinearMoveLocations(chessboard, color, pieceLocation, false, false, true);
            List<ChessMove> possibleDangerLocations = MoveGenerator.getLinearMoves(chessboard, color, pieceLocation, false, true, false);
            foreach (ChessMove move in possibleDangerLocations)
            {
                dangerousPiece = chessboard[move.To];
                if (dangerousPiece == ChessPiece.BlackQueen || dangerousPiece == ChessPiece.WhiteQueen || dangerousPiece == ChessPiece.BlackBishop || dangerousPiece == ChessPiece.WhiteBishop)
                {
                    return true;
                }
            }

            //possibleDangerLocations = getLinearMoveLocations(chessboard, color, pieceLocation, true, true, false);
            possibleDangerLocations = MoveGenerator.getLinearMoves(chessboard, color, pieceLocation, true, false, false);
            foreach (ChessMove move in possibleDangerLocations)
            {
                dangerousPiece = chessboard[move.To];
                if (dangerousPiece == ChessPiece.BlackQueen || dangerousPiece == ChessPiece.WhiteQueen || dangerousPiece == ChessPiece.BlackRook || dangerousPiece == ChessPiece.WhiteRook)
                {
                    return true;
                }
            }

            possibleDangerLocations = MoveGenerator.getKnightMoves(chessboard, pieceLocation, color, false);
            foreach (ChessMove move in possibleDangerLocations)
            {
                dangerousPiece = chessboard[move.To];
                if (dangerousPiece == ChessPiece.BlackKnight || dangerousPiece == ChessPiece.WhiteKnight)
                {
                    return true;
                }
            }

            // check corners for pawn attacks
            if (color == ChessColor.Black)
            {
                if (MoveGenerator.inBounds(pieceLocation.X - 1, pieceLocation.Y + 1))
                {
                    // check bottom left and right for white pawns
                    if (chessboard[pieceLocation.X - 1, pieceLocation.Y + 1] == ChessPiece.WhitePawn)
                    {
                        return true;
                    }
                }

                if (MoveGenerator.inBounds(pieceLocation.X + 1, pieceLocation.Y + 1))
                {
                    // check bottom left and right for white pawns
                    if (chessboard[pieceLocation.X + 1, pieceLocation.Y + 1] == ChessPiece.WhitePawn)
                    {
                        return true;
                    }
                }
            }
            else
            {
                if (MoveGenerator.inBounds(pieceLocation.X - 1, pieceLocation.Y - 1))
                {
                    // check top left and right for white pawns
                    if (chessboard[pieceLocation.X - 1, pieceLocation.Y - 1] == ChessPiece.BlackPawn)
                    {
                        return true;
                    }
                }

                if (MoveGenerator.inBounds(pieceLocation.X + 1, pieceLocation.Y - 1))
                {
                    // check top left and right for white pawns
                    if (chessboard[pieceLocation.X + 1, pieceLocation.Y - 1] == ChessPiece.BlackPawn)
                    {
                        return true;
                    }
                }
            }

            possibleDangerLocations = MoveGenerator.getKingMoves(chessboard, pieceLocation, color, false);
            foreach (ChessMove move in possibleDangerLocations)
            {
                dangerousPiece = chessboard[move.To];
                if (dangerousPiece == ChessPiece.BlackKing || dangerousPiece == ChessPiece.WhiteKing)
                {
                    return true;
                }
            }

            return false;
        }

        // Checks if the current board has the king in check
        public static bool isInCheck(ChessBoard board, ChessLocation kingLocation)
        {
            bool isInCheck = false;

            if (Util.IsInDanger(board, kingLocation))
            {
                isInCheck = true;
            }

            return isInCheck;
        }
    }
}
