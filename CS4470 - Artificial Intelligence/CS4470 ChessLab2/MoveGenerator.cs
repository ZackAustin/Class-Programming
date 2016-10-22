using System;
using System.Collections.Generic;
using UvsChess;

namespace StudentAI
{
    public class MoveGenerator
    {
        private static readonly int WHITE_PAWN_START_Y = 6;
        private static readonly int WHITE_PAWN_JUMP_Y = 4;
        private static readonly int BLACK_PAWN_START_Y = 1;
        private static readonly int BLACK_PAWN_JUMP_Y = 3;       

        public static List<ChessMove> getAllMoves(ChessBoard currentBoard, ChessColor color, bool includeProtectionMoves)
        {
            List<ChessMove> validMoves = new List<ChessMove>();

            for (int row = 0; row < ChessBoard.NumberOfRows; row++)
            {
                for (int column = 0; column < ChessBoard.NumberOfColumns; column++)
                {
                    ChessPiece currentPiece = currentBoard[row, column];
                    if (currentPiece != ChessPiece.Empty && Util.PIECE_COLOR_MAP[currentPiece] == color)
                    {
                        List<ChessMove> moves = validMovesForPiece(currentBoard, currentPiece, new ChessLocation(row, column), includeProtectionMoves);
                        validMoves.AddRange(moves);
                    }
                }
            }

            return validMoves;
        }

        /// <summary>
        /// Takes our pseudo-legal move generator and gives the moves that don't place our king in check (that's illegal).
        /// </summary>
        /// <param name="boardBeforeMove">The board as it currently is before making the move.</param>
        /// <param name="playerColor">Color of player we'll generate legal moves for.</param>
        /// <returns>Returns a List of legal moves which is a sublist of our MoveGenerator.</returns>
        public static List<ChessMove> getAllLegalMoves(ChessBoard boardBeforeMove, List<ChessMove> pseudoLegalMoves, ChessColor playerColor)
        {
            List<ChessMove> legalMoves = new List<ChessMove>();
            ChessColor oppColor;
            if (playerColor == ChessColor.White)
                oppColor = ChessColor.Black;
            else oppColor = ChessColor.White;

            for (int i = 0; i < pseudoLegalMoves.Count; i++)
            {
                //setup a board testing one of our generated moves.
                ChessBoard boardAfterSemiLegalMove = boardBeforeMove.Clone();
                boardAfterSemiLegalMove.MakeMove(pseudoLegalMoves[i]);

                //find where our king is after that move.
                ChessLocation king = Util.getKingLocation(boardAfterSemiLegalMove, playerColor);

                //find all opponents moves to our move.
                List<ChessMove> oppMoves = MoveGenerator.getAllMoves(boardAfterSemiLegalMove, oppColor, false);

                //See if ANY of those moves has put us in check. If none put us in check, we've found a legal move.
                bool kingInCheck = false;
                for (int j = 0; j < oppMoves.Count; j++)
                {
                    if (oppMoves[j].To.X == king.X && oppMoves[j].To.Y == king.Y)
                    {
                        kingInCheck = true;
                    }
                }
                if (kingInCheck == false)
                    legalMoves.Add(pseudoLegalMoves[i]);
            }
            return legalMoves;
        }

