package boggle;

import javafx.scene.control.Button;
import javafx.scene.Scene;
import javafx.scene.layout.LayoutInfo;
import javafx.scene.Node;
import javafx.scene.text.Font;
import javafx.scene.input.*;
import javafx.scene.effect.ColorAdjust;
import boggle.BoggleGame;
import javafx.scene.text.Text;
import javafx.scene.control.Hyperlink;
import javafx.scene.control.Label;
import javafx.scene.control.ToggleButton;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.stage.AppletStageExtension;
import javafx.scene.control.ToggleGroup;
import javafx.scene.control.RadioButton;
import javafx.scene.control.TextBox;
import javafx.stage.Stage;

/**
 * @author Manuel Zubieta
 */
public class Main {

    var game = BoggleGame {};
    def SIZE = game.SIZE;
    def TOTAL = (SIZE * SIZE);
    var selected = -1;
    var buttonWidth = 35;
    var buttonWidth2 = 75;
    var buttons: Node[];
    public-read def lessons = ToggleGroup {};
    public-read def answers = ToggleGroup {};
    var BrokenSwitch = false;
    var BrokenCSProtocol = false;
    var BrokenLesson3 = false;
    var VirginCode = true;

    /***************************************************************************
     ********************    Generate Boggle Board     *************************
     ***************************************************************************/
    init {
        for (i in [0..<TOTAL]) {
            var temp: Button = Button {
                        var id = i
                        effect: null
                        layoutX: buttonWidth2 * (i mod SIZE)
                        layoutY: buttonWidth2 * (i / SIZE)
                        layoutInfo: __layoutInfo_cell
                        text: bind game.tray[i].top
                        font: buttonFont
                        onMouseClicked: function(e: MouseEvent): Void {
                            leftClick(id);
                        }
                    }
            insert temp into buttons;
            insert (temp as Node) into scene.content;
        }

    }

    def __layoutInfo_cell: LayoutInfo = LayoutInfo {
                width: buttonWidth2
                height: buttonWidth2
            }
    /***************************************************************************
     ********************           Controls           *************************
     ***************************************************************************/
    public-read def newGameButton = Button {
                layoutX: (buttonWidth2 * SIZE) + buttonWidth2 * .5
                layoutY: buttonWidth2
                width: buttonWidth2 * 2
                height: buttonWidth2
                text: "New Game!"
                action: newGame
            }
    public-read def submitButton = Button {
                layoutX: newGameButton.layoutX
                layoutY: newGameButton.layoutY + buttonWidth2 * .5
                width: buttonWidth2 * 2
                height: buttonWidth2
                text: bind "Submit: {game.word}"
                action: submitPath
            }
    public-read def clearPathButton = Button {
                layoutX: newGameButton.layoutX
                layoutY: submitButton.layoutY + buttonWidth2 * .5
                width: buttonWidth2 * 2
                height: buttonWidth2
                text: "Clear"
                action: clearPath
            }
    public-read def score = Text {
                layoutX: newGameButton.layoutX
                layoutY: buttonWidth2 - 7.5
                content: bind "Score: {game.score}"
            }
    function clearPath(): Void {
        game.clearPath();
        selected = -1;
        for (i in buttons)
            i.effect = null
    }
    function submitPath(): Void {
        game.submit();
        clearPath();
    }
    function playCube(cell: Integer): Boolean { return game.playCube(cell) }
    function newGame(): Void {
        clearPath();
        game.newGame();
    }
    function leftClick(num: Integer): Void {
        if (game.playCube(num)) {
            if (selected != -1) { buttons[selected].effect = blue }
            buttons[num].effect = red;
            selected = num;
        }
    }
    /***************************************************************************
     ********************            Style             *************************
     ***************************************************************************/
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
    /******************************* Fonts *************************************/
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
                text: "Boggle!"
                font: Helvetica
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
                content: "The objective of the game is to score as many words as possible "
                         "with the given board. \n\n"
                         "You MAY ONLY use letters adjacent to the current letter.\n"
                         "You MAY NOT reuse any letter.\n"
                         "You MAY go in any direction.\n\n"
                         "Boggle scores words with the following rules:\n\n"
                         "Word of length 3 or 4 = 1 points\n"
                         "Word of length 5 = 2 points\n"
                         "Word of length 6 = 3 points\n"
                         "Word of length 7 = 5 points\n"
                         "Word of length 8+ = 11 points\n\n"
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
        BrokenLesson3 = false;
        BrokenSwitch = false;
        BrokenCSProtocol = false;

