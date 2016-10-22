using System;
using System.Collections.Generic;
using UvsChess;
using System.Text;

namespace StudentAI
{
    class Zack_minimax
    {
        const int MAX_SEARCH_DEPTH = 2;
        static Func<bool> turnOver;

        public static ChessMove minimax(ChessBoard board, ChessColor myColor, Func<bool> isMyTurnOver)
        {
            turnOver = isMyTurnOver;
            return max(board, myColor, 1, -9999, 9999);
        }

        public static ChessMove max(ChessBoard board, ChessColor myColor, int depth, int alpha, int beta)
        {
            Random rand = new Random();
            bool depthCutoff = false;
            List<ChessMove> HighCostList = new List<ChessMove>();
            int HighestCost = -999;

            //Get the opponents color
            ChessColor oppColor;
            if (myColor == ChessColor.White)
                oppColor = ChessColor.Black;
            else
                oppColor = ChessColor.White;

            List<ChessMove> validMovesThisTurn = MoveGenerator.getAllMoves(board, myColor, false);
            List<ChessMove> legalMovesThisTurn = MoveGenerator.getAllLegalMoves(board, validMovesThisTurn, myColor);

            foreach (ChessMove ourMove in legalMovesThisTurn)
            {
                if (!turnOver())
                {
                    depthCutoff = false;
                    ChessBoard boardAfterMove = board.Clone();
                    boardAfterMove.MakeMove(ourMove);

                    //Where is their king?
                    ChessLocation king;
                    if (myColor == ChessColor.White)
                        king = Util.getKingLocation(boardAfterMove, ChessColor.Black);
                    else
                        king = Util.getKingLocation(boardAfterMove, ChessColor.White);

                    //Check for valid check flag on their king, then check if we checkmate/stalemate the opponent
                    Util.setCheckFlagForMove(board, ourMove, king, myColor);
                    Util.setCheckmateFlagForMove(boardAfterMove, ourMove, oppColor);
                    Util.setStalemateFlagForMove(boardAfterMove, ourMove, oppColor);

                    ////Piece Cost & checks
                    //if (depth == 1)
                    //{
                    //    ChessPiece CP = board[ourMove.From];
                    //    if (CP == ChessPiece.WhitePawn)
                    //        ourMove.ValueOfMove += 1;
                    //    else if (CP == ChessPiece.BlackPawn)
                    //        ourMove.ValueOfMove += 1;

                    //    if (ourMove.Flag == ChessFlag.Check)
                    //        ourMove.ValueOfMove += 1;
                    //}

                    if (ourMove.Flag == ChessFlag.Checkmate)
                    {
                        ourMove.ValueOfMove += 1000;
                        //Terminal Cutoff -- Checkmate
                        return ourMove;
                    }
                    else if (ourMove.Flag == ChessFlag.Stalemate)
                    {
                        ourMove.ValueOfMove -= 1000;
                        //Depth Cutoff -- Stalemate
                        depthCutoff = true;
                    }

                    if (depth < MAX_SEARCH_DEPTH && depthCutoff == false)
                    {
                        ourMove.ValueOfMove = min(boardAfterMove, oppColor, depth + 1, alpha, beta, ourMove).ValueOfMove;
                    }

                    if (depth == MAX_SEARCH_DEPTH) //Successor Function -- Heuristic Eval
                    {                        
                        ourMove.ValueOfMove = HeuristService.getHeuristicValue(boardAfterMove, myColor, HeuristService.HEURISTIC_TYPE.DEFAULT);
                    }                    
                    
                    //v = max(minValue(s,A,B), v)
                    if (ourMove.ValueOfMove > HighestCost)
                    {
                        HighCostList.Clear();
                        HighestCost = ourMove.ValueOfMove;
                        HighCostList.Add(ourMove);

                        //HighestCost is v.
                        //if v >= beta return v, v is ourMove value.
                        if (HighestCost > beta)
                            return ourMove;

                        //A = max(A,v)
                        if (alpha < HighestCost)
                            alpha = HighestCost;
                    }
                    else if (ourMove.ValueOfMove == HighestCost) //if equal to cost add to list of moves
                    {
                        HighCostList.Add(ourMove);
                        //HighestCost is v.
                        //if v >= beta return v, v is ourMove value.
                        if (HighestCost > beta)
                            return ourMove;

                        //A = max(A,v)
                        if (alpha < HighestCost)
                            alpha = HighestCost;
                    }
                }
            }
            if (HighCostList.Count > 0)
                return HighCostList[rand.Next(0, HighCostList.Count)];
            else return legalMovesThisTurn[rand.Next(0, legalMovesThisTurn.Count)];
        }