        public static List<ChessMove> validMovesForPiece(ChessBoard currentBoard, ChessPiece piece, ChessLocation chessLocation, bool includeProtectionMoves)
        {
            List<ChessMove> validMoves = new List<ChessMove>();
            if (piece == ChessPiece.WhitePawn)
            {
                validMoves = getWhitePawnMoves(currentBoard, chessLocation, Util.PIECE_COLOR_MAP[piece], includeProtectionMoves);
            }
            else if (piece == ChessPiece.BlackPawn)
            {
                validMoves = getBlackPawnMoves(currentBoard, chessLocation, Util.PIECE_COLOR_MAP[piece], includeProtectionMoves);
            }
            else if (piece == ChessPiece.WhiteRook || piece == ChessPiece.BlackRook)
            {
                validMoves = getRookMoves(currentBoard, chessLocation, Util.PIECE_COLOR_MAP[piece], includeProtectionMoves);
            }
            else if (piece == ChessPiece.WhiteKnight || piece == ChessPiece.BlackKnight)
            {
                validMoves = getKnightMoves(currentBoard, chessLocation, Util.PIECE_COLOR_MAP[piece], includeProtectionMoves);
            }
            else if (piece == ChessPiece.WhiteBishop || piece == ChessPiece.BlackBishop)
            {
                validMoves = getBishopMoves(currentBoard, chessLocation, Util.PIECE_COLOR_MAP[piece], includeProtectionMoves);
            }
            else if (piece == ChessPiece.WhiteQueen || piece == ChessPiece.BlackQueen)
            {
                validMoves = getQueenMoves(currentBoard, chessLocation, Util.PIECE_COLOR_MAP[piece], includeProtectionMoves);
            }
            else if (piece == ChessPiece.WhiteKing || piece == ChessPiece.BlackKing)
            {
                validMoves = getKingMoves(currentBoard, chessLocation, Util.PIECE_COLOR_MAP[piece], includeProtectionMoves);
            }
            return validMoves;
        }

        private static List<ChessMove> getWhitePawnMoves(ChessBoard currentBoard, ChessLocation chessLocation, ChessColor mycolor, bool includeProtectionMoves)
        {
            List<ChessMove> whitePawnMoves = new List<ChessMove>();
            ChessLocation possibleLocation;

            // If pawn is at starting position, then can move two spaces forward if there isn't another piece there
            if (chessLocation.Y == WHITE_PAWN_START_Y)
            {
                possibleLocation = new ChessLocation(chessLocation.X, WHITE_PAWN_JUMP_Y);
                if (spaceIsEmpty(currentBoard, possibleLocation.X, WHITE_PAWN_JUMP_Y + 1) && spaceIsEmpty(currentBoard, possibleLocation.X, possibleLocation.Y))
                {
                    whitePawnMoves.Add(new ChessMove(chessLocation, possibleLocation));
                }
            }

            // If there is not another piece in the way, then the pawn can move one space forward
            possibleLocation = new ChessLocation(chessLocation.X, chessLocation.Y - 1);
            if (currentBoard[possibleLocation.X, possibleLocation.Y] == ChessPiece.Empty)
            {
                whitePawnMoves.Add(new ChessMove(chessLocation, possibleLocation));
            }

            // If there is an opposing piece on a forward diagonal, then that piece may be taken
            possibleLocation = new ChessLocation(chessLocation.X + 1, chessLocation.Y - 1);
            if (inBounds(possibleLocation.X, possibleLocation.Y) && isEnemy(currentBoard, possibleLocation, mycolor))
            {
                whitePawnMoves.Add(new ChessMove(chessLocation, possibleLocation));
            }
            possibleLocation = new ChessLocation(chessLocation.X - 1, chessLocation.Y - 1);
            if (inBounds(possibleLocation.X, possibleLocation.Y) && isEnemy(currentBoard, possibleLocation, mycolor))
            {
                whitePawnMoves.Add(new ChessMove(chessLocation, possibleLocation));
            }
            
            // Include moves that protect our pieces
            if (includeProtectionMoves)
            {
                possibleLocation = new ChessLocation(chessLocation.X + 1, chessLocation.Y - 1);
                if (inBounds(possibleLocation.X, possibleLocation.Y) && isFriendly(currentBoard, possibleLocation, mycolor))
                {
                    whitePawnMoves.Add(new ChessMove(chessLocation, possibleLocation));
                }
                possibleLocation = new ChessLocation(chessLocation.X - 1, chessLocation.Y - 1);
                if (inBounds(possibleLocation.X, possibleLocation.Y) && isFriendly(currentBoard, possibleLocation, mycolor))
                {
                    whitePawnMoves.Add(new ChessMove(chessLocation, possibleLocation));
                }
            }

            return whitePawnMoves;
        }

