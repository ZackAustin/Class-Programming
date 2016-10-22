using System;
using System.Collections.Generic;
using System.Text;
using UvsChess;

namespace StudentAI
{
    public class StudentAI : IChessAI
    {
        #region IChessAI Members that are implemented by the Student
        public static DecisionTree DT;

        /// <summary>
        /// The name of your AI
        /// </summary>
        public string Name
        {
#if DEBUG
            get { return "WhateverAI minimax (Debug)"; }
#else
            get { return "WhateverAI minimax"; }
#endif
        }

        /// <summary>
        /// Evaluates the chess board and decided which move to make. This is the main method of the AI.
        /// The framework will call this method when it's your turn.
        /// </summary>
        /// <param name="board">Current chess board</param>
        /// <param name="yourColor">Your color</param>
        /// <returns> Returns the best chess move the player has for the given chess board</returns>
        public ChessMove GetNextMove(ChessBoard board, ChessColor myColor)
        {
#if DEBUG
            // Create a new decision tree object using the current board
            DT = new DecisionTree(board);

            // Tell UvsChess about the decision tree object
            SetDecisionTree(DT);
#endif      

            List<ChessMove> validMoves = MoveGenerator.getAllMoves(board, myColor, false);
            List<ChessMove> legalMoves = MoveGenerator.getAllLegalMoves(board, validMoves, myColor);

            ChessMove selectedMove = null;

            Func<bool> turnOverFunction = () => IsMyTurnOver();

            selectedMove = minimax.minimaxValue(DT, board, myColor, turnOverFunction);

            DT.BestChildMove = selectedMove;
            return selectedMove;
        }

        /// <summary>
        /// Validates a move. The framework uses this to validate the opponents move.
        /// </summary>
        /// <param name="boardBeforeMove">The board as it currently is _before_ the move.</param>
        /// <param name="moveToCheck">This is the move that needs to be checked to see if it's valid.</param>
        /// <param name="colorOfPlayerMoving">This is the color of the player who's making the move.</param>
        /// <returns>Returns true if the move was valid</returns>
        public bool IsValidMove(ChessBoard boardBeforeMove, ChessMove moveToCheck, ChessColor colorOfPlayerMoving)
        {
            bool validSoFar = false;
            ChessLocation king;
            ChessColor ourColor;
            if (colorOfPlayerMoving == ChessColor.White)
                ourColor = ChessColor.Black;
            else ourColor = ChessColor.White;

            //See if the move they gave us is in the list of legal moves.
            List<ChessMove> ourOppsPseudoMoves = MoveGenerator.getAllMoves(boardBeforeMove, colorOfPlayerMoving, false);
            List<ChessMove> ourOppsMoves = MoveGenerator.getAllLegalMoves(boardBeforeMove, ourOppsPseudoMoves, colorOfPlayerMoving);

            for (int i = 0; i < ourOppsMoves.Count; i++)
            {
                if ((ourOppsMoves[i].From.X == moveToCheck.From.X && ourOppsMoves[i].From.Y == moveToCheck.From.Y) && (ourOppsMoves[i].To.X == moveToCheck.To.X && ourOppsMoves[i].To.Y == moveToCheck.To.Y))
                    validSoFar = true;
            }

            //We also need the board afterwards for checking Checkmates/Stalemates.
            ChessBoard boardAfterMove = boardBeforeMove.Clone();
            boardAfterMove.MakeMove(moveToCheck);

            //get king's location for color of player who's validating the move.
            if (colorOfPlayerMoving == ChessColor.White)
                king = Util.getKingLocation(boardAfterMove, ChessColor.Black);
            else king = Util.getKingLocation(boardAfterMove, ChessColor.White);

            //get a copy of their move with no flag set for testing.
            ChessMove flagTestingCopy = moveToCheck.Clone();
            flagTestingCopy.Flag = ChessFlag.NoFlag;

            //Try setting flag's for the copy.
            Util.setCheckFlagForMove(boardBeforeMove, flagTestingCopy, king, colorOfPlayerMoving);
            Util.setCheckmateFlagForMove(boardAfterMove, flagTestingCopy, ourColor);
            Util.setStalemateFlagForMove(boardAfterMove, flagTestingCopy, ourColor);

            //See if it is the same flag as the move we're checking.
            if (flagTestingCopy.Flag != moveToCheck.Flag)
                validSoFar = false;

            return validSoFar;
        }

        #endregion

        #region IChessAI Members that should be implemented as automatic properties and should NEVER be touched by students.
        /// <summary>
        /// This will return false when the framework starts running your AI. When the AI's time has run out,
        /// then this method will return true. Once this method returns true, your AI should return a 
        /// move immediately.
        /// 
        /// You should NEVER EVER set this property!
        /// This property should be defined as an Automatic Property.
        /// This property SHOULD NOT CONTAIN ANY CODE!!!
        /// </summary>
        public AIIsMyTurnOverCallback IsMyTurnOver { get; set; }

        /// <summary>
        /// Call this method to print out debug information. The framework subscribes to this event
        /// and will provide a log window for your debug messages.
        /// 
        /// You should NEVER EVER set this property!
        /// This property should be defined as an Automatic Property.
        /// This property SHOULD NOT CONTAIN ANY CODE!!!
        /// </summary>
        /// <param name="message"></param>
        public AILoggerCallback Log { get; set; }

        /// <summary>
        /// Call this method to catch profiling information. The framework subscribes to this event
        /// and will print out the profiling stats in your log window.
        /// 
        /// You should NEVER EVER set this property!
        /// This property should be defined as an Automatic Property.
        /// This property SHOULD NOT CONTAIN ANY CODE!!!
        /// </summary>
        /// <param name="key"></param>
        public AIProfiler Profiler { get; set; }

        /// <summary>
        /// Call this method to tell the framework what decision print out debug information. The framework subscribes to this event
        /// and will provide a debug window for your decision tree.
        /// 
        /// You should NEVER EVER set this property!
        /// This property should be defined as an Automatic Property.
        /// This property SHOULD NOT CONTAIN ANY CODE!!!
        /// </summary>
        /// <param name="message"></param>
        public AISetDecisionTreeCallback SetDecisionTree { get; set; }
        #endregion
    }
}