        public static ChessMove min(ChessBoard board, ChessColor myColor, int depth, int alpha, int beta, ChessMove ourOppMove)
        {
            Random rand = new Random();
            bool depthCutoff = false;
            List<ChessMove> LowCostList = new List<ChessMove>();
            int LowestCost = 999;

            //Get the opponents color
            ChessColor oppColor;
            if (myColor == ChessColor.White)
                oppColor = ChessColor.Black;
            else
                oppColor = ChessColor.White;

            List<ChessMove> validMovesThisTurn = MoveGenerator.getAllMoves(board, myColor, false);
            List<ChessMove> legalMovesThisTurn = MoveGenerator.getAllLegalMoves(board, validMovesThisTurn, myColor);

            foreach (ChessMove ourMove in legalMovesThisTurn)
            {
                if (!turnOver())
                {
                    depthCutoff = false;
                    ChessBoard boardAfterMove = board.Clone();
                    boardAfterMove.MakeMove(ourMove);

                    //Where is their king?
                    ChessLocation king;
                    if (myColor == ChessColor.White)
                        king = Util.getKingLocation(boardAfterMove, ChessColor.Black);
                    else
                        king = Util.getKingLocation(boardAfterMove, ChessColor.White);

                    //Check for valid check flag on their king, then check if we checkmate/stalemate the opponent
                    Util.setCheckFlagForMove(board, ourMove, king, myColor);
                    Util.setCheckmateFlagForMove(boardAfterMove, ourMove, oppColor);
                    Util.setStalemateFlagForMove(boardAfterMove, ourMove, oppColor);

                    if (ourMove.Flag == ChessFlag.Checkmate)
                    {
                        ourMove.ValueOfMove -= 1000;
                        //Terminal Cutoff -- Checkmate
                        return ourMove;
                    }
                    else if (ourMove.Flag == ChessFlag.Stalemate)
                    {
                        ourMove.ValueOfMove -= 1000;
                        //Depth Cutoff -- Stalemate
                        depthCutoff = true;
                    }

                    if (depth < MAX_SEARCH_DEPTH && depthCutoff == false)
                        ourMove.ValueOfMove = max(boardAfterMove, oppColor, depth + 1, alpha, beta).ValueOfMove;

                    if (depth == MAX_SEARCH_DEPTH) //Successor Function -- Heuristic Eval
                    {
                        //if (ourMove.Flag == ChessFlag.Check)
                        //    ourMove.ValueOfMove -= 1;

                        ourMove.ValueOfMove = HeuristService.getHeuristicValue(boardAfterMove, oppColor, HeuristService.HEURISTIC_TYPE.DEFAULT);
                    }

                    //v= min(maxValue(s,A,B), v)
                    if (ourMove.ValueOfMove < LowestCost)
                    {
                        LowCostList.Clear();
                        LowestCost = ourMove.ValueOfMove;
                        LowCostList.Add(ourMove);

                        //LowestCost is v.
                        //if v <= alpha return v, v is ourMove value.//broken
                        if (LowestCost < alpha)
                            return ourMove;

                        //B = min(B,v)
                        if (beta > LowestCost)
                            beta = LowestCost;
                    }
                    else if (ourMove.ValueOfMove == LowestCost) //if equal to cost add to list of moves
                    {
                        LowCostList.Add(ourMove);
                        //LowestCost is v.
                        //if v <= alpha return v, v is ourMove value.
                        if (LowestCost < alpha)
                            return ourMove;

                        //B = min(B,v)
                        if (beta > LowestCost)
                            beta = LowestCost;
                    }
                }
            }
            if (LowCostList.Count > 0)
                return LowCostList[rand.Next(0, LowCostList.Count)];
            else return legalMovesThisTurn[rand.Next(0, legalMovesThisTurn.Count)];
        }
    }
}