        private static List<ChessMove> getBlackPawnMoves(ChessBoard currentBoard, ChessLocation chessLocation, ChessColor mycolor, bool includeProtectionMoves)
        {
            List<ChessMove> blackPawnMoves = new List<ChessMove>();
            ChessLocation possibleLocation;

            // If pawn is at starting position, then can move two spaces forward if there isn't another piece there
            if (chessLocation.Y == BLACK_PAWN_START_Y)
            {
                possibleLocation = new ChessLocation(chessLocation.X, BLACK_PAWN_JUMP_Y);
                if (spaceIsEmpty(currentBoard, possibleLocation.X, BLACK_PAWN_JUMP_Y - 1) && spaceIsEmpty(currentBoard, possibleLocation.X, possibleLocation.Y))
                {
                    blackPawnMoves.Add(new ChessMove(chessLocation, possibleLocation));
                }
            }

            // If there is not another piece in the way, then the pawn can move one space forward
            possibleLocation = new ChessLocation(chessLocation.X, chessLocation.Y + 1);
            if (currentBoard[possibleLocation.X, possibleLocation.Y] == ChessPiece.Empty)
            {
                blackPawnMoves.Add(new ChessMove(chessLocation, possibleLocation));
            }

            //If there is an opposing piece on a forward diagonal, then that piece may be taken
            possibleLocation = new ChessLocation(chessLocation.X + 1, chessLocation.Y + 1);
            if (inBounds(possibleLocation.X, possibleLocation.Y) && isEnemy(currentBoard, possibleLocation, mycolor))
            {
                blackPawnMoves.Add(new ChessMove(chessLocation, possibleLocation));
            }
            possibleLocation = new ChessLocation(chessLocation.X - 1, chessLocation.Y + 1);
            if (inBounds(possibleLocation.X, possibleLocation.Y) && isEnemy(currentBoard, possibleLocation, mycolor))
            {
                blackPawnMoves.Add(new ChessMove(chessLocation, possibleLocation));
            }

            // Include moves that protect our pieces
            if (includeProtectionMoves)
            {
                possibleLocation = new ChessLocation(chessLocation.X + 1, chessLocation.Y + 1);
                if (inBounds(possibleLocation.X, possibleLocation.Y) && isFriendly(currentBoard, possibleLocation, mycolor))
                {
                    blackPawnMoves.Add(new ChessMove(chessLocation, possibleLocation));
                }
                possibleLocation = new ChessLocation(chessLocation.X - 1, chessLocation.Y + 1);
                if (inBounds(possibleLocation.X, possibleLocation.Y) && isFriendly(currentBoard, possibleLocation, mycolor))
                {
                    blackPawnMoves.Add(new ChessMove(chessLocation, possibleLocation));
                }
            }

            return blackPawnMoves;
        }

        public static List<ChessMove> getKnightMoves(ChessBoard currentBoard, ChessLocation chessLocation, ChessColor mycolor, bool includeProtectionMoves)
        {
            List<ChessMove> validKnightMoves = new List<ChessMove>();
            List<ChessLocation> allKnightDestinations = new List<ChessLocation>();

            // All knights can move up to eight ways
            allKnightDestinations.Add(new ChessLocation(chessLocation.X - 1, chessLocation.Y - 2));
            allKnightDestinations.Add(new ChessLocation(chessLocation.X - 2, chessLocation.Y - 1));
            allKnightDestinations.Add(new ChessLocation(chessLocation.X - 1, chessLocation.Y + 2));
            allKnightDestinations.Add(new ChessLocation(chessLocation.X - 2, chessLocation.Y + 1));
            allKnightDestinations.Add(new ChessLocation(chessLocation.X + 1, chessLocation.Y - 2));
            allKnightDestinations.Add(new ChessLocation(chessLocation.X + 2, chessLocation.Y - 1));
            allKnightDestinations.Add(new ChessLocation(chessLocation.X + 1, chessLocation.Y + 2));
            allKnightDestinations.Add(new ChessLocation(chessLocation.X + 2, chessLocation.Y + 1));

            foreach (ChessLocation endPosition in allKnightDestinations)
            {
                if (inBounds(endPosition.X, endPosition.Y))
                {
                    if (spaceIsEmpty(currentBoard, endPosition.X, endPosition.Y))
                    {
                        validKnightMoves.Add(new ChessMove(chessLocation, endPosition));
                    }
                    else
                    {
                        if (isEnemy(currentBoard, endPosition, mycolor))
                        {
                            validKnightMoves.Add(new ChessMove(chessLocation, endPosition));
                        }
                        else if (includeProtectionMoves && isFriendly(currentBoard, endPosition, mycolor))
                        {
                            validKnightMoves.Add(new ChessMove(chessLocation, endPosition));
                        }
                    }
                }
            }

            return validKnightMoves;
        }

