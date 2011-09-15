package minefield;

import javafx.scene.control.Button;
import javafx.scene.Scene;
import javafx.scene.layout.LayoutInfo;
import javafx.scene.Node;
import javafx.scene.text.Font;
import javafx.scene.input.*;
import javafx.scene.effect.ColorAdjust;
import javafx.scene.control.ToggleGroup;
import javafx.scene.control.Label;
import javafx.scene.control.Hyperlink;
import javafx.scene.control.RadioButton;
import javafx.scene.control.TextBox;
import javafx.scene.control.ToggleButton;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.text.Text;
import javafx.stage.AppletStageExtension;
import javafx.stage.Stage;

/**
 * @author Manuel Zubieta
 */
public class Main {

    var game = MineGame {};
    def SIZE = game.SIZE;
    def TOTAL = (SIZE * SIZE);
    var buttonWidth = 35;
    var buttonWidth2 = 75;
    var buttons: Node[];
    var BrokenPlacement = false;
    var VirginCode = true;
    var BrokenNotify = true;
    public-read def lessons = ToggleGroup {};
    public-read def answers = ToggleGroup {};

    init {
        for (i in [0..<TOTAL]) {
            var temp: Button = Button {
                        var id = i
                        effect: null
                        layoutX: buttonWidth * (i mod SIZE)
                        layoutY: buttonWidth * (i / SIZE)
                        layoutInfo: __layoutInfo_cell
                        text: bind game.board[i].content
                        font: buttonFont
                        onMouseClicked: function(e: MouseEvent): Void {
                            if (e.button == MouseButton.PRIMARY) {
                                leftClick(id);
                            } else if (e.button == MouseButton.SECONDARY) {
                                rightClick(id);
                            }
                        }
                    }
            insert temp into buttons;
            insert (temp as Node) into scene.content;
        }

    }

    public-read def newGameButton = Button {
                layoutX: (buttonWidth * 10)
                layoutY: 50
                width: buttonWidth * 2
                height: buttonWidth
                text: "New Game!"
                action: newGame
            }

/*******************************************************************************
************                      Actions                        ***************
*******************************************************************************/

    function playCell(cell: Integer): Integer[] {
        return game.playCell(cell);
    }
    function newGame(): Void {
        game.newGame();
        for (i in buttons)
            i.effect = null
    }
    function rightClick(num: Integer): Void {
        var cell = game.board[num];
        if (not game.gameOver) {
            if (not cell.revealed) {
                if (cell.flagged) {//UNFLAG CELL
                    buttons[num].effect = null;
                    cell.flagged = false;
                } else {//FLAG CELL
                    buttons[num].effect = bomb;
                    cell.flagged = true;
                }
            }
        }

    }
    function leftClick(num: Integer): Void {
        if (not game.board[num].flagged) {
            for (i in playCell(num)) {
                if (not game.gameOver) {
                    var cell = game.board[i];
                    if (cell.hasMine) {
                        for (j in [0..<TOTAL]) {
                            if (game.board[j].hasMine) { buttons[j].effect = bomb }
                        }
                        game.gameOver = true;
                    } else {
                        if (cell.adjacentMines == 0) { buttons[i].effect = none }
                        else if (cell.adjacentMines == 1) { buttons[i].effect = one }
                        else if (cell.adjacentMines == 2) { buttons[i].effect = two }
                        else if (cell.adjacentMines == 3) { buttons[i].effect = three }
                        else if (cell.adjacentMines == 4) { buttons[i].effect = four }
                        else if (cell.adjacentMines == 5) { buttons[i].effect = five }
                        else if (cell.adjacentMines == 6) { buttons[i].effect = six }
                        else if (cell.adjacentMines == 7) { buttons[i].effect = seven }
                        else if (cell.adjacentMines == 8) { buttons[i].effect = eight }
                    }
                }
            }
        }
    }

/*******************************************************************************
************                       Colors                        ***************
*******************************************************************************/

