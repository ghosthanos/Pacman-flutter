class AStar {
  List<int> findPath(
      int start, int target, List<int> barriers, int numberInRow) {
    List<int> openSet = [start];
    List<int> closedSet = [];
    Map<int, int> cameFrom = {};
    Map<int, double> gScore = {start: 0};
    Map<int, double> fScore = {
      start: heuristic(start, target, numberInRow).toDouble()
    }; // Convert to double

    while (openSet.isNotEmpty) {
      int current = _getLowestFScore(openSet, fScore);

      if (current == target) {
        return _reconstructPath(cameFrom, target);
      }

      openSet.remove(current);
      closedSet.add(current);

      for (int neighbor in _getNeighbors(current, numberInRow, barriers)) {
        if (closedSet.contains(neighbor)) {
          continue;
        }

        double tentativeGScore = gScore[current]! + 1;

        if (!openSet.contains(neighbor) ||
            tentativeGScore < gScore[neighbor]!) {
          cameFrom[neighbor] = current;
          gScore[neighbor] = tentativeGScore;
          fScore[neighbor] =
              (gScore[neighbor]! + heuristic(neighbor, target, numberInRow))!;

          if (!openSet.contains(neighbor)) {
            openSet.add(neighbor);
          }
        }
      }
    }

    return []; // No path found
  }

  int heuristic(int a, int b, int numberInRow) {
    // Manhatten distance heuristic
    int aRow = a ~/ numberInRow;
    int aCol = a % numberInRow;
    int bRow = b ~/ numberInRow;
    int bCol = b % numberInRow;

    return (aRow - bRow).abs() + (aCol - bCol).abs();
  }

  int _getLowestFScore(List<int> openSet, Map<int, double> fScore) {
    return openSet.reduce((a, b) => fScore[a]! < fScore[b]! ? a : b);
  }

  List<int> _getNeighbors(int current, int numberInRow, List<int> barriers) {
    List<int> neighbors = [];
    int row = current ~/ numberInRow;
    int col = current % numberInRow;

    if (row > 0 && !barriers.contains(current - numberInRow)) {
      neighbors.add(current - numberInRow);
    }
    if (row < numberInRow - 1 && !barriers.contains(current + numberInRow)) {
      neighbors.add(current + numberInRow);
    }
    if (col > 0 && !barriers.contains(current - 1)) {
      neighbors.add(current - 1);
    }
    if (col < numberInRow - 1 && !barriers.contains(current + 1)) {
      neighbors.add(current + 1);
    }

    return neighbors;
  }

  List<int> _reconstructPath(Map<int, int> cameFrom, int current) {
    List<int> totalPath = [current];
    while (cameFrom.containsKey(current)) {
      current = cameFrom[current]!;
      totalPath.insert(0, current);
    }
    return totalPath;
  }
}