        private static List<ChessMove> getRookMoves(ChessBoard currentBoard, ChessLocation chessLocation, ChessColor mycolor, bool includeProtectionMoves)
        {
            return getLinearMoves(currentBoard, mycolor, chessLocation, true, false, includeProtectionMoves);
        }

        private static List<ChessMove> getBishopMoves(ChessBoard currentBoard, ChessLocation chessLocation, ChessColor mycolor, bool includeProtectionMoves)
        {
            return getLinearMoves(currentBoard, mycolor, chessLocation, false, true, includeProtectionMoves);
        }

        private static List<ChessMove> getQueenMoves(ChessBoard currentBoard, ChessLocation chessLocation, ChessColor mycolor, bool includeProtectionMoves)
        {
            return getLinearMoves(currentBoard, mycolor, chessLocation, true, true, includeProtectionMoves);
        }

        public static List<ChessMove> getKingMoves(ChessBoard currentBoard, ChessLocation chessLocation, ChessColor mycolor, bool includeProtectionMoves)
        {
            List<ChessMove> validkingMoves = new List<ChessMove>();
            List<ChessLocation> allKingDestinations = new List<ChessLocation>();

            // Kings can move up to eight ways
            allKingDestinations.Add(new ChessLocation(chessLocation.X - 1, chessLocation.Y - 1));
            allKingDestinations.Add(new ChessLocation(chessLocation.X, chessLocation.Y - 1));
            allKingDestinations.Add(new ChessLocation(chessLocation.X + 1, chessLocation.Y - 1));
            allKingDestinations.Add(new ChessLocation(chessLocation.X - 1, chessLocation.Y));
            allKingDestinations.Add(new ChessLocation(chessLocation.X + 1, chessLocation.Y));
            allKingDestinations.Add(new ChessLocation(chessLocation.X - 1, chessLocation.Y + 1));
            allKingDestinations.Add(new ChessLocation(chessLocation.X, chessLocation.Y + 1));
            allKingDestinations.Add(new ChessLocation(chessLocation.X + 1, chessLocation.Y + 1));

            foreach (ChessLocation endPosition in allKingDestinations)
            {
                if (inBounds(endPosition.X, endPosition.Y))
                {
                    if (spaceIsEmpty(currentBoard, endPosition.X, endPosition.Y))
                    {
                        validkingMoves.Add(new ChessMove(chessLocation, endPosition));
                    }
                    else
                    {
                        if (isEnemy(currentBoard, endPosition, mycolor))
                        {
                            validkingMoves.Add(new ChessMove(chessLocation, endPosition));
                        }
                        else if (includeProtectionMoves && isFriendly(currentBoard, endPosition, mycolor))
                        {
                            validkingMoves.Add(new ChessMove(chessLocation, endPosition));
                        }
                    }
                }
            }

            return validkingMoves;
        }
        