    public-read def eight = ColorAdjust {
                brightness: 0.25
                contrast: 1.92
                hue: 1 // purple
                input: null
                saturation: 0.75
            }
    public-read def seven = ColorAdjust {
                brightness: 0.25
                contrast: 1.92
                hue: .45// light green
                input: null
                saturation: 0.75
            }
    public-read def six = ColorAdjust {
                brightness: 0.25
                contrast: 1.92
                hue: -.45 //dark purple
                input: null
                saturation: 0.75
            }
    public-read def five = ColorAdjust {
                brightness: 0.20
                contrast: 1.92
                hue: -.62 //fucia
                input: null
                saturation: 0.85
            }
    public-read def four = ColorAdjust {
                brightness: 0.25
                contrast: 1.92
                hue: -.15 //fucia
                input: null
                saturation: 0.75
            }
    public-read def three = ColorAdjust {
                brightness: 0.25
                contrast: 1.92
                hue: .12//orange
                input: null
                saturation: 0.75
            }
    public-read def two = ColorAdjust {
                brightness: 0.25
                contrast: 1.92
                hue: -.83// ocean blue
                input: null
                saturation: 0.75
            }
    public-read def one = ColorAdjust {
                brightness: 0.25
                contrast: 1.92
                hue: .83 //green-blue medium
                input: null
                saturation: 0.75
            }
    public-read def none = ColorAdjust {
                brightness: 0.25
                contrast: 1.92
                hue: .31 //yellow
                input: null
                saturation: 0.75
            }
    public-read def bomb = ColorAdjust {
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
                text: "Minesweeper!"
                font: Helvetica
            }
    def __layoutInfo_cell: LayoutInfo = LayoutInfo {
                width: buttonWidth
                height: buttonWidth
            }
    /***************************************************************************
     *************************       Tips         ******************************
     ***************************************************************************/
    public-read def gameTips = Label {
                layoutX: buttonWidth
                layoutY: 4 * buttonWidth2 + buttonWidth
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
                content: "The objective of the game is to uncover the entire board "
                         "without uncovering a mine!\n"
                         "There are 10 hidden mines, throughout the board.\n"
                         "You can MARK a square that has not been uncovered yet "
                         "if you believe there is a bomb under it.\n"
                         "\nIf there IS NOT a bomb under a square, when you uncover "
                         "it, it will notify you of how many bombs are adjacent to "
                         "that particular square. (Note: a Yellow square indicates "
                         "there are ZERO bombs adjacent to that square)"
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
        VirginCode = true;
        BrokenPlacement = false;
        BrokenNotify = true;
        game.modularCode = OriginalCode { game: game };

        questionContentBox.visible = false;
        lessonTitle.text = "Original MineSweeper";
        lessonText.content = "Before starting any of the lessons, please familiarize "
                "yourself with the game of Minesweeper! Tips on how to play are provided below the "
                "board, if you do not know how to play. \n\nThe objective of each lesson is "
                "to break the game in a particular way. It will be your job to figure out "
                "what is broken. At any time during a lesson, you may return to the "
                "Original Game to compare."
    }

    public-read def Lesson_1 = ToggleButton {
                text: "Lesson 1 - Crazy Variables "
                toggleGroup: lessons
                onMouseClicked: function(e: MouseEvent): Void {
                    setL1Q1();
                }
            }

    function setL1Q1(): Void {
        VirginCode = false;
        BrokenPlacement = true;
        BrokenNotify = true;
        game.modularCode = BrokenMinePlacement { game: game };

        questionContentBox.visible = true;
        lessonTitle.text = "Lesson 1 : \"Crazy Variables\" - Global vs Method Variables";
        lessonText.content = "Now that you are familiar with the game of Minesweeper...\n\n"
                             "Please play a few games to try to determine what is wrong!";

        question.text = "   What is wrong with the game?";

        answer1Button.textWrap = true;
        answer1Code.text = "The board can only be generated once!";
        answer2Button.textWrap = false;
        answer2Code.text = "The board can NEVER be generated!";
        answer3Button.textWrap = false;
        answer3Code.text = "The board does not exist.";
    }
    function setL1Q2(): Void {
        lessonText.content = "Good job! Now, please take a look at this code that is "
                             "WRONGLY used to fill an empty board with mines: \n\n"
                             "public int mines = 10;\n\n"
                             "//Code Snippet\n"
                             "while (mines > 0) \{\n"
                             "    var i = random.nextInt(TOTAL);\n"
                             "    var cell = game.board[i];\n"
                             "    while (!cell.hasMine()) \{\n"
                             "         //Keep searching for a square\n"
                             "         //That does not already have a mine\n"
                             "         cell.armMine(true);\n"
                             "         notifyAdjacentsOf(cell);\n"
                             "         mines--;//Terminator\n"
                             "    \}\n"
                             "\}";

        question.text = "   What is wrong in this example?";

        answer1Button.textWrap = false;
        answer1Code.text = "A mine is placed in EVERY square because of an improper use of Random.nextInt()";
        answer2Button.textWrap = false;
        answer2Code.text = "There is an infinite loop.";
        answer3Button.textWrap = true;
        answer3Code.text = "Mines is a Global variable and should be reset prior to a new game.";
    }
    function setL1Summary(): Void {
        lessonText.content = "Great work! There are actually several ways to fix the pervious code. "
                             "The simplest would be to create a Method Variable to store the Global Variable, "
                             "mines, in while this snippet of code is run. A Method Variable is assigned on execution "
                             "of a given method. The variable does not stay in memory any longer than the time it takes "
                             "the method to run. This is very different from Global Variables, like \"mines\"!"
                             "Our new method looks like so: \n\n"
                             "public int mines = 10;\n\n"
                             "//Code Snippet\n"
                             "int temp = mines;\n"
                             "while (temp > 0) \{\n"
                             "    var i = random.nextInt(TOTAL);\n"
                             "    var cell = game.board[i];\n"
                             "    while (!cell.hasMine()) \{\n"
                             "         //Keep searching for a square\n"
                             "         //That does not already have a mine\n"
                             "         cell.armMine(true);\n"
                             "         notifyAdjacentsOf(cell);\n"
                             "         temp--;//Terminator\n"
                             "    \}\n"
                             "\}"
                             "\n\nYou have finished this lesson. Please proceed to the next lesson!";
        questionContentBox.visible = false;
    }

