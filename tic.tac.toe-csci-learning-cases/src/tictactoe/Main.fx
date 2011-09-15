package tictactoe;

import javafx.scene.control.Button;
import javafx.scene.Scene;
import javafx.scene.layout.LayoutInfo;
import javafx.scene.Node;
import javafx.scene.text.Font;
import javafx.scene.input.*;
import javafx.scene.effect.ColorAdjust;
import javafx.scene.text.Text;
import javafx.scene.control.Label;
import javafx.stage.Stage;
import javafx.scene.control.RadioButton;
import javafx.scene.control.TextBox;
import javafx.scene.control.ToggleButton;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.control.ToggleGroup;

/**
 * @author Manuel Zubieta
 */
public class Main {

    var game = TicTacToeGame {};
    def SIZE = game.SIZE;
    def TOTAL = (SIZE * SIZE);
    var buttonWidth = 35;
    var buttonWidth2 = 75;
    var buttons: Node[];
    public-read def lessons = ToggleGroup {};
    public-read def answers = ToggleGroup {};
    var VirginCode = true;
    var BrokenTurn = false;

    init {
        for (i in [0..<TOTAL]) {
            var temp: Button = Button {
                        var id = i
                        effect: null
                        layoutX: buttonWidth2 * (i mod SIZE)
                        layoutY: buttonWidth2 * (i / SIZE)
                        layoutInfo: __layoutInfo_cell
                        text: bind game.board[i]
                        font: buttonFont
                        onMouseClicked: function(e: MouseEvent): Void {
                                leftClick(id);
                        }
                    }
            insert temp into buttons;
            insert (temp as Node) into scene.content;
        }

    }
    public-read def newGameButton = Button {
                layoutX: (buttonWidth2 * SIZE) + buttonWidth2
                layoutY: buttonWidth2
                width: buttonWidth * 2
                height: buttonWidth
                text: "New Game!"
                action: newGame
            }
    /*******************************************************************************
     ************                      Actions                        ***************
     *******************************************************************************/
    function newGame(): Void {
        game.newGame();
        for (i in buttons)
            i.effect = null
    }
    function leftClick(num: Integer): Void {
        if (not game.gameOver) {
            if (not game.takeTurn(num)){
                if((game.turnsTaken-1) mod 2 == 0){buttons[num].effect = blue}
                else {buttons[num].effect = red}
            }
            else{Stage{
                    title: "GameOver!"
                    scene: Scene {  width: 100.0
                                    height: 25.0
                                    content: Label {text: "GAMEOVER!"}
                            }
                };}
        }
    }