        private static List<ChessMove> getMovetoEmpty(ChessBoard currentBoard, ChessMove Move, ChessColor mycolor)
        {
            List<ChessMove> MoveList = new List<ChessMove>();

            //left of empty
            for (int i = Move.From.X-1; i > 0; i--)
            {
                if(currentBoard[i,Move.From.Y] != ChessPiece.Empty)
                {
                    ChessLocation CL = new ChessLocation(i, Move.From.Y);
                    if(CL != Move.To)
                        MoveList.AddRange(MoveIntoEmpty(currentBoard, CL, Move.From, mycolor, false));
                    break;
                }
            }
            //right of empty
            for (int i = Move.From.X+1; i < ChessBoard.NumberOfColumns; i++)
            {
                if (currentBoard[i, Move.From.Y] != ChessPiece.Empty)
                {
                    ChessLocation CL = new ChessLocation(i, Move.From.Y);
                    if (CL != Move.To)
                        MoveList.AddRange(MoveIntoEmpty(currentBoard, CL, Move.From, mycolor, false));
                    break;
                }
            }
            //up of empty
            for (int i = Move.From.Y-1; i > 0; i--)
            {
                if (currentBoard[Move.From.X,i] != ChessPiece.Empty)
                {
                    ChessLocation CL = new ChessLocation(Move.From.X, i);
                    if (CL != Move.To)
                        MoveList.AddRange(MoveIntoEmpty(currentBoard, CL, Move.From, mycolor, false));
                    break;
                }
            }
            //down of empty
            for (int i = Move.From.Y+1; i < ChessBoard.NumberOfRows; i++)
            {
                if (currentBoard[Move.From.X, i] != ChessPiece.Empty)
                {
                    ChessLocation CL = new ChessLocation(Move.From.X, i);
                    if (CL != Move.To)
                        MoveList.AddRange(MoveIntoEmpty(currentBoard, CL, Move.From, mycolor, false));
                    break;
                }
            }

            //DiagonalLeftUp of empty
            for (int i = Move.From.X - 1, j = Move.From.Y - 1; i > 0 && j > 0; i--,j--)
            {
                if (currentBoard[i, j] != ChessPiece.Empty)
                {
                    ChessLocation CL = new ChessLocation(i, j);
                    if (CL != Move.To)
                        MoveList.AddRange(MoveIntoEmpty(currentBoard, CL, Move.From, mycolor, false));
                    break;
                }
            }
            //diagonalLeftDown
            for (int i = Move.From.X - 1, j = Move.From.Y + 1; i > 0 && j < ChessBoard.NumberOfRows; i--,j++)
            {
                if (currentBoard[i, j] != ChessPiece.Empty)
                {
                    ChessLocation CL = new ChessLocation(i, j);
                    if (CL != Move.To)
                        MoveList.AddRange(MoveIntoEmpty(currentBoard, CL, Move.From, mycolor, false));
                    break;
                }
            }
            //diagonalRightDown
            for (int i = Move.From.X + 1, j = Move.From.Y + 1; i < ChessBoard.NumberOfColumns && j < ChessBoard.NumberOfRows; i++, j++)
            {
                if (currentBoard[i, j] != ChessPiece.Empty)
                {
                    ChessLocation CL = new ChessLocation(i, j);
                    if (CL != Move.To)
                        MoveList.AddRange(MoveIntoEmpty(currentBoard, CL, Move.From, mycolor, false));
                    break;
                }
            }
            //diagonalRightUp
            for (int i = Move.From.X + 1, j = Move.From.Y - 1; i < ChessBoard.NumberOfColumns && j > 0; i++, j--)
            {
                if (currentBoard[i, j] != ChessPiece.Empty)
                {
                    ChessLocation CL = new ChessLocation(i, j);
                    if (CL != Move.To)
                        MoveList.AddRange(MoveIntoEmpty(currentBoard, CL, Move.From, mycolor, false));
                    break;
                }
            }

            //Knights
            List<ChessLocation> KnightSpots = new List<ChessLocation>();
            KnightSpots.Add(new ChessLocation(Move.From.X - 1, Move.From.Y - 2));
            KnightSpots.Add(new ChessLocation(Move.From.X - 2, Move.From.Y - 1));
            KnightSpots.Add(new ChessLocation(Move.From.X - 1, Move.From.Y + 2));
            KnightSpots.Add(new ChessLocation(Move.From.X - 2, Move.From.Y + 1));
            KnightSpots.Add(new ChessLocation(Move.From.X + 1, Move.From.Y - 2));
            KnightSpots.Add(new ChessLocation(Move.From.X + 2, Move.From.Y - 1));
            KnightSpots.Add(new ChessLocation(Move.From.X + 1, Move.From.Y + 2));
            KnightSpots.Add(new ChessLocation(Move.From.X + 2, Move.From.Y + 1));
            foreach (ChessLocation endPosition in KnightSpots)
            {
                if (inBounds(endPosition.X, endPosition.Y))
                {
                    ChessPiece CP = currentBoard[endPosition.X,endPosition.Y];
                    if(CP != ChessPiece.Empty && (CP == ChessPiece.WhiteKnight || CP == ChessPiece.BlackKnight))
                    {
                        if(Util.PIECE_COLOR_MAP[CP] == mycolor)
                        {
                            MoveList.Add(new ChessMove(new ChessLocation(endPosition.X,endPosition.Y), Move.From));
                        }
                    }
                }
            }

            return MoveList;
        }