    public-read def Lesson_2 = ToggleButton {
                text: "Lesson 2 - Location*3! "
                toggleGroup: lessons
                onMouseClicked: function(e: MouseEvent): Void {
                    setL2Q1();
                }
            }

    function setL2Q1(): Void {
        game.modularCode = BrokenNotify{game:game};
        VirginCode = false;
        BrokenPlacement = false;
        BrokenNotify = true;

        questionContentBox.visible = true;
        lessonTitle.text = "Lesson 2 : \"Location*3!\" - Location, Location, Location!";
        lessonText.content = "This one is going to be a little tricky! Play several games "
                             "until you feel you know what the deffect is!\n\n"
                             "Please play a games to try to determine what is wrong!";

        question.text = "   What is wrong with the game?";

        answer1Button.textWrap = false;
        answer1Code.text = "The Bombs are NOT randomly placed (There is a pattern)!";
        answer2Button.textWrap = true;
        answer2Code.text = "The number of Adjacent Bombs are not right.";
        answer3Button.textWrap = false;
        answer3Code.text = "On every 12th game, there's an extra bomb.";
    }

    function setL2Q2(): Void {
        stringLink.visible = true;
        lessonText.content = "Great job! Please look over the following Code Snippet "
                             "and determine which lines are out of place, and also which "
                             "lines belong where:\n\n"
                             "1.  int temp = mines;\n"
                             "2.  while (temp > 0) \{\n"
                             "3.      var i = random.nextInt(TOTAL);\n"
                             "4.      var cell = game.board[i];\n"
                             "5.      notifyAdjacentsOf(cell);\n"
                             "6.      while (!cell.hasMine()) \{\n"
                             "7.           //Keep searching for a square\n"
                             "8.           //That does not already have a mine\n"
                             "9.           cell.armMine(true);\n"
                             "10.     \}\n"
                             "11.     temp--;\n"
                             "12. \}";

        question.text = "   Determine the out-of-place line(s), and where it/they belongs:";

        answer1Button.textWrap = true;
        answer1Code.text = "Line 5 belongs between 8 and 9.";
        answer2Button.textWrap = false;
        answer2Code.text = "Line 6 belongs at line 2; Line 2 belongs at line 6";
        answer3Button.textWrap = false;
        answer3Code.text = "Line 3 belongs at line 4; Line 4 belongs at line 3";
    }

    function setL2Summary(): Void {
        lessonText.content = "Congratulations! Location is absolutely KEY, when it "
                             "comes to programming! As you noticed, this might have been "
                             "the trickiest question, yet! It's only under close inspection "
                             "that this error becomes obvious! What is happening is that the "
                             "adjacent cells are being notified prior to checking if a mine has "
                             "already been set at that current location! So you'll occassionally "
                             "see cells that state that they have MORE mines around them, then they "
                             "actually do!\n\n"
                             "You have completed all of the lessons!";
    }


    public-read def lessonButtonBox = HBox {
                layoutX: 14 * buttonWidth
                layoutY: buttonWidth
                width: 10 * buttonWidth
                height: buttonWidth
                content: [Original_Game, Lesson_1, Lesson_2]
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
                "yourself with the game of Sudoku! Tips on how to play are provided below the "
                "board, if you do not know how to play. \n\nThe objective of each lesson is "
                "to break the game in a particular way. It will be your job to figure out "
                "what is broken. At any time during a lesson, you may return to the "
                "Original Game to compare."
                font: lessonFont
            }
    public-read def switchLink = Hyperlink {
                visible: false
                text: "The switch Statement - Java Tutorial (Please ensure your Pop-up Blocker is disabled.)"
                action: function() {
                    AppletStageExtension.showDocument("http://download.oracle.com/javase/tutorial/java/nutsandbolts/switch.html", "_blank");
                }
            }
    public-read def stringLink = Hyperlink {
                visible: false
                text: "String Interface - Java API (Please ensure your Pop-up Blocker is disabled.)"
                action: function() {
                    AppletStageExtension.showDocument("http://download.oracle.com/javase/1.5.0/docs/api/java/lang/String.html", "_blank");
                }
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
            if (BrokenPlacement) {/////////////////////////////////////////////
                if (answer1Button.textWrap) { setL1Q2(); correct() }
                else if (answer3Button.textWrap) { setL1Summary(); correct() }
                else { wrong() }
            } else if (BrokenNotify) {//////////////////////////////////
                if (answer2Button.textWrap) { setL2Q2(); correct() }
                else if (answer1Button.textWrap) { setL2Summary(); correct() }
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
