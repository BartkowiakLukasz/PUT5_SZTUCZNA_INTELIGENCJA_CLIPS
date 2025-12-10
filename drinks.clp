(deftemplate Question
    (slot question-id (type SYMBOL))
    (slot question-text (type STRING))
    (multislot question-answers)
)


(deftemplate UserAnswer
    (slot question-id (type SYMBOL))
    (slot question-answer (type SYMBOL))
)

(deffacts Start
    (Question 
        (question-id start)
        (question-text "Who are you going out for drinks with") 
        (question-answers boss colleague group client)
    )
)