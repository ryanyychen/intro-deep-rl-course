# search.py
# ---------
# Licensing Information:  You are free to use or extend these projects for
# educational purposes provided that (1) you do not distribute or publish
# solutions, (2) you retain this notice, and (3) you provide clear
# attribution to UC Berkeley, including a link to http://ai.berkeley.edu.
# 
# Attribution Information: The Pacman AI projects were developed at UC Berkeley.
# The core projects and autograders were primarily created by John DeNero
# (denero@cs.berkeley.edu) and Dan Klein (klein@cs.berkeley.edu).
# Student side autograding was added by Brad Miller, Nick Hay, and
# Pieter Abbeel (pabbeel@cs.berkeley.edu).


"""
In search.py, you will implement generic search algorithms which are called by
Pacman agents (in searchAgents.py).
"""

import util
from game import Directions
from typing import List

class SearchProblem:
    """
    This class outlines the structure of a search problem, but doesn't implement
    any of the methods (in object-oriented terminology: an abstract class).

    You do not need to change anything in this class, ever.
    """

    def getStartState(self):
        """
        Returns the start state for the search problem.
        """
        util.raiseNotDefined()

    def isGoalState(self, state):
        """
          state: Search state

        Returns True if and only if the state is a valid goal state.
        """
        util.raiseNotDefined()

    def getSuccessors(self, state):
        """
          state: Search state

        For a given state, this should return a list of triples, (successor,
        action, stepCost), where 'successor' is a successor to the current
        state, 'action' is the action required to get there, and 'stepCost' is
        the incremental cost of expanding to that successor.
        """
        util.raiseNotDefined()

    def getCostOfActions(self, actions):
        """
         actions: A list of actions to take

        This method returns the total cost of a particular sequence of actions.
        The sequence must be composed of legal moves.
        """
        util.raiseNotDefined()




def tinyMazeSearch(problem: SearchProblem) -> List[Directions]:
    """
    Returns a sequence of moves that solves tinyMaze.  For any other maze, the
    sequence of moves will be incorrect, so only use this for tinyMaze.
    """
    s = Directions.SOUTH
    w = Directions.WEST
    return  [s, s, w, s, w, w, s, w]

def depthFirstSearch(problem: SearchProblem) -> List[Directions]:
    """
    Search the deepest nodes in the search tree first.

    Your search algorithm needs to return a list of actions that reaches the
    goal. Make sure to implement a graph search algorithm.

    To get started, you might want to try some of these simple commands to
    understand the search problem that is being passed in:

    print("Start:", problem.getStartState())
    print("Is the start a goal?", problem.isGoalState(problem.getStartState()))
    print("Start's successors:", problem.getSuccessors(problem.getStartState()))
    """
    # Initialize visited set and stack
    visited = set()
    stack = util.Stack()
    curr_state = problem.getStartState()
    stack.push((curr_state, None, None))

    # Initialize map to backtrack for path
    states_map = {}

    # Run DFS
    while not stack.isEmpty():
        curr_state, prev_state, action = stack.pop()
        if curr_state in visited:
            continue
        states_map[curr_state] = (prev_state, action)
        visited.add(curr_state)
        if problem.isGoalState(curr_state):
            break
        next_states = problem.getSuccessors(curr_state)
        for next_state, action, cost in next_states:
            if next_state not in visited:
                stack.push((next_state, curr_state, action))
    
    # Generate path using map
    path = []
    while curr_state != problem.getStartState():
        path.append(states_map[curr_state][1])
        curr_state = states_map[curr_state][0]
    
    path.reverse()
    return path

def breadthFirstSearch(problem: SearchProblem) -> List[Directions]:
    """Search the shallowest nodes in the search tree first."""
    # Initialize visited set and queue
    visited = set()
    queue = util.Queue()
    curr_state = problem.getStartState()
    queue.push((curr_state, None, None))

    # Initialize map to backtrack for path
    states_map = {}

    # Run BFS
    while not queue.isEmpty():
        curr_state, prev_state, action = queue.pop()
        if curr_state in visited:
            continue
        states_map[curr_state] = (prev_state, action)
        visited.add(curr_state)
        if problem.isGoalState(curr_state):
            break
        next_states = problem.getSuccessors(curr_state)
        for next_state, action, cost in next_states:
            if next_state not in visited:
                queue.push((next_state, curr_state, action))
    
    # Generate path using map
    path = []
    while curr_state != problem.getStartState():
        path.append(states_map[curr_state][1])
        curr_state = states_map[curr_state][0]
    
    path.reverse()
    return path

def uniformCostSearch(problem: SearchProblem) -> List[Directions]:
    """Search the node of least total cost first."""
    # Initialize visited set and priority queue
    visited = set()
    pqueue = util.PriorityQueue()
    curr_state = problem.getStartState()
    pqueue.push((curr_state, None, None, 0), 0)

    # Initialize map to backtrack for path
    states_map = {}

    # Run UCS
    while not pqueue.isEmpty():
        curr_state, prev_state, action, curr_cost = pqueue.pop()
        if curr_state in visited:
            continue
        states_map[curr_state] = (prev_state, action)
        visited.add(curr_state)
        if problem.isGoalState(curr_state):
            break
        next_states = problem.getSuccessors(curr_state)
        for next_state, action, cost in next_states:
            if next_state not in visited:
                total_cost = curr_cost + cost
                pqueue.push((next_state, curr_state, action, total_cost), total_cost)
    
    # Generate path using map
    path = []
    while curr_state != problem.getStartState():
        path.append(states_map[curr_state][1])
        curr_state = states_map[curr_state][0]
    
    path.reverse()
    return path

def nullHeuristic(state, problem=None) -> float:
    """
    A heuristic function estimates the cost from the current state to the nearest
    goal in the provided SearchProblem.  This heuristic is trivial.
    """
    return 0

def aStarSearch(problem: SearchProblem, heuristic=nullHeuristic) -> List[Directions]:
    """Search the node that has the lowest combined cost and heuristic first."""
    # Initialize visited set and priority queue
    visited = set()
    pqueue = util.PriorityQueue()
    curr_state = problem.getStartState()
    pqueue.push((curr_state, None, None, 0), heuristic(curr_state, problem))

    # Initialize map to backtrack for path
    states_map = {}

    # Run A*
    while not pqueue.isEmpty():
        curr_state, prev_state, action, curr_cost = pqueue.pop()
        if curr_state in visited:
            # Replace if we find a better path
            if states_map[curr_state][2] > curr_cost:
                states_map[curr_state] = (prev_state, action, curr_cost)
            else:
                continue
        states_map[curr_state] = (prev_state, action, curr_cost)
        visited.add(curr_state)
        if problem.isGoalState(curr_state):
            break
        next_states = problem.getSuccessors(curr_state)
        for next_state, action, cost in next_states:
            total_cost = curr_cost + cost
            pqueue.push((next_state, curr_state, action, total_cost), total_cost + heuristic(next_state, problem))
    
    # Generate path using map
    path = []
    while curr_state != problem.getStartState():
        path.append(states_map[curr_state][1])
        curr_state = states_map[curr_state][0]
    
    path.reverse()
    return path

# Abbreviations
bfs = breadthFirstSearch
dfs = depthFirstSearch
astar = aStarSearch
ucs = uniformCostSearch
