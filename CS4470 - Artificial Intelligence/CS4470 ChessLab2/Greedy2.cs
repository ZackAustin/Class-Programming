using System;
using System.Collections.Generic;
using StudentAI;
using UvsChess;

namespace StudentAI
{
    public class Greedy
    {
        const int pawnCost = 1, knightCost = 3, bishopCost = 3, rookCost = 5, queenCost = 9;

        /// <summary>
        /// Take all the legal moves the  color has, and pick the highest cost move.
        /// </summary>
        /// <param name="Moves"></param>List of moves that can be performed as the next move.
        /// <returns>
        /// Retuns a Move from List of Moves
        /// </returns>
        public static int greedyMove(ChessBoard board, List<ChessMove> Moves, ChessColor myColor)
        {
            Random rand = new Random();

            int i = 0;
            int HighestCost = 0;
            List<int> HighCostList = new List<int>();

            //Get the opponents color
            ChessColor oppColor;
            if (myColor == ChessColor.White)
                oppColor = ChessColor.Black;
            else
                oppColor = ChessColor.White;

            List<ChessMove> validMovesThisTurn = MoveGenerator.getAllValidMoves(board, oppColor);
            List<ChessMove> legalMovesThisTurn = MoveGenerator.getAllLegalMoves(board, validMovesThisTurn, oppColor);

            foreach (ChessMove Move in Moves)
            {
                int cost = 0;

                //Piece Cost
                ChessPiece CP = board[Move.From];
                //cost += ((int)CP) % 6; <--- Don't do this.
                if (CP == ChessPiece.WhitePawn)
                    cost += 1;// + 1;
                else if (CP == ChessPiece.BlackPawn)
                    cost += 1;// +1;

                //Move Cost or kill
                ChessPiece CP2 = board[Move.To];
                int KillCost = 0;
                if (CP2 != ChessPiece.Empty)
                {
                    if (CP2 == ChessPiece.BlackPawn || CP2 == ChessPiece.WhitePawn)
                        KillCost = pawnCost;
                    else if (CP2 == ChessPiece.BlackBishop || CP2 == ChessPiece.WhiteBishop)
                        KillCost = bishopCost;
                    else if (CP2 == ChessPiece.BlackKnight || CP2 == ChessPiece.WhiteKnight)
                        KillCost = knightCost;
                    else if (CP2 == ChessPiece.BlackRook || CP2 == ChessPiece.WhiteRook)
                        KillCost = rookCost;
                    else if (CP2 == ChessPiece.BlackQueen || CP2 == ChessPiece.WhiteQueen)
                        KillCost = queenCost;
                }
                else // blank space
                    KillCost = 0;
                cost += KillCost;

                //See if our piece is currently threatened.
                //List<ChessMove> validMovesThisTurn = MoveGenerator.getAllValidMoves(board, oppColor);
                //List<ChessMove> legalMovesThisTurn = MoveGenerator.getAllLegalMoves(board, validMovesThisTurn, oppColor);
                int oppCostThisTurn = 0;
                foreach (ChessMove oppMove in legalMovesThisTurn)
                {
                    //Move Protection
                    if (oppMove.To == Move.From)
                    {
                        ChessPiece CPOppThisTurn = board[oppMove.To];

                        //Will not doing a move allow an opponent to kill our piece, if so let's try to move.
                        if (CPOppThisTurn != ChessPiece.Empty)
                        {
                            if (CPOppThisTurn == ChessPiece.BlackPawn || CPOppThisTurn == ChessPiece.WhitePawn)
                                oppCostThisTurn = pawnCost;
                            else if (CPOppThisTurn == ChessPiece.BlackBishop || CPOppThisTurn == ChessPiece.WhiteBishop)
                                oppCostThisTurn = bishopCost;
                            else if (CPOppThisTurn == ChessPiece.BlackKnight || CPOppThisTurn == ChessPiece.WhiteKnight)
                                oppCostThisTurn = knightCost;
                            else if (CPOppThisTurn == ChessPiece.BlackRook || CPOppThisTurn == ChessPiece.WhiteRook)
                                oppCostThisTurn = rookCost;
                            else if (CPOppThisTurn == ChessPiece.BlackQueen || CPOppThisTurn == ChessPiece.WhiteQueen)
                                oppCostThisTurn = queenCost;
                        }
                        else // blank space
                            oppCostThisTurn = 0;
                    }
                }

                //A piece is threatened, let's move it if we can.
                cost += oppCostThisTurn;

                ChessBoard boardAfterMove = board.Clone();
                boardAfterMove.MakeMove(Move);

                //Where is our king?
                ChessLocation king;
                if (myColor == ChessColor.White)
                    king = Util.getKingLocation(boardAfterMove, ChessColor.Black);
                else
                    king = Util.getKingLocation(boardAfterMove, ChessColor.White);

                //Check for valid check flag on our king, then check if we checkmate/stalemate the opponent
                Util.setCheckFlagForMove(board, Move, king, myColor);
                Util.setCheckmateFlagForMove(boardAfterMove, Move, oppColor);
                Util.setStalemateFlagForMove(boardAfterMove, Move, oppColor);

                //if we can checkmate them do it
                if (Move.Flag == ChessFlag.Checkmate)
                {
                    cost += 100;
                }
                //Try to avoid stalemates
                else if (Move.Flag == ChessFlag.Stalemate)
                {
                    cost -= 100;
                }
                else //if not check their moves
                {
                    if (Move.Flag == ChessFlag.Check)
                    {
                        cost += 1;
                    }

                    //Checking Opponents possible moves
                    List<ChessMove> validMoves = MoveGenerator.getAllValidMoves(boardAfterMove, oppColor);
                    List<ChessMove> legalMoves = MoveGenerator.getAllLegalMoves(boardAfterMove, validMoves, oppColor);
                    int oppCost = 0;
                    foreach (ChessMove oppMove in legalMoves)
                    {
                        //Move Protection -- Our piece is threatened on their next turn.
                        if (oppMove.To == Move.To)
                        {
                            ChessPiece CPOpp = boardAfterMove[Move.To];

                            //Will our move allow an opponent to kill our piece we decided to move
                            if (CPOpp != ChessPiece.Empty)
                            {
                                if (CPOpp == ChessPiece.BlackPawn || CPOpp == ChessPiece.WhitePawn)
                                    oppCost = pawnCost;
                                else if (CPOpp == ChessPiece.BlackBishop || CPOpp == ChessPiece.WhiteBishop)
                                    oppCost = bishopCost;
                                else if (CPOpp == ChessPiece.BlackKnight || CPOpp == ChessPiece.WhiteKnight)
                                    oppCost = knightCost;
                                else if (CPOpp == ChessPiece.BlackRook || CPOpp == ChessPiece.WhiteRook)
                                    oppCost = rookCost;
                                else if (CPOpp == ChessPiece.BlackQueen || CPOpp == ChessPiece.WhiteQueen)
                                    oppCost = queenCost;
                            }
                            else // blank space
                                oppCost = 0;
                        }

                    }
                    //If so lets reduce the cost for that move (might still be a good move)
                    cost -= oppCost;
                }

                //if Highest replace the list of moves
                if (cost > HighestCost)
                {
                    HighCostList.Clear();
                    HighestCost = cost;
                    HighCostList.Add(i);
                }
                else if (cost == HighestCost) //if equal to cost add to list of moves
                {
                    HighCostList.Add(i);
                }

                i++;
            }

            //We apparently don't have any good moves, the piece we move will end up being killed. (most like our king)
            if (HighCostList.Count == 0)
                return rand.Next(0, Moves.Count);

            //Return a random move of equal cost that was considered our highest cost moves.
            return HighCostList[rand.Next(0, HighCostList.Count)];
        }
    }
}