        questionContentBox.visible = false;
        lessonTitle.text = "Original Boggle";
        lessonText.content = "Before starting any of the lessons, please familiarize "
                "yourself with the game of Boggle! Tips on how to play are provided below the "
                "board, if you do not know how to play. \n\nThe objective of each lesson is "
                "to break the game in a particular way. It will be your job to figure out "
                "what is broken. At any time during a lesson, you may return to the "
                "Original Game to compare."
    }

    public-read def Lesson_1 = ToggleButton {
                text: "Lesson 1 - Which Switch? "
                toggleGroup: lessons
                onMouseClicked: function(e: MouseEvent): Void {
                    setL1Q1();
                }
            }

    function setL1Q1(): Void {
        game.modularCode = BrokenSwitch { game: game };
        BrokenSwitch = true;
        BrokenLesson3 = false;
        BrokenCSProtocol = false;
        VirginCode = false;

        questionContentBox.visible = true;
        lessonTitle.text = "Lesson 1 : \"Which Switch?\" - Proper Use of Switches";
        lessonText.content = "Boggle scores words with the following rules:\n\n"
                "Word of length 3 or 4 = 1 points\n"
                "Word of length 5 = 2 points\n"
                "Word of length 6 = 3 points\n"
                "Word of length 7 = 5 points\n"
                "Word of length 8+ = 11 points\n\n"
                "At this time, please play a few words to try to determine what is wrong!";

        question.text = "   What is wrong with the game?";

        answer1Button.textWrap = false;
        answer1Code.text = "Words of length 5+ all get 5 points.";
        answer2Button.textWrap = false;
        answer2Code.text = "Words of length 4 get 4 points.";
        answer3Button.textWrap = true;
        answer3Code.text = "Words of length 3 or 4 get 3 points.";
    }
    function setL1Q2(): Void {
        switchLink.visible = true;
        lessonText.content = "Sometimes when we have to code several if/else statements in a "
                "row, we might get to thinking \"Maybe there's an easier way than "
                "this?\"\n"
                "One possible answer to this is the Switch statement. Unfortunately "
                "for us, the Switch statement is much trickier than you can imagine!\n"
                "Please read over the supplied link regarding Switch statements and "
                "determine which IMPROPER Switch statement is used!";

        question.text = "   Which Switch statement is used in this example?";

        answer1Button.textWrap = true;
        answer1Code.text = "int size = word.length();\n"
                "switch (size) \{\n"
                " case 3: \n"
                " case 4: score++;\n"
                " case 5: score+=2;break;\n"
                " case 6: score+=3;break;\n"
                " case 7: score+=5;break;\n"
                " default: score+=11;\n"
                "\}";
        answer2Button.textWrap = false;
        answer2Code.text = "int size = word.length();\n"
                "switch (size) \{\n"
                " case 3: \n"
                " case 4: score++;break;\n"
                " case 5: score+=2;break;\n"
                " case 6: score+=3;break;\n"
                " case 7: score+=5;break;\n"
                " default: score+=11;\n"
                "\}";
        answer3Button.textWrap = false;
        answer3Code.text = "int size = word.length();\n"
                "switch (size) \{\n"
                " case 3:\n"
                " case 4: score++;\n"
                " case 5: score+=2\n"
                " case 6: score+=3\n"
                " case 7: score+=5\n"
                " default: score+=11;\n"
                "\}";
    }
    function setL1Summary(): Void {
        switchLink.visible = false;
        lessonText.content = "Great work! "
                             "\nYou have finished this lesson. Please proceed to the next lesson!";
        questionContentBox.visible = false;
    }

    public-read def Lesson_2 = ToggleButton {
                text: "Lesson 2 - Contracts! "
                toggleGroup: lessons
                onMouseClicked: function(e: MouseEvent): Void {
                    setL2Q1();
                }
            }

    function setL2Q1(): Void {
        game.modularCode = BrokenProtocol{game:game};
        BrokenCSProtocol = true;

        BrokenLesson3 = false;
        BrokenSwitch = false;
        VirginCode = false;

        questionContentBox.visible = true;
        lessonTitle.text = "Lesson 2 : Contracts! - Follow Client/Server Contracts";
        lessonText.content = "Like Application Program Interfaces (APIs), Client/Server "
                             "Contracts are to be read and followed whenever available!\n\n"
                             "Please play a few words to try to determine what is wrong!";

        question.text = "   What is wrong with the game?";

        answer1Button.textWrap = false;
        answer1Code.text = "Words of length 5+ all get 5 points.";
        answer2Button.textWrap = true;
        answer2Code.text = "Words of all lengths get 0 points.";
        answer3Button.textWrap = false;
        answer3Code.text = "Words of length 3 or 4 get 3 points.";
    }

    function setL2Q2(): Void {
        stringLink.visible = true;
        lessonText.content = "Great job! Please read the following Client/Server Contract "
                             "for the Boggle Game's Dictionary and determine which method "
                             "invocation is the correct one, that will yield the proper scoring.\n\n"
                             "/**\n * Requires:\tThe string word must be in all lowercase letters\n"
                             " * Ensures:\tReturns TRUE if word is found in dictionary \n*/\n"
                             "public Boolean isReal(String word);\n\n"
                             "You might find the String Interface useful:";

        question.text = "   Which call to dictionary.isReal(String word): is correct?";

        answer1Button.textWrap = false;
        answer1Code.text = "word.toLowerCase();\n"
                "if (dictionary.isReal(word))\{...;\n";
        answer2Button.textWrap = false;
        answer2Code.text = "if (dictionary.isReal(toLowerCase(word)))\{...;\n";
        answer3Button.textWrap = true;
        answer3Code.text = "if (dictionary.isReal(word.toLowerCase()))\{...;\n";
    }

    function setL2Summary(): Void {
        stringLink.visible = false;
        lessonText.content = "You have finished this lesson. Please proceed to the next lesson!";
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
                content: [lessonTitle, lessonText, switchLink, stringLink]
                spacing: 10.0 }

    /***************************************************************************
     ********************           Answers            *************************
     ***************************************************************************/
    function submitAnswer(): Void {
        if ((answers.selectedToggle as ToggleButton).textWrap) {
            if (BrokenSwitch) {/////////////////////////////////////////////
                if (answer3Button.textWrap) { setL1Q2(); correct() }
                else if (answer1Button.textWrap) { setL1Summary(); correct() }
                else { wrong() }
            } else if (BrokenCSProtocol) {//////////////////////////////////
                if (answer2Button.textWrap) { setL2Q2(); correct() }
                else if (answer3Button.textWrap) { setL2Summary(); correct() }
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

    /***************************************************************************
     ********************            Design            *************************
     ***************************************************************************/
    public-read def scene: Scene = Scene {
                width: 1024.0
                height: 768.0
                content: getDesignRootNodes()
            }
    public-read def currentState = org.netbeans.javafx.design.DesignState {
            }

    public function getDesignRootNodes(): Node[] {
        [newGameButton, clearPathButton, submitButton, score, lessonButtonBox, lessonContent, hintButton, gameTips, questionContentBox,
            tipText, title]
    }

    public function getDesignScene(): Scene {
        scene
    }
}

/***************************************************************************
 ********************              Run             *************************
 ***************************************************************************/
function main(): Void {
    var design = Main {};
    javafx.stage.Stage {
        title: "Main"
        scene: design.getDesignScene()
    }
}
function run(): Void {
    main()
}