        private static List<ChessMove> MoveIntoEmpty(ChessBoard currentBoard, ChessLocation from, ChessLocation to, ChessColor mycolor, bool includeProtectionMoves)
        {
            ChessPiece piece = currentBoard[from];
            List<ChessMove> Moves = new List<ChessMove>();
            if (piece == ChessPiece.WhitePawn && Util.PIECE_COLOR_MAP[piece] == mycolor)
            {
                Moves = getWhitePawnMoves(currentBoard, from, mycolor, includeProtectionMoves);
                foreach(ChessMove x in Moves)
                {
                    if (x.To == to)
                        return Moves;
                }
            }
            else if (piece == ChessPiece.BlackPawn && Util.PIECE_COLOR_MAP[piece] == mycolor)
            {
                Moves = getBlackPawnMoves(currentBoard, from, mycolor, includeProtectionMoves);
                foreach (ChessMove x in Moves)
                {
                    if (x.To == to)
                        return Moves;
                }
            }
            else if ((piece == ChessPiece.WhiteRook || piece == ChessPiece.BlackRook) && Util.PIECE_COLOR_MAP[piece] == mycolor)
            {
                Moves = getRookMoves(currentBoard, from, mycolor, includeProtectionMoves);
                foreach (ChessMove x in Moves)
                {
                    if (x.To == to)
                        return Moves;
                }
            }
            else if ((piece == ChessPiece.WhiteKnight || piece == ChessPiece.BlackKnight) && Util.PIECE_COLOR_MAP[piece] == mycolor) 
            {
                Moves = getKnightMoves(currentBoard, from, mycolor, includeProtectionMoves);
                foreach (ChessMove x in Moves)
                {
                    if (x.To == to)
                        return Moves;
                }
            }
            else if ((piece == ChessPiece.WhiteBishop || piece == ChessPiece.BlackBishop) && Util.PIECE_COLOR_MAP[piece] == mycolor)
            {
                Moves = getBishopMoves(currentBoard, from, mycolor, includeProtectionMoves);
                foreach (ChessMove x in Moves)
                {
                    if (x.To == to)
                        return Moves;
                }
            }
            else if ((piece == ChessPiece.WhiteQueen || piece == ChessPiece.BlackQueen) && Util.PIECE_COLOR_MAP[piece] == mycolor)
            {
                Moves = getQueenMoves(currentBoard, from, mycolor, includeProtectionMoves);
                foreach (ChessMove x in Moves)
                {
                    if (x.To == to)
                        return Moves;
                }
            }
            else if ((piece == ChessPiece.WhiteKing || piece == ChessPiece.BlackKing) && Util.PIECE_COLOR_MAP[piece] == mycolor)
            {
                Moves = getKingMoves(currentBoard, from, mycolor, includeProtectionMoves);
                foreach (ChessMove x in Moves)
                {
                    if (x.To == to)
                        return Moves;
                }
            }

            return new List<ChessMove>();
        }

