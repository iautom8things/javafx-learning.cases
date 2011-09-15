/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sudoku;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.text.*;
import javafx.scene.layout.*;
import javafx.scene.effect.*;
import javafx.scene.shape.Line;
import javafx.scene.Node;
import javafx.scene.input.MouseEvent;
import javafx.stage.AppletStageExtension;

/**
 * @author Manuel Zubieta
 */
public class Main {
    var game = SudokuGame {};
    var buttonWidth = 35;
    var SIZE = 9;
    var TOTAL = SIZE * SIZE;
    var brokeRandNewGame = false; //used for broken random game
    public-read def boardGroup = ToggleGroup {};
    public-read def difficulty = ToggleGroup {};
    public-read def lessons = ToggleGroup {};
    public-read def answers = ToggleGroup {};
/***************************************************************************
 ********************    Generate Sudoku Board     *************************
 ***************************************************************************/
    init {
        for (i in [0..<TOTAL]) {

            var temp = ToggleButton {
                        def id = i;
                        var num = bind game.board[i].number;
                        id: "{id}"
                        layoutX: 5 + (3 * ((i mod SIZE) / 3)) + (buttonWidth + 1) * (i mod SIZE)
                        layoutY: 5 + (3 * ((i / SIZE) / 3)) + (buttonWidth + 1) * (i / SIZE)
                        layoutInfo: buttonSizes
                        text: bind if (game.modularCode instanceof BrokenRandom) brokenRandom(num, id) else if (game.modularCode instanceof BrokenCellNumbers) "{id}" else notZero(num);
                        toggleGroup: boardGroup
                        onMouseClicked: boardSelection
                    }
            insert (temp as Node) into scene.content;
        }
    }
    def buttonSizes = LayoutInfo {
                width: buttonWidth
                height: buttonWidth }
    /***************************************************************************
     ************************   Lines    ****************************************
     ***************************************************************************/
    public-read def vertical_1 = Line {
                layoutX: 114.0
                layoutY: 10.0
                endX: 0.0
                endY: 321.0 }
    public-read def vertical_2 = Line {
                layoutX: 225.0
                layoutY: 10.0
                endX: 0.0
                endY: 321.0 }
    public-read def horizontal_1 = Line {
                layoutX: 10.0
                layoutY: 114.0
                endX: 321.0
                endY: 0.0 }
    public-read def horizontal_2 = Line {
                layoutX: 10.0
                layoutY: 225.0
                endX: 321.0
                endY: 0.0 }
    public-read def thickLine = Line {
                layoutX: 9.0
                layoutY: 340.0
                fill: null
                strokeWidth: 5.0
                endX: 321.0
                endY: 0.0 }
    /***************************************************************************
     *************************   Fonts    ***************************************
     ***************************************************************************/
    public-read def userFont = Font {
                name: "Times New Roman"
                embolden: true }
    public-read def small = Font {
                name: "Arial"
                size: 10.0 }
    public-read def lessonFont = Font {
                name: "Arial"
                size: 12.0 }
    public-read def Helvetica = Font {
                name: "Helvetica"
                size: 20.0 }
    public-read def playingNumbers = Font {
                name: "Arial"
                size: 18.0
                embolden: true }
    public-read def boardNumbers = Font {
                name: "arial"
                size: 12
                embolden: true }
    /***************************************************************************
     ************************   Labels    ***************************************
     ***************************************************************************/
    public-read def title = Label {
                layoutX: 10 * buttonWidth + 10
                layoutY: .5 * buttonWidth
                text: "SUDOKU!"
                font: Helvetica
            }
    public-read def difficultyLabel = Label { text: "Difficulty" }
    public-read def solveLabel = Label { text: "Solve Puzzle" }
    public-read def clearLabel = Label { text: "Clear Puzzle" }
    public-read def emptyCell = Label { text: "Empty Selected Cell" }
    public-read def gameTips = Label {
                layoutX: 1.5 * buttonWidth
                layoutY: 11 * buttonWidth - 5
                font: Helvetica
                text: "Game Tips:"
            }
    /***************************************************************************
     ********************   Play Numbers    *************************************
     ***************************************************************************/
    public-read def _9 = Button {
                layoutInfo: buttonSizes
                text: "9"
                font: playingNumbers
                action: play9
                id: "{9}"
            }
    function play9(): Void {
        if (not (game.modularCode instanceof BrokenCellNumbers)) {
            var cellNumber = getNumber();
            var cellToPlay = game.board[cellNumber];
            if (cellToPlay.editable) { cellToPlay.setNumber(9); }
            if (game.gameOver()) { gameOver() }
        } }
    public-read def _8 = Button {
                layoutInfo: buttonSizes
                text: "8"
                font: playingNumbers
                action: play8
                id: "{8}"
            }
    function play8(): Void {
        if (not (game.modularCode instanceof BrokenCellNumbers)) {
            var cellNumber = getNumber();
            var cellToPlay = game.board[cellNumber];
            if (cellToPlay.editable) { cellToPlay.setNumber(8); }
            if (game.gameOver()) { gameOver() }
        } }
    public-read def _7 = Button {
                layoutInfo: buttonSizes
                text: "7"
                font: playingNumbers
                action: play7
                id: "{7}"
            }
    function play7(): Void {
        if (not (game.modularCode instanceof BrokenCellNumbers)) {
            var cellNumber = getNumber();
            var cellToPlay = game.board[cellNumber];
            if (cellToPlay.editable) { cellToPlay.setNumber(7); }
            if (game.gameOver()) { gameOver() }
        } }
    public-read def _6 = Button {
                layoutInfo: buttonSizes
                text: "6"
                font: playingNumbers
                action: play6
                id: "{6}"
            }
    function play6(): Void {
        if (not (game.modularCode instanceof BrokenCellNumbers)) {
            var cellNumber = getNumber();
            var cellToPlay = game.board[cellNumber];
            if (cellToPlay.editable) { cellToPlay.setNumber(6); }
            if (game.gameOver()) { gameOver() }
        } }
    public-read def _5 = Button {
                layoutInfo: buttonSizes
                text: "5"
                font: playingNumbers
                action: play5
                id: "{5}"
            }
    function play5(): Void {
        if (not (game.modularCode instanceof BrokenCellNumbers)) {
            var cellNumber = getNumber();
            var cellToPlay = game.board[cellNumber];
            if (cellToPlay.editable) { cellToPlay.setNumber(5); }
            if (game.gameOver()) { gameOver() }
        } }
    public-read def _4 = Button {
                layoutInfo: buttonSizes
                text: "4"
                font: playingNumbers
                action: play4
                id: "{4}"
            }
    function play4(): Void {
        if (not (game.modularCode instanceof BrokenCellNumbers)) {
            var cellNumber = getNumber();
            var cellToPlay = game.board[cellNumber];
            if (cellToPlay.editable) { cellToPlay.setNumber(4); }
            if (game.gameOver()) { gameOver() }
        } }
    public-read def _3 = Button {
                layoutInfo: buttonSizes
                text: "3"
                font: playingNumbers
                action: play3
                id: "{3}"
            }
    function play3(): Void {
        if (not (game.modularCode instanceof BrokenCellNumbers)) {
            var cellNumber = getNumber();
            var cellToPlay = game.board[cellNumber];
            if (cellToPlay.editable) { cellToPlay.setNumber(3); }
            if (game.gameOver()) { gameOver() }
        } }
    public-read def _2 = Button {
                layoutInfo: buttonSizes
                text: "2"
                font: playingNumbers
                action: play2
                id: "{2}"
            }
    function play2(): Void {
        if (not (game.modularCode instanceof BrokenCellNumbers)) {
            var cellNumber = getNumber();
            var cellToPlay = game.board[cellNumber];
            if (cellToPlay.editable) { cellToPlay.setNumber(2); }
            if (game.gameOver()) { gameOver() }
        } }
    public-read def _1 = Button {
                layoutInfo: buttonSizes
                text: "1"
                font: playingNumbers
                action: play1
                id: "{1}"
            }
    function play1(): Void {
        if (not (game.modularCode instanceof BrokenCellNumbers)) {
            var cellNumber = getNumber();
            var cellToPlay = game.board[cellNumber];
            if (cellToPlay.editable) { cellToPlay.setNumber(1); }
            if (game.gameOver()) { gameOver() }
        } }
    function getNumber(): Integer {
        var button = boardGroup.selectedToggle as ToggleButton;
        var cellNumber: Integer;
        if ((button != null) or not (game.modularCode instanceof BrokenCellNumbers)) {
            var stringID = button.id;
            if (stringID == "") { cellNumber = 0 } else { cellNumber = java.lang.Integer.parseInt(button.id) }
        }
        return cellNumber;
    }
    public-read def playNumbers = [_1, _2, _3, _4, _5, _6, _7, _8, _9,];
    function gameOver(): Void {
        if (game.gameOver()) {
            Stage {
                title: "GameOver!"
                scene: Scene {
                    width: 100.0
                    height: 25.0
                    content: Label {
                        text: "GAMEOVER!"
                    }
                }
            }
        }
    }
    /***************************************************************************
     ***********************   Buttons    ***************************************
     ***************************************************************************/
    def __layoutInfo_hbox = LayoutInfo {
                width: 0.0
                height: 0.0
            }
    public-read def playButtonsBox = HBox {
                layoutX: 5.0
                layoutY: 10 * buttonWidth - 5
                layoutInfo: __layoutInfo_hbox
                content: [_1, _2, _3, _4, _5, _6, _7, _8, _9,]
                spacing: 2.0
            }
    public-read def Hard = RadioButton {
                id: "H"
                text: "Hard"
                toggleGroup: difficulty
            }
    public-read def Medium = RadioButton {
                id: "M"
                text: "Medium"
                toggleGroup: difficulty
            }
    public-read def Easy = RadioButton {
                id: "E"
                text: "Easy"
                toggleGroup: difficulty
                selected: true
            }
    def __layoutInfo_vbox = LayoutInfo {
                width: 100.0
                height: 100.0
            }
    public-read def hintButton: Button = Button {
                text: "Show Hints  "
                layoutX: gameTips.layoutX + 3 * buttonWidth + 3
                layoutY: gameTips.layoutY
                action: function() {
                    if (tipText.visible) {
                        hintButton.text = "Show Hints  ";
                        tipText.visible = false; } else {
                        hintButton.text = "Hide Hints   ";
                        tipText.visible = true; }
                }
            }
    public-read def Generate = Button {
                onMouseClicked: GenerateOnMouseClicked
                text: "Generate!  "
            }
    public-read def cheat = Button {
                onMouseClicked: SolveOnMouseClicked
                text: "Cheat!  "
            }
    public-read def clearBoard = Button {
                onMouseClicked: ClearBoardOnMouseClicked
                text: "Restart  "
            }
    public-read def clearCell = Button {
                onMouseClicked: clearCellOnMouseClicked
                text: "Clear Cell"
            }
    public-read def controlBox = VBox {
                layoutX: 10 * buttonWidth
                layoutY: 2 * buttonWidth
                layoutInfo: __layoutInfo_vbox
                content: [difficultyLabel, Easy, Medium, Hard, Generate, solveLabel, cheat,
                    clearLabel, clearBoard, emptyCell, clearCell]
                spacing: 6.0
            }
    /***************************************************************************
     ***********************   Questions    *************************************
     ***************************************************************************/
    def answerBoxHeight = 250;
    def __layoutInfo_answers = LayoutInfo {
                width: answerBoxHeight * (2 / 3.)
                height: answerBoxHeight
            }
    public-read def answer1Code = TextBox {
                height: answerBoxHeight
                editable: false
                multiline: true
            }
    public-read def answer2Code = TextBox {
                height: answerBoxHeight
                editable: false
                multiline: true
            }
    public-read def answer3Code = TextBox {
                height: answerBoxHeight
                editable: false
                multiline: true
            }
    public-read def answer1Button = RadioButton {
                textWrap: false
                id: "A"
                toggleGroup: answers
                text: "Answer A"
            }
    public-read def answer2Button = RadioButton {
                textWrap: false
                id: "B"
                toggleGroup: answers
                text: "Answer B"
            }
    public-read def answer3Button = RadioButton {
                textWrap: false
                id: "C"
                toggleGroup: answers
                text: "Answer C"
            }
    public-read def answer1Box = VBox {
                layoutInfo: __layoutInfo_answers
                content: [answer1Button, answer1Code]
            }
    public-read def answer2Box = VBox {
                layoutInfo: __layoutInfo_answers
                content: [answer2Button, answer2Code]
            }
    public-read def answer3Box = VBox {
                layoutInfo: __layoutInfo_answers
                content: [answer3Button, answer3Code]
            }
    public-read def answersContentBox = HBox {
                width: (4. / 3) * answerBoxHeight
                height: .75*answerBoxHeight
                content: [answer1Box, answer2Box, answer3Box]
                spacing: 10.0
            }
    public-read def question = Label {
                text: "                          What is wrong with the game?"
                font: Helvetica
            }
    public-read def submit = Button{
                text: "Submit Answer"
                action: submitAnswer
    }
    public-read var questionContentBox : VBox = VBox{
                visible: false
                layoutX: 11 * buttonWidth
                layoutY: 10 * buttonWidth
                width: (4. / 3) * answerBoxHeight
                height: 1*answerBoxHeight
                content: [question,answersContentBox, submit]
                spacing: 10.0
    }
/***************************************************************************
 ***********************   Lessons    **************************************
 ***************************************************************************/
    public-read def tipText = Text {
                visible: false
                layoutX: 10.0
                layoutY: 420.0
                wrappingWidth: 360.0
                font: small
                content: "The objective of the game is to fill all of the blank cells "
                "with the correct numbers. There are three very simple constraints to "
                "follow.\n\n"
                "  Every row of 9 cells must include all digits 1 through 9 "
                "in ANY order.\n"
                "  Every column of 9 cells must include all digits 1 "
                "through 9 in ANY order.\n"
                "  Every square of 3 x 3 cells must include all "
                "digits 1 through 9 in ANY order.\n\n"
                "When you click on a cell the row, column, "
                "and square that contains it becomes hi-lighted. A number may be played "
                "in a given cell if, and only if, it has not been played in any cell that "
                "is also hi-lighted.\n\n"
                "If the current cell you are trying to play has "
                "zero possible plays, then you have made an error in one of your previous "
                "plays; try playing a different number for one of your previous plays."
            }
    public-read def Original_Game = ToggleButton {
                text: "Original Game   "
                toggleGroup: lessons
                selected: true
                onMouseClicked: function(e: MouseEvent): Void {
                    game.modularCode = OriginalCode { game: game };
                    questionContentBox.visible = false;
                    apiLink.visible = false;
                    additionalText_Lesson3.visible = false;
                    lessonTitle.text = "Original Sudoku";
                    lessonText.content = "Before starting any of the lessons, please familiarize"
                            "yourself with the game of Sudoku! Tips on how to play are provided below the"
                            "board, if you do not know how to play. \n\nThe objective of each lesson is "
                            "to break the game in a particular way. It will be your job to figure out "
                            "what is broken. At any time during a lesson, you may return to the "
                            "Original Game to compare."
                }
            }
    public-read def Lesson_1 = ToggleButton {
                text: "Lesson 1 - VARrgh! "
                toggleGroup: lessons
                onMouseClicked: function(e: MouseEvent): Void {
                    game.modularCode = BrokenCellNumbers { game: game };
                    setL1Q1();
                }
            }
    function setL1Q1():Void{
        questionContentBox.visible = true;
        apiLink.visible = false;
        additionalText_Lesson3.visible = false;
        lessonTitle.text = "Lesson 1 : \"VARrgh!\" - Proper Naming Practices";
        lessonText.content = "Instant Variables are values within a Java Class "
			"that are needed to store information that might be used at a later time. "
			"Technically speaking, an instance variable is both a reference to "
                        "some data and the current state of that data. \n\n"
			"At this time, please generate a new game and try to determine what is wrong!";

        question.text = "   What is wrong with the game?";

        answer1Button.textWrap = false;
        answer1Code.text = "The total number of cells decreased.";
        answer2Button.textWrap = true;
        answer2Code.text = "The cells no longer display the proper information.";
        answer3Button.textWrap = false;
        answer3Code.text = "New games are not being properly generated.";
    }
    function setL1Q2():Void{
         lessonText.content = "In this Sudoku Game, each cell is represented by an instance of the class Cell. The most "
       		"important information each Cell must know is the Current Number that "
      		"the Cell contains. We represent this information with an instance variable "
       		"of type integer (int), called \"number\". The Cell also contains an identification "
                "number called \"id\":\n\n"

                "private int number;\n"
		"private int id;\n\n";

        question.text = "   What do you think happened in this example?";

        answer1Button.textWrap = true;
        answer1Code.text = "The names of the variables were mixed up.";
        answer2Button.textWrap = false;
        answer2Code.text = "There's a flaw in Java that caused this error.";
        answer3Button.textWrap = false;
        answer3Code.text = "The wrong method was called.";
    }
    function setL1Summary():Void{
         lessonText.content = "Great work! \n\n"
                "It is important to use exact naming with our instance variables and "
      		"methods for our own benefit. Another instance variable each Cell "
      		"has is its identification number. Its possible to name this instance "
       		"variable 'num' but this may lead to confusion between 'num' and "
        	"'number' when our methods become more complicated.\n"

                "Here is an example of the code used to create this error:\n\n"
                
                "JButton b3 = new JButton(Integer.toString(g.c[3].n));\n\n"
                
                "This is a horrible example of code! What is \"g\"? What is \"c\"? What is \"n\"?"
                "An example of the same line of code using proper variable names:\n\n"
                
                "JButton button3 = new JButton(Integer.toString(game.cells[3].number));\n\n"
                "You have finished this lesson. Please proceed to the next lesson!";

        questionContentBox.visible = false;
    }
    public-read def Lesson_2 = ToggleButton {
                text: "Lesson 2 - Wh(L)oops! "
                toggleGroup: lessons
                onMouseClicked: function(e: MouseEvent): Void {
                    game.modularCode = BrokenGameOver { game: game };
                    setL2Q1();
                }
            }
    function setL2Q1():Void{
        questionContentBox.visible = true;
        apiLink.visible = false;
        additionalText_Lesson3.visible = false;

        lessonTitle.text = "Lesson 2 : Loops! For Loops and While Loops";
        lessonText.content = "Loops are an essential tool for any programmer to have in their toolbox. "
	"Loops allow for you to repeat certain actions in a controlled manner, or "
	"they allow you to iterate over a selection of data.\n\n"
	"Please generate a new game and try to determine what is wrong!";

        question.text = "   What is wrong with the game?";

        answer1Button.textWrap = false;
        answer1Code.text = "Numbers cannot be played in the cells.";
        answer2Button.textWrap = false;
        answer2Code.text = "It's stuck in an infinite loop.";
        answer3Button.textWrap = true;
        answer3Code.text = "It does not properly determine if the game is \"over\"";
    }
    function setL2Q2():Void{
        lessonText.content = "The logic to determine if a Sudoku board is complete is simple:\n\n"
                             "\"Are all columns, rows, and 3x3 squares complete?\"\n\n"
                             "But we have to be more explicit when we program. So, really "
                             "the logic is, \"Is row1 complete? Is column1 complete?...\" all "
                             "the way until every grouping has been considered.";



        question.text = "   Which of the following gameOver() methods is correct?";

        answer1Button.textWrap = true;
        answer1Code.text = "public Boolean gameOver()\{\n"
	   " Boolean result = true;\n"
           " int i=0;\n"
           " while (result && i<9)\{\n"
	   "  result = result \n"
           "   && rows[i].isComplete()\n"
           "   && columns[i].isComplete()\n"
           "   && squares[i++].isComplete();\n"
           " return result;\}";
        answer2Button.textWrap = false;
        answer2Code.text = "public Boolean gameOver()\{\n"
	   " Boolean result = true;\n"
           " int i=0;\n"
           " while (result)\{\n"
	   "  result = result \n"
           "   && rows[i].isComplete()\n"
           "   && columns[i].isComplete()\n"
           "   && squares[i].isComplete();\n"
           "  i++;\}\n"
           " return result;\}";
        answer3Button.textWrap = false;
        answer3Code.text = "public Boolean gameOver()\{\n"
	   " Boolean result = true;\n"
           " int i=0;\n"
           " while (i<9)\{\n"
	   "  result = rows[i].isComplete()\n"
           "   && columns[i].isComplete()\n"
           "   && squares[i].isComplete();\n"
           "  i++;\}\n"
           " return result;\}";
    }
    function setL2Summary():Void{
        lessonText.content = "Great work! \n\n"
                "A) is the only method that properly evaluates each Cell Group. B) will properly "
                "return FALSE if the Sudoku board is NOT complete, however it will encounter an "
                "issue when the board is complete! Because the condition statement does not consider "
                "the iterator, i, it will continue to look for a 10th row, which DOES NOT EXIST! C) "
                "falls victim to a poorly written condition statement, as well. C) is the broken example "
                "that is wrong with the current game, it ONLY evaluates the last row, last column and last "
                "square!\n\n"
                "You have finished this lesson. Please proceed to the next lesson!";
        }
    public-read def Lesson_3 = ToggleButton {
                text: "Lesson 3 - API"
                toggleGroup: lessons
                onMouseClicked: function(e: MouseEvent): Void {
                    game.modularCode = BrokenRandom { game: game };
                    setL3Q1();
                }
            }
    function setL3Q1():Void{
        questionContentBox.visible = true;
        apiLink.visible = true;
        additionalText_Lesson3.visible = true;

        lessonTitle.text = "Lesson 3 : Know Your API!";
        lessonText.content = "One of the most valuable lessons a budding programmer can learn is this: \n\n"
                            "\"When in doubt, refer to the Application Program Interface (API)!!\"\n\n"
                            "A programmer should always strive to be well-versed with any API they are "
                            "working with. The Complete Java API can be found here: ";

        question.text = "   What is wrong with the game?";

        answer1Button.textWrap = false;
        answer1Code.text = "The game never ends!";
        answer2Button.textWrap = true;
        answer2Code.text = "The cells do not have appropriate numbers";
        answer3Button.textWrap = false;
        answer3Code.text = "It is not possible to play a cell.";

    }
    function setL3Q2():Void{
        apiLink.visible = false;
        additionalText_Lesson3.visible = false;
        randLink.visible = true;
        lessonText.content = "Good job! The cells contain the numbers 0-8 instead of 1-9. "
                             "It is important to note, that when programming, we normally "
                             "start counting from 0!! After you finish this lesson, go back "
                             "and look at Lesson 1. Notice, how the Cell's Numbers start from 0!\n\n"

                             "When we generate a board for this game of Sudoku, we assign random "
                             "numbers to the cells in such a manner that we follow the rules (Click "
                             "\"Show Hint!\" if you forgot the rules). \n\n"

                             "Follow the link below to read the Java implementation of a Pseudo-Random "
                             "Number Generator and answer the following question!";


        question.text = "   How do you generate a random number between 1-9?";

        answer1Button.textWrap = false;
        answer1Code.text = "Random r = new Random();\n"
                           "int number = r.nextInt(10)-1;";
        answer2Button.textWrap = false;
        answer2Code.text = "Random r = new Random();\n"
                           "int number = r.nextInt(9);";
        answer3Button.textWrap = true;
        answer3Code.text = "Random r = new Random();\n"
                           "int number = r.nextInt(9)+1;";

    }
    function setL3Summary():Void{
        randLink.visible = false;
        lessonText.content = "Great job! A) produces a random number 0-9, and then "
                             "subtracts 1 from it, so the resulting range is -1 to 8. "
                             "B) produces a random number 0-8 and does nothing to it. "
                             "C) produeces the same random number 0-8 and then adds 1 "
                             "to it, resulting in a range of 1-9 which is our desired "
                             "range!\n\n"
                             "You have finished the last lesson!!! Congratulations, and "
                             "Happy Programming!!!";

    }
    public-read def apiLink = Hyperlink {
                visible: false
                text: "Java 1.5 - API (Please ensure your Pop-up Blocker is disabled.)"
                action: function() { AppletStageExtension.showDocument("http://download.oracle.com/javase/1.5.0/docs/api/", "_blank");}

            }
    public-read def randLink = Hyperlink {
                visible: false
                text: "java.util.Random - API (Please ensure your Pop-up Blocker is disabled.)"
                action: function() { AppletStageExtension.showDocument("http://download.oracle.com/javase/1.5.0/docs/api/java/util/Random.html", "_blank");}

            }
    public-read def additionalText_Lesson3 = Text{
                visible: false
                content: "At this time, please generate a new game and try to determine what is wrong!"
                font: lessonFont}
    public-read def lessonButtonBox = HBox {
                layoutX: 15 * buttonWidth
                layoutY: buttonWidth
                width: 10 * buttonWidth
                height: buttonWidth
                content: [Original_Game, Lesson_1, Lesson_2, Lesson_3]
                spacing: 10.0
            }
    public-read def lessonTitle = Label {
                visible: true
                text: "Original Game"
                font: Helvetica
            }
    public-read def lessonText = Text {
                visible: true
                //layoutX: 14*buttonWidth
                //layoutY: 4*buttonWidth
                wrappingWidth: 450.0
                content: "Before starting any of the lessons, please familiarize "
                "yourself with the game of Sudoku! Tips on how to play are provided below the "
                "board, if you do not know how to play. \n\nThe objective of each lesson is "
                "to break the game in a particular way. It will be your job to figure out "
                "what is broken. At any time during a lesson, you may return to the "
                "Original Game to compare."
                font: lessonFont
            }
    public-read def lessonContent = VBox {
                layoutX: 15 * buttonWidth
                layoutY: 2 * buttonWidth + 5
                width: 10 * buttonWidth
                //height:
                content: [lessonTitle, lessonText, randLink, apiLink, additionalText_Lesson3]
                spacing: 10.0 }
/***************************************************************************
 ***********************    Main Design    *********************************
 ***************************************************************************/
    public-read def scene = Scene {
                width: 1024.0
                height: 768.0
                content: getDesignRootNodes()
            }
    public-read def currentState = org.netbeans.javafx.design.DesignState {
            }

