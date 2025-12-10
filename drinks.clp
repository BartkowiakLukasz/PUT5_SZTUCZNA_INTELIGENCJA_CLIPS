(deftemplate Question
    (slot question-id (type SYMBOL))
    (slot question-text (type STRING))
    (multislot question-answers)
)


(deftemplate UserAnswer
    (slot question-id (type SYMBOL))
    (slot question-answer (type SYMBOL))
)


(deftemplate Transition
   (slot current-question-id (type SYMBOL))
   (slot answer (type SYMBOL))
   (slot next-question-id (type SYMBOL))
)

;;template for defrule Next-Question
(deftemplate QuestionData
    (slot question-id (type SYMBOL))
    (slot question-text (type STRING))
    (multislot question-answers)
)

;;template for python interface
(deftemplate Result
    (slot result-id (type SYMBOL))
    (slot recommendation (type STRING))
    (multislot path)
)

;;template for defrule Give-Result
(deftemplate ResultData 
    (slot result-id (type SYMBOL))
   (slot recommendation (type STRING))
)
(deftemplate CurrentPath
(multislot path)
)
;;initial status
(deffacts Graph-Start
    (Question
        (question-id start)
        (question-text "Who are you going out for drinks with?") 
        (question-answers 
            boss "Your Boss"
            colleague "A colleague"
            group "A group"
            client "A client or business contact"
        )
    )
    (CurrentPath
        (path start)
    )
)

(deffacts Graph-Start-Transitions
    (Transition
        (current-question-id start)
        (answer boss)
        (next-question-id boss-ask-to-drinks)
    )
    (Transition
        (current-question-id start)
        (answer colleague)
        (next-question-id colleague-why)
    )
    (Transition
        (current-question-id start)
        (answer group)
        (next-question-id group-is-it-official)
    )
    (Transition
        (current-question-id start)
        (answer client)
        (next-question-id client-why)
    )
)
(deffacts Graph-Boss-Transitions-Ask-To-Drinks
    (Transition
        (current-question-id boss-ask-to-drinks)
        (answer yes)
        (next-question-id boss-are-celebrating)
    )
    (Transition
        (current-question-id boss-ask-to-drinks)
        (answer no)
        (next-question-id boss-ask-for-raise)
    )
)
(deffacts Graph-Boss-Transitions-Are-Celebrating
    (Transition
        (current-question-id boss-are-celebrating)
        (answer yes)
        (next-question-id bubbly)
    )
    (Transition
        (current-question-id boss-are-celebrating)
        (answer no)
        (next-question-id boss-worried-if-in-trouble)
    )
)
(deffacts Graph-Boss-Transitions-Worried-If-In-Trouble
    (Transition
        (current-question-id boss-worried-if-in-trouble)
        (answer yes)
        (next-question-id boss-talk-back)
    )
    (Transition
        (current-question-id boss-worried-if-in-trouble)
        (answer no)
        (next-question-id boss-trynna-sleep)
    )
)
(deffacts Graph-Boss-Transitions-Boss-Talk-Back
    (Transition
        (current-question-id boss-talk-back)
        (answer yes)
        (next-question-id non-alcoholic)
    )
    (Transition
        (current-question-id boss-talk-back)
        (answer no)
        (next-question-id wine)
    )
)
(deffacts Graph-Boss-Transitions-Ask-For-Raise
    (Transition
        (current-question-id ask-for-raise)
        (answer yes)
        (next-question-id stop-office)
    )
    (Transition
        (current-question-id ask-for-raise)
        (answer no)
        (next-question-id boss-promotion)
    )
)
(deffacts Graph-Boss-Transitions-Promotion
    (Transition
        (current-question-id boss-promotion)
        (answer yes)
        (next-question-id stop-office)
    )
    (Transition
        (current-question-id boss-promotion)
        (answer no)
        (next-question-id boss-seduce)
    )
)
(deffacts Graph-Boss-Transitions-Seduce
    (Transition
        (current-question-id boss-seduce)
        (answer yes)
        (next-question-id boss-good-idea)
    )
    (Transition
        (current-question-id boss-seduce)
        (answer no)
        (next-question-id boss-trynna-sleep)
    )
)

(deffacts Graph-Boss-Transitions-Trynna-Sleep
    (Transition
        (current-question-id boss-trynna-sleep)
        (answer yes)
        (next-question-id non-alcoholic)
    )
    (Transition
        (current-question-id boss-trynna-sleep)
        (answer no)
        (next-question-id wine)
    )
)

(deffacts Graph-Boss-Transitions-Good-Idea
    (Transition
        (current-question-id boss-good-idea)
        (answer yes)
        (next-question-id fancy)
    )
    (Transition
        (current-question-id boss-good-idea)
        (answer no)
        (next-question-id martini)
    )
)