    /*******************************************************************************
     ************                       Colors                        ***************
     *******************************************************************************/
    public-read def blue = ColorAdjust {
                brightness: 0.25
                contrast: 1.92
                hue: -.83// ocean blue
                input: null
                saturation: 0.75
            }
    public-read def red = ColorAdjust {
                brightness: .25
                contrast: 1
                hue: 0 //red
                input: null
                saturation: .75
            }
    /*******************************************************************************
     ************                       Layout                        ***************
     *******************************************************************************/

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
    public-read def buttonFont: Font = Font {
                name: "button"
                size: 20.0
            }
    public-read def title = Label {
                layoutX: newGameButton.layoutX
                layoutY: .5 * buttonWidth
                text: "Tic-Tac-Toe!"
                font: Helvetica
            }
    def __layoutInfo_cell: LayoutInfo = LayoutInfo {
                width: buttonWidth2
                height: buttonWidth2
            }
    /***************************************************************************
     *************************       Tips         ******************************
     ***************************************************************************/
    public-read def gameTips = Label {
                layoutX: buttonWidth
                layoutY: 3 * buttonWidth2 + buttonWidth
                font: Helvetica
                text: "Game Tips:"
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
    public-read def tipText = Text {
                visible: false
                layoutX: 10.0
                layoutY: gameTips.layoutY + buttonWidth + 15
                wrappingWidth: 360.0
                font: small
                content: "The objective of the game is to connect 3 X's "
                         "or 3 O's in a row, column or diagnol. X and O "
                         "take turns, with X initiating a game. A DRAW occurs "
                         "when neither party achieves 3 in a row, column or "
                         "diagnol!"
            }
    /***************************************************************************
     ********************          Questions           *************************
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
                height: .75 * answerBoxHeight
                content: [answer1Box, answer2Box, answer3Box]
                spacing: 10.0
            }
    public-read def question = Label {
                text: "                          What is wrong with the game?"
                font: Helvetica
            }
    public-read def submit: Button = Button {
                text: "Submit Answer"
                action: submitAnswer
            }
    public-read var questionContentBox: VBox = VBox {
                visible: false
                layoutX: 11 * buttonWidth
                layoutY: 10 * buttonWidth
                width: (4. / 3) * answerBoxHeight
                height: 1 * answerBoxHeight
                content: [question, answersContentBox, submit]
                spacing: 10.0
            }
    /***************************************************************************
     ********************          Lessons             *************************
     ***************************************************************************/
    public-read def Original_Game = ToggleButton {
                text: "Original Game   "
                toggleGroup: lessons
                selected: true
                onMouseClicked: function(e: MouseEvent): Void {
                    origin();
                }
            }

    function origin(): Void {
        game.modularCode = OriginalCode { game: game };
        VirginCode = true;
        BrokenTurn = false;

        questionContentBox.visible = false;
        lessonTitle.text = "Original Tic-Tac-Toe";
        lessonText.content = "Before starting any of the lessons, please familiarize "
                "yourself with the game of Tic-Tac-Toe! Tips on how to play are provided below the "
                "board, if you do not know how to play. \n\nThe objective of each lesson is "
                "to break the game in a particular way. It will be your job to figure out "
                "what is broken. At any time during a lesson, you may return to the "
                "Original Game to compare."
    }

    public-read def Lesson_1 = ToggleButton {
                text: "Lesson 1 - Mod%/Divide "
                toggleGroup: lessons
                onMouseClicked: function(e: MouseEvent): Void {
                    setL1Q1();
                }
            }

    function setL1Q1(): Void {
        VirginCode = false;
        BrokenTurn = true;
        game.modularCode = BrokenTurn { game: game };

        questionContentBox.visible = true;
        lessonTitle.text = "Lesson 1 : \"Mod%/Divide\" - Working with Modulus";
        lessonText.content = "Now that you are familiar with the game of Tic-Tac-Toe...\n\n"
                             "Please play a few games to try to determine what is wrong!";

        question.text = "   What is wrong with the game?";

        answer1Button.textWrap = false;
        answer1Code.text = "The game never ends.";
        answer2Button.textWrap = true;
        answer2Code.text = "The wrong cell is played!!";
        answer3Button.textWrap = false;
        answer3Code.text = "Nothing can be entered into a square.";
    }
    function setL1Q2(): Void {
        lessonText.content = "That was easy! But now the question is, \"Why?\" "
                             "Observe the code below, and describe what it does\n\n"
                             "//variables\n"
                             "private int turnsTaken = 0;\n"
                             "private char[] p = \{'X','O'\};\n\n"

                             "/** square = [0..8] representing the 9 squares on board*/\n\n"
                             "public Boolean takeTurn(int square)\{\n"
                             "  if (!gameover && board[square/3][square%3] == ' ')\n"
                             "    board[square%3][square/3]=players[turnsTaken++%2];\n"
                             "  return evaluateBoard();"
                             "\}";

        question.text = "   What is wrong in this example, if there is anything wrong?";

        answer1Button.textWrap = false;
        answer1Code.text = "Nothing is wrong, the problem lies elsewhere.";
        answer2Button.textWrap = false;
        answer2Code.text = "turnsTaken is not increased at the right time.";
        answer3Button.textWrap = true;
        answer3Code.text = "It plays in the wrong square!";
    }
    function setL1Summary(): Void {
        lessonText.content = "Great work! Tic-Tac-Toe is an incredibly easy game, but that "
                             "last example was very complicated! A lot was done in just a few "
                             "lines of code. If you look at the code again, you'll see that "
                             "% (modulus) is a very POWERFUL arithmetic expression! Modulus "
                             "finds the remainer of the first number, after it's divded by the second "
                             "number. For example: \n"
                             "4 / 3 == 1\n"
                             "4 % 3 == 1\n"
                             "0 / 3 == 0\n"
                             "0 % 3 == 0\n"
                             "From this you can see the trick being used to figure out where the play "
                             "should be at! The 0 cell is at row 0, column 0. And the 4th cell is "
                             " at row 1, column 1!\n\n"
                             "Here's that code, one more time, this time done RIGHT!\n\n"
                             "//variables\n"
                             "private int turnsTaken = 0;\n"
                             "private char[] p = \{'X','O'\};\n\n"

                             "/** square = [0..8] representing the 9 squares on board*/\n\n"
                             "public Boolean takeTurn(int square)\{\n"
                             "  if (!gameover && board[square/3][square%3] == ' ')\n"
                             "    board[square/3][square%3]=players[turnsTaken++%2];\n"
                             "  return evaluateBoard();"
                             "\}"
                             "\n\nYou have finished this lesson!";
        questionContentBox.visible = false;
    }


    public-read def lessonButtonBox = HBox {
                layoutX: 14 * buttonWidth
                layoutY: buttonWidth
                width: 10 * buttonWidth
                height: buttonWidth
                content: [Original_Game, Lesson_1]
                spacing: 10.0
            }
    public-read def lessonTitle = Label {
                visible: true
                text: "Original Game"
                font: Helvetica
            }
    public-read def lessonText = Text {
                visible: true
                wrappingWidth: 450.0
                content: "Before starting any of the lessons, please familiarize "
                "yourself with the game of Tic-Tac-Toe! Tips on how to play are provided below the "
                "board, if you do not know how to play. \n\nThe objective of each lesson is "
                "to break the game in a particular way. It will be your job to figure out "
                "what is broken. At any time during a lesson, you may return to the "
                "Original Game to compare."
                font: lessonFont
            }
    public-read def lessonContent = VBox {
                layoutX: lessonButtonBox.layoutX
                layoutY: 2 * buttonWidth + 5
                width: 10 * buttonWidth
                //height:
                content: [lessonTitle, lessonText]
                spacing: 10.0 }

    /***************************************************************************
     ********************           Answers            *************************
     ***************************************************************************/
    function submitAnswer(): Void {
        if ((answers.selectedToggle as ToggleButton).textWrap) {
            if (BrokenTurn) {/////////////////////////////////////////////
                if (answer2Button.textWrap) { setL1Q2(); correct() }
                else if (answer3Button.textWrap) { setL1Summary(); correct() }
                else { wrong() }
            } 
        } else { wrong() }
    }

    function correct(): Void { Stage {
            title: "Correct!"
            scene: Scene {
                width: 100.0
                height: 25.0
                content: Label {
                    text: "Good Job!"
                }
            }
        } }

    function wrong(): Void {
        Stage {
            title: "Wrong!"
            scene: Scene {
                width: 100.0
                height: 25.0
                content: Label {
                    text: "Try Again!"
                } } } }

    /*******************************************************************************
     ************                       Design                        ***************
     *******************************************************************************/
    public-read def scene: Scene = Scene {
                width: 1024.0
                height: 768.0
                content: getDesignRootNodes()
            }
    public-read def currentState = org.netbeans.javafx.design.DesignState {
            }

    public function getDesignRootNodes(): Node[] {
        [newGameButton, lessonButtonBox, lessonContent, hintButton, gameTips, questionContentBox,
            tipText, title]
    }

    public function getDesignScene(): Scene {
        scene
    }

}

/*******************************************************************************
 ************                        Run                          ***************
 *******************************************************************************/
function run(): Void {
    var design = Main {};
    javafx.stage.Stage {
        title: "Main"
        scene: design.getDesignScene()
    }
}