    public function getDesignRootNodes(): Node[] {
        [lessonButtonBox, lessonContent, hintButton, gameTips, controlBox, title, questionContentBox,
            playButtonsBox, thickLine, tipText, vertical_1, vertical_2, horizontal_1, horizontal_2]
    }

    public function getDesignScene(): Scene {
        scene
    }

    /***************************************************************************
     ***********************    Actions    **************************************
     ***************************************************************************/
    function submitAnswer():Void{
        if ((answers.selectedToggle as ToggleButton).textWrap){
            if (game.modularCode instanceof BrokenCellNumbers){
                if (answer2Button.textWrap){setL1Q2();correct()}
                else if (answer1Button.textWrap){setL1Summary();correct()}
                else{wrong()}
            }
            else if(game.modularCode instanceof BrokenGameOver){
                if (answer3Button.textWrap){setL2Q2();correct()}
                else if (answer1Button.textWrap){setL2Summary();correct()}
                else{wrong()}
            }
            else if(game.modularCode instanceof BrokenRandom){
                if (answer2Button.textWrap){setL3Q2();correct()}
                else if (answer3Button.textWrap){setL3Summary();correct()}
                else{wrong()}
            }

        }
        else {wrong()}
    }
    function correct():Void{Stage {
                title: "Correct!"
                scene: Scene {
                    width: 100.0
                    height: 25.0
                    content: Label {
                        text: "Good Job!"
                    }
                }
            }}
    function wrong():Void{
        Stage {
                title: "Wrong!"
                scene: Scene {
                    width: 100.0
                    height: 25.0
                    content: Label {
                        text: "Try Again!"
                    }}}}
    function boardSelection(event: MouseEvent): Void {
        if ((boardGroup.selectedToggle != null) or not (game.modularCode instanceof BrokenCellNumbers)) {
            var stringID = (event.node as ToggleButton).id;
            var cellNumber;
            if (stringID == "") { cellNumber = 0 } else { cellNumber = java.lang.Integer.parseInt((event.node as ToggleButton).id) }

            if (not (game.modularCode instanceof BrokenCellNumbers)) {
                var playables = game.board[cellNumber].possiblePlays();

                for (button in playNumbers) {
                    var foundPlayableNumber = false;
                    for (numbers in playables) {
                        if (numbers == java.lang.Integer.parseInt(button.id))
                            foundPlayableNumber = true;
                    }
                    if (not foundPlayableNumber) { button.effect = BoxBlur {} } else { button.effect = null }
                }
            } else { for (button in playNumbers) { button.effect = null } }

            for (i in boardGroup.toggles) {
                if ((i as ToggleButton).effect == selectedColored) { (i as ToggleButton).effect = colored; } else if ((i as ToggleButton).effect != colored)
                    (i as ToggleButton).effect = null;
            }
            for (i in boardGroup.toggles) {
                var tempNumber = java.lang.Integer.parseInt((i as ToggleButton).id);

                if ((cellNumber / 9 == tempNumber / 9) or (cellNumber mod 9 == tempNumber mod 9) or (game.whichSquare(cellNumber) == game.whichSquare(tempNumber))) {
                    if ((i as ToggleButton).effect == colored) { (i as ToggleButton).effect = selectedColored; } else { (i as ToggleButton).effect = Glow {} }
                }
            }
        }
    }