(deffacts Graph-Boss-Questions-Data
    (QuestionData
        (question-id boss-ask-to-drinks)
        (question-text "Did he or she ask you to drinks?")
        (question-answers
            yes "Yes" 
            no "No"
        )
    )
    (QuestionData
        (question-id boss-ask-for-raise)
        (question-text "Are you asking for a raise?")
        (question-answers 
            yes "Yes"
            no "No"
        )
    )
    (QuestionData
        (question-id boss-promotion)
        (question-text "Just a promotion?")
        (question-answers 
            yes "Yes"
            no "No"
        )
    )
    (QuestionData
        (question-id boss-seduce)
        (question-text "Are you trying to seduce your boss?")
        (question-answers 
            yes "Yes"
            no "No"
        )
    )
    (QuestionData
        (question-id boss-good-idea)
        (question-text "Are you sure this is a good idea?")
        (question-answers 
            yes "Yes"
            no "No"
        )
    )
    (QuestionData
        (question-id boss-trynna-sleep)
        (question-text "Is he or she trying to sleep with you?")
        (question-answers 
            yes "Yes"
            no "No"
        )
    )
    (QuestionData
        (question-id boss-are-celebrating)
        (question-text "Are you celebrating something?")
        (question-answers 
            yes "Yes"
            no "No"
        )
    )
    (QuestionData
        (question-id boss-worried-if-in-trouble)
        (question-text "Are you worried you're in trouble?")
        (question-answers 
            yes "Yes"
            no "No"
        )
    )
    (QuestionData
        (question-id boss-talk-back)
        (question-text "Will you talk back?")
        (question-answers 
            yes "Yes"
            no "No"
        )
    )
)

(deffacts Graph-Colleague-Questions
    (QuestionData
        (question-id colleague-why)
        (question-text "Why?")
        (question-answers
            give-advice "To give advice"
            ask-advice "To ask for advice"
            gripe-work "To gripe about work"
        )
    )

)

(deffacts Graph-Group-Questions
    (QuestionData
        (question-id is-it-official)
        (question-text "Is it an official function?")
        (question-answers
            yes "Yes"
            no "No"
        )
    )
)

(deffacts Graph-Client-Questions
    (QuestionData
        (question-id client-why)
        (question-text "Why?")
        (question-answers
            close-deal "You're trying to close a deal..."
        )
    )
)

(deffacts Results
    (ResultData
        (result-id martini)
        (recommendation "Martini")
    )
    (ResultData
        (result-id wine)
        (recommendation "wine")
    )
    (ResultData
        (result-id beer)
        (recommendation "Beer")
    )
    (ResultData
        (result-id bubbly)
        (recommendation "Bubbly")
    )
    (ResultData
        (result-id fancy)
        (recommendation "Fancy Cocktail")
    )
    (ResultData
        (result-id highball)
        (recommendation "Highball")
    )
    (ResultData
        (result-id lowball)
        (recommendation "Lowball")
    )
    (ResultData
        (result-id non-alcoholic)
        (recommendation "Non-Alcoholic")
    )
    (ResultData
        (result-id stop-life)
        (recommendation "STOP Get a life")
    )
    (ResultData
        (result-id stop-office)
        (recommendation "STOP Do this in office")
    )
)

(defrule Next-Question
?user_answer <- (UserAnswer (question-id ?current-id) (question-answer ?choice))
(Transition (current-question-id ?current-id) (answer ?choice) (next-question-id ?next-question-id))
(QuestionData (question-id ?next-question-id) (question-text ?new-text) (question-answers $?new-answers))
?old-question <- (Question (question-id ?current-id))
?oldpath <- (CurrentPath (path $?old-path))
=>
(assert (Question (question-id ?next-question-id) (question-text ?new-text) (question-answers $?new-answers)))
(retract ?old-question)
(retract ?user_answer)
(retract ?oldpath)
(assert (CurrentPath (path $?old-path ?choice ?next-question-id)))
)

(defrule Give-Result
?user_answer <- (UserAnswer (question-id ?current-id) (question-answer ?choice))
(Transition (current-question-id ?current-id) (answer ?choice) (next-question-id ?result-id))
(ResultData (result-id ?result-id) (recommendation ?new-text))
?old-question <- (Question (question-id ?current-id))
?oldpath <- (CurrentPath (path $?old-path))
=>
(retract ?old-question)
(retract ?user_answer)
(retract ?oldpath)
(assert (Result (result-id ?result-id) (recommendation ?new-text) (path $?old-path ?choice ?result-id)))
)