        public static List<ChessMove> getNextDepthChanges(List<ChessMove> validMoves, ChessBoard board, ChessMove selectedMove, ChessColor mycolor)
        {
            
            ChessBoard Afterboard = board.Clone();
            Afterboard.MakeMove(selectedMove);

            //This adds the list of valid moves according to its "from" position
            //Makes it easier to remove moves from the list
            List<ChessMove> MoveList = new List<ChessMove>();
            MoveList.AddRange(validMoves);

            //Remove moves that are no longer valid.
            List<ChessMove> temp = new List<ChessMove>();
            MoveList.RemoveAll(item => item.From == selectedMove.From);
            foreach(ChessMove x in MoveList)
            {
                if(x.To == selectedMove.To)
                {
                    if(board[x.From] != ChessPiece.BlackKing && board[x.From] != ChessPiece.WhiteKing && board[x.From] != ChessPiece.BlackPawn && board[x.From] != ChessPiece.WhitePawn && board[x.From] != ChessPiece.BlackKnight && board[x.From] != ChessPiece.WhiteKnight)
                    {
                        temp.Add(x);
                    }
                }
            }
            foreach(ChessMove x in temp)
            {
                MoveList.RemoveAll(item => item.From == x.From);
            }
            MoveList.RemoveAll(item => item.To == selectedMove.To);


            //We have generated the first round of moves, we have selected a move, and want to generate the next set of moves from the piece we moved.
            MoveList.AddRange(MoveGenerator.validMovesForPiece(Afterboard, board[selectedMove.From.X, selectedMove.From.Y], selectedMove.To, false));

            //Generate moves for any piece who should of been able to move into this space before.
            MoveList.AddRange(MoveGenerator.getMovetoEmpty(Afterboard, selectedMove, mycolor));

            return MoveList;
        }

        private static bool spaceIsEmpty(ChessBoard currentBoard, int x, int y)
        {
            return currentBoard[x, y] == ChessPiece.Empty;
        }

        public static bool isEnemy(ChessBoard currentBoard, ChessLocation location, ChessColor myColor)
        {
            if (spaceIsEmpty(currentBoard, location.X, location.Y))
            {
                return false;
            }
            if (Util.PIECE_COLOR_MAP[currentBoard[location.X, location.Y]] == myColor)
            {
                return false;
            }
            return true;
        }

        public static bool isFriendly(ChessBoard currentBoard, ChessLocation location, ChessColor myColor)
        {
            if (spaceIsEmpty(currentBoard, location.X, location.Y))
            {
                return false;
            }
            if (Util.PIECE_COLOR_MAP[currentBoard[location.X, location.Y]] != myColor)
            {
                return false;
            }
            return true;
        }

        public static bool inBounds(int x, int y)
        {
            if (x < 0 || x >= ChessBoard.NumberOfColumns)
            {
                return false;
            }
            if (y < 0 || y >= ChessBoard.NumberOfRows)
            {
                return false;
            }
            return true;
        }