    function GenerateOnMouseClicked(event: MouseEvent): Void {
        if (game.modularCode instanceof BrokenRandom) { brokeRandNewGame = true } else { brokeRandNewGame = false }
        //if (not (game.modularCode instanceof BrokenCellNumbers)) {
            var level: String = (difficulty.selectedToggle as RadioButton).id;
            if (level.equals("E")) { game.generateGame(9) } else if (level.equals("M")) { game.generateGame(35) } else { game.generateGame(58) }
            for (i in [0..80]) {
                if (game.board[i].editable) { (boardGroup.toggles[i] as ToggleButton).effect = colored }//.font= userFont}
                else { (boardGroup.toggles[i] as ToggleButton).effect = null }//.font= boardNumbers}
            }
        } //}

    function SolveOnMouseClicked(event: MouseEvent): Void {
        if (not (game.modularCode instanceof BrokenCellNumbers)) {
            if (not game.gameOver()) { game.findSolution() }
        } }

    function clearCellOnMouseClicked(event: MouseEvent): Void {
        if ((boardGroup.selectedToggle != null) and not (game.modularCode instanceof BrokenCellNumbers)) {
            var stringID = (boardGroup.selectedToggle as ToggleButton).id;
            var cellNumber;
            if (stringID == "") { cellNumber = 0 } else { cellNumber = java.lang.Integer.parseInt(stringID) }
            if (game.board[cellNumber].editable) { game.board[cellNumber].clearCell() }
        } }

