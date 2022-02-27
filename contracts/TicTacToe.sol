//SPDX-License-Identifier: Unlicense
pragma solidity ^0.4.24;

/**
 * @title TicTacToe contract
 **/
contract TicTacToe {
    address[2] public players;

    /**
     turn
     1 - players[0]'s turn
     2 - players[1]'s turn
     */
    uint public turn = 1;

    /**
     status
     0 - ongoing
     1 - players[0] won
     2 - players[1] won
     3 - draw
     */
    uint public status;

    /**
    board status
     0    1    2
     3    4    5
     6    7    8
     */
    uint[9] private board;

    /**
      * @dev Deploy the contract to create a new game
      * @param opponent The address of player2
      **/
    constructor(address opponent) public {
        require(msg.sender != opponent, "No self play");
        players = [msg.sender, opponent];
    }

    /**
      * @dev Check a, b, c in a line are the same
      * _threeInALine doesn't check if a, b, c are in a line
      * @param a position a
      * @param b position b
      * @param c position c
      **/    
    function _threeInALine(uint a, uint b, uint c) private view returns (bool){
        /*Please complete the code here.*/
        if (a==b && b==c){
            return true;
        }else{
            return false;
        }
    }

    /**
     * @dev get the status of the game
     * @param pos the position the player places at
     * @return the status of the game
     */
    function _getStatus(uint pos) private view returns (uint) {
        /*Please complete the code here.*/
        return status;
    }

    /**
     * @dev ensure the game is still ongoing before a player moving
     * update the status of the game after a player moving
     * @param pos the position the player places at
     */
    modifier _checkStatus(uint pos) {
        /*Please complete the code here.*/
        require(status==0);
        _;
        if(_threeInALine(board[0],board[1],board[2])&&board[0]!=0){
            status=board[0];
        }else if(_threeInALine(board[3],board[4],board[5])&&board[3]!=0){
            status=board[3];
        }else if(_threeInALine(board[6],board[7],board[8])&&board[6]!=0){
            status=board[6];
        }else if(_threeInALine(board[0],board[3],board[6])&&board[0]!=0){
            status=board[0];
        }else if(_threeInALine(board[1],board[4],board[7])&&board[1]!=0){
            status=board[1];
        }else if(_threeInALine(board[2],board[5],board[8])&&board[2]!=0){
            status=board[2];
        }else if(_threeInALine(board[0],board[4],board[8])&&board[0]!=0){
            status=board[0];
        }else if(_threeInALine(board[2],board[4],board[6])&&board[2]!=0){
            status=board[2];
        }else if(board[0]!=0&&board[1]!=0&&board[2]!=0&&board[3]!=0&&board[4]!=0&&board[5]!=0&&board[6]!=0&&board[7]!=0&&board[8]!=0){
            status=3;
        }else{
            status=0;
        }
    }

    /**
     * @dev check if it's msg.sender's turn
     * @return true if it's msg.sender's turn otherwise false
     */
    function myTurn() public view returns (bool) {
       /*Please complete the code here.*/
       if(players[0]==msg.sender && turn == 1){
           return true;
       }else if(players[1]==msg.sender && turn ==2){
           return true;
       }else{
           return false;
       }
    }

    /**
     * @dev ensure it's a msg.sender's turn
     * update the turn after a move
     */
    modifier _myTurn() {
      /*Please complete the code here.*/
      require((players[0]==msg.sender && turn == 1) || (players[1]==msg.sender && turn ==2));
      _;
      if(turn == 1){
          turn = 2;
      }else if(turn == 2){
          turn = 1;
      }
    }

    /**
     * @dev check a move is valid
     * @param pos the position the player places at
     * @return true if valid otherwise false
     */
    function validMove(uint pos) public view returns (bool) {
      /*Please complete the code here.*/
      if(pos>=0 && pos<=8 && board[pos]==0 ){
          return true;
      }else{
          return false;
      }
    }

    /**
     * @dev ensure a move is valid
     * @param pos the position the player places at
     */
    modifier _validMove(uint pos) {
      /*Please complete the code here.*/
      require(pos>=0 && pos<=8 && board[pos]==0);
      _;
    }

    /**
     * @dev a player makes a move
     * @param pos the position the player places at
     */
    function move(uint pos) public _validMove(pos) _checkStatus(pos) _myTurn {
        board[pos] = turn;
    }

    /**
     * @dev show the current board
     * @return board
     */
    function showBoard() public view returns (uint[9]) {
      return board;
    }
}