        public static List<ChessMove> getLinearMoves(ChessBoard chessBoard, ChessColor mycolor, ChessLocation chessLocation, bool straight, bool diagonals, bool includeProtectionMoves)
        {
            List<ChessMove> validFutureLocations = new List<ChessMove>();
            int verticalIndex;
            int horizontalIndex = chessLocation.X;

            if (straight)
            {
                // Down
                verticalIndex = chessLocation.Y + 1;
                while (inBounds(horizontalIndex, verticalIndex))
                {
                    if (!addPossibleMove(chessBoard, mycolor, chessLocation, chessLocation.X, verticalIndex, validFutureLocations, includeProtectionMoves))
                    {
                        break;
                    }
                    verticalIndex++;
                }

                // Up
                verticalIndex = chessLocation.Y - 1;
                while (inBounds(horizontalIndex, verticalIndex))
                {
                    if (!addPossibleMove(chessBoard, mycolor, chessLocation, chessLocation.X, verticalIndex, validFutureLocations, includeProtectionMoves))
                    {
                        break;
                    }
                    verticalIndex--;
                }

                // Right
                horizontalIndex = chessLocation.X + 1;
                verticalIndex = chessLocation.Y;
                while (inBounds(horizontalIndex, verticalIndex))
                {
                    if (!addPossibleMove(chessBoard, mycolor, chessLocation, horizontalIndex, chessLocation.Y, validFutureLocations, includeProtectionMoves))
                    {
                        break;
                    }
                    horizontalIndex++;
                }

                // Left
                horizontalIndex = chessLocation.X - 1;
                while (inBounds(horizontalIndex, verticalIndex))
                {
                    if (!addPossibleMove(chessBoard, mycolor, chessLocation, horizontalIndex, chessLocation.Y, validFutureLocations, includeProtectionMoves))
                    {
                        break;
                    }
                    horizontalIndex--;
                }
            }

            if (diagonals)
            {
                // Positive diagonal ascending
                horizontalIndex = chessLocation.X + 1;
                verticalIndex = chessLocation.Y - 1;
                while (inBounds(horizontalIndex, verticalIndex))
                {
                    if (!addPossibleMove(chessBoard, mycolor, chessLocation, horizontalIndex, verticalIndex, validFutureLocations, includeProtectionMoves))
                    {
                        break;
                    }
                    horizontalIndex++;
                    verticalIndex--;
                }

                // Positive diagonal descending
                horizontalIndex = chessLocation.X - 1;
                verticalIndex = chessLocation.Y + 1;
                while (inBounds(horizontalIndex, verticalIndex))
                {
                    if (!addPossibleMove(chessBoard, mycolor, chessLocation, horizontalIndex, verticalIndex, validFutureLocations, includeProtectionMoves))
                    {
                        break;
                    }
                    horizontalIndex--;
                    verticalIndex++;
                }

                // Negative diagonal ascending
                horizontalIndex = chessLocation.X - 1;
                verticalIndex = chessLocation.Y - 1;
                while (inBounds(horizontalIndex, verticalIndex))
                {
                    if (!addPossibleMove(chessBoard, mycolor, chessLocation, horizontalIndex, verticalIndex, validFutureLocations, includeProtectionMoves))
                    {
                        break;
                    }
                    horizontalIndex--;
                    verticalIndex--;
                }

                // Negative diagonal descending
                horizontalIndex = chessLocation.X + 1;
                verticalIndex = chessLocation.Y + 1;
                while (inBounds(horizontalIndex, verticalIndex))
                {
                    if (!addPossibleMove(chessBoard, mycolor, chessLocation, horizontalIndex, verticalIndex, validFutureLocations, includeProtectionMoves))
                    {
                        break;
                    }
                    horizontalIndex++;
                    verticalIndex++;
                }
            }

            return validFutureLocations;
        }

        // If destination is an empty space, add the move to the list and returns true 
        // If destination is an enemy, adds the move to the list and return false
        // If destination is a friendly, don't add the move to the list and returns false
        // If destination is a friendly and includeProtectionMoves is true, add the move to the list and returns false
        private static bool addPossibleMove(ChessBoard chessBoard, ChessColor mycolor, ChessLocation origin, int destinationX, int destinationY, List<ChessMove> validMoves, bool includeProtectionMoves)
        {
            bool retVal = false;
            if (chessBoard[destinationX, destinationY] == ChessPiece.Empty)
            {
                validMoves.Add(new ChessMove(origin, new ChessLocation(destinationX, destinationY)));
                retVal = true;
            }
            else if (isEnemy(chessBoard, new ChessLocation(destinationX, destinationY), mycolor))
            {
                validMoves.Add(new ChessMove(origin, new ChessLocation(destinationX, destinationY)));
                retVal = false;
            }
            else if (includeProtectionMoves && isFriendly(chessBoard, new ChessLocation(destinationX, destinationY), mycolor))
            {
                validMoves.Add(new ChessMove(origin, new ChessLocation(destinationX, destinationY)));
                retVal = false;
            }

            return retVal;
        }
    }
}