    function ClearBoardOnMouseClicked(event: MouseEvent): Void {
        if (not (game.modularCode instanceof BrokenCellNumbers)) {
            for (i in boardGroup.toggles) {
                var tempNumber = java.lang.Integer.parseInt((i as ToggleButton).id);

                if (game.board[tempNumber].editable) {
                    if (game.modularCode instanceof BrokenCellNumbers) { } else { game.board[tempNumber].clearCell() }
                }
            }
        } }

    function notZero(number: Integer): String {
        var result: String;

        if (number == 0) { result = ""; } else { result = number.toString(); }
        return result;
    }

    function brokenRandom(number: Integer, id: Integer): String {
        var n = number;
        n--;
        if (brokeRandNewGame) {
            if (game.board[id].editable) { return notZero(number) }
            if (n >= 0) { return (n).toString() } else return " ";
        } else
            return notZero(number);
    }

}
/***************************************************************************
 *************************    Colors    ************************************
 ***************************************************************************/
public-read def colored = ColorAdjust {
            brightness: 0.41
            contrast: 1.08
            hue: 0.31
            input: null
            saturation: 0.48
        }
public-read def selectedColored = ColorAdjust {
            brightness: 0.55
            contrast: 1.92
            hue: 0.31
            input: null
            saturation: 0.26
        }

/***************************************************************************
 *************************    Run    ****************************************
 ***************************************************************************/
function run(): Void {
    var design = Main {};
    javafx.stage.Stage {
        title: "Main"
        scene: design.getDesignScene()
    }
}
