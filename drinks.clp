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

(deftemplate QuestionData
    (slot question-id (type SYMBOL))
    (slot question-text (type STRING))
    (multislot question-answers)
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

(deffacts Graph-Start-Question
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
        (next-question-id boss-asking-for-raise)
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



(deffacts Graph-Boss-Questions
    (QuestionData
        (question-id ask-to-drinks)
        (question-text "Did he or she ask you to drinks?")
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


(defrule Next-Question
?user_answer <- (UserAnswer (question-id ?current-id) (question-answer ?choice))
(Transition (current-question-id ?current-id) (answer ?choice) (next-question-id ?next-question-id))
(QuestionData (question-id ?next-question-id) (question-text ?new-text) (question-answers $?new-answers))
?old-question <- (Question (question-id ?current-id))
=>
(assert (Question (question-id ?next-question-id) (question-text ?new-text) (question-answers $?new-answers)))
(retract ?old-question)
(retract ?user_answer)
)





