using UvsChess;

namespace StudentAI
{
    class HeuristicService
    {
        public enum HEURISTIC_TYPE
        {
            DEFAULT,
            GREEDY
        }

        public static HEURISTIC_TYPE getRecommendedHeuristic(ChessBoard board, ChessColor color)
        {
            return HEURISTIC_TYPE.DEFAULT;
        }

        public static int getHeuristicValue(ChessBoard board, ChessColor color, HEURISTIC_TYPE type)
        {
            int value;

            // When we have more heuristics to choose from, then we can add some if statements
            switch (type)
            {
                case HEURISTIC_TYPE.GREEDY:
                    value = Heuristic_Greedy.GetHeuristicValue(board, color);
                    break;
                default:
                    value = Heuristic_Default.GetHeuristicValue(board, color);
                    break;
            }
            return value;
            
        }
    }
}
