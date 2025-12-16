;; =========================================================
;; 1. SZABLONY DANYCH (TEMPLATES)
;; =========================================================

(deftemplate Question
    (slot id (type SYMBOL))
    (slot type (type SYMBOL) (allowed-values single-choice multi-choice))
    (multislot valid-answers)
)

(deftemplate User-Response
    (slot question-id (type SYMBOL))
    (slot value (type SYMBOL))
)

(deftemplate Current-Question
    (slot id (type SYMBOL))
)

(deftemplate Context
    (slot companion (type SYMBOL) (allowed-values nil boss colleague group client) (default nil))
    (slot initiator (type SYMBOL) (allowed-values nil external me) (default nil))
    (slot is-celebrating (type SYMBOL) (allowed-values nil yes no) (default nil))
    (slot is-worried (type SYMBOL) (allowed-values nil yes no) (default nil))
    (slot will-talk-back (type SYMBOL) (allowed-values nil yes no) (default nil))
    (slot sexual-advances (type SYMBOL) (allowed-values nil yes no) (default nil))
    (slot intent (type SYMBOL) (allowed-values nil raise promotion seduction other) (default nil))
    (slot is-good-idea (type SYMBOL) (allowed-values nil yes no) (default nil))
    (slot client-intent (type SYMBOL) (allowed-values nil close-deal shmoozing no-agenda) (default nil))
    (slot client-habit (type SYMBOL) (allowed-values nil heavy-drinker light-drinker) (default nil))
    (slot client-restriction (type SYMBOL) (allowed-values nil none mormon) (default nil))
    (slot obligation (type SYMBOL) (allowed-values nil keep-up relax) (default nil))
    (slot dining-plan (type SYMBOL) (allowed-values nil dinner-after no-dinner) (default nil))
    (slot budget (type SYMBOL) (allowed-values nil low high) (default nil))
    (slot atmosphere (type SYMBOL) (allowed-values nil professional casual formal romantic) (default nil))
    (slot colleague-reason (type SYMBOL) (allowed-values nil gripe ask-advice give-advice) (default nil))
    (slot expense-covered (type SYMBOL) (allowed-values nil yes no) (default nil))
    (slot companion-gender (type SYMBOL) (allowed-values nil male female) (default nil))
    (slot is-girls-night (type SYMBOL) (allowed-values nil yes no) (default nil))
    (slot fired-risk (type SYMBOL) (allowed-values nil yes no) (default nil))
    (slot promotion-scheme (type SYMBOL) (allowed-values nil yes no) (default nil))
    (slot useful-contact (type SYMBOL) (allowed-values nil yes no) (default nil))
    (slot bitchfest-risk (type SYMBOL) (allowed-values nil yes no) (default nil))
    (slot handle-truth (type SYMBOL) (allowed-values nil yes no) (default nil))
    (slot performance-warning (type SYMBOL) (allowed-values nil yes no) (default nil))
    (slot is-crier (type SYMBOL) (allowed-values nil yes no) (default nil))
    (slot is-official (type SYMBOL) (allowed-values nil yes no) (default nil))
    (slot event-type (type SYMBOL) (allowed-values nil performance-reward holiday-party going-away) (default nil))
    (slot like-people (type SYMBOL) (allowed-values nil yes no) (default nil))
    (slot write-off (type SYMBOL) (allowed-values nil yes no) (default nil))
    (slot like-guest (type SYMBOL) (allowed-values nil yes no) (default nil))
    (slot get-wasted (type SYMBOL) (allowed-values nil yes no) (default nil))
    (slot is-friday (type SYMBOL) (allowed-values nil yes no) (default nil))
    (slot career-long (type SYMBOL) (allowed-values nil yes no) (default nil))
    (slot major (type SYMBOL) (allowed-values nil yes no) (default nil))
)

(deftemplate Drink-Profile
    (slot alcohol-content (type SYMBOL) (allowed-values nil zero low medium high))
    (slot impression (type SYMBOL) (allowed-values nil power-move camouflage safe-bet sophisticated casual party fancy))
    (slot pacing (type SYMBOL) (allowed-values nil sip-slow session-drink shot quick-exit))
    (slot risk-tolerance (type SYMBOL) (allowed-values nil strict loose))
    (slot budget (type SYMBOL) (allowed-values nil cheap standard premium))
    (slot restriction (type SYMBOL) (allowed-values nil stop-office stop-life))
    (slot style (type SYMBOL) (allowed-values nil classy bubbly fancy basic highball casual beer lowball))
)

;; WYNIK KOŃCOWY
(deftemplate Recommendation
    (slot name (type SYMBOL))
)

;; =========================================================
;; 2. FAKTY STATYCZNE (BAZA PYTAŃ)
;; =========================================================


(deffacts Question-Database
    ;; 1 Pytanie o osobę towarzyszaca
    (Question (id q-who) (type single-choice) (valid-answers boss colleague group client))

    ;; --- PYTANIA ŚCIEŻKI BOSS ---
    (Question (id q-boss-invited) (type single-choice) (valid-answers yes no))
    (Question (id q-boss-celebrating) (type single-choice) (valid-answers yes no))
    (Question (id q-boss-trouble) (type single-choice) (valid-answers yes no))
    (Question (id q-talk-back) (type single-choice) (valid-answers yes no))
    (Question (id q-boss-sleep) (type single-choice) (valid-answers yes no))
    (Question (id q-boss-my-intent) (type single-choice) (valid-answers raise promotion seduction other))
    (Question (id q-boss-good-idea) (type single-choice) (valid-answers yes no))

    ;; --- PYTANIA ŚCIEŻKI CLIENT ---
    
    (Question (id q-client-intent) (type single-choice) (valid-answers close-deal shmoozing no-agenda))
    (Question (id q-expense-account) (type single-choice) (valid-answers yes no))
    (Question (id q-dinner) (type single-choice) (valid-answers yes no))
    (Question (id q-client-drinker) (type single-choice) (valid-answers yes no))
    (Question (id q-client-mormon) (type single-choice) (valid-answers yes no))
    (Question (id q-keep-up) (type single-choice) (valid-answers yes no))

    ;; --- PYTANIA ŚCIEŻKI COLLEAGUE ---
    (Question (id q-col-reason) (type single-choice) (valid-answers gripe ask-advice give-advice))
    (Question (id q-col-expensable) (type single-choice) (valid-answers yes no))
    (Question (id q-col-companion-gender) (type single-choice) (valid-answers male female))
    (Question (id q-col-girls-night) (type single-choice) (valid-answers yes no))
    (Question (id q-col-fired) (type single-choice) (valid-answers yes no))
    (Question (id q-col-promotion) (type single-choice) (valid-answers yes no))
    (Question (id q-col-helper) (type single-choice) (valid-answers yes no))
    (Question (id q-col-bitchfest) (type single-choice) (valid-answers yes no))
    (Question (id q-col-invited) (type single-choice) (valid-answers yes no))
    (Question (id q-col-handle-truth) (type single-choice) (valid-answers yes no))
    (Question (id q-col-perf-warning) (type single-choice) (valid-answers yes no))
    (Question (id q-col-crier) (type single-choice) (valid-answers yes no))

    ;; Pytania ścieżki GROUP
    (Question (id q-official) (type single-choice) (valid-answers yes no))
    (Question (id q-event-type) (type single-choice) (valid-answers performance-reward holiday-party going-away)) ;; Is it a..?
    (Question (id q-like-people) (type single-choice) (valid-answers yes no))
    (Question (id q-write-off) (type single-choice) (valid-answers yes no))
    (Question (id q-like-guest) (type single-choice) (valid-answers yes no))
    (Question (id q-wasted) (type single-choice) (valid-answers yes no))
    (Question (id q-friday) (type single-choice) (valid-answers yes no))
    (Question (id q-career) (type single-choice) (valid-answers yes no))
    (Question (id q-major) (type single-choice) (valid-answers yes no))
)

(deffacts System-Start
    (Context)
)

(defrule Remove-Old-Question
    (declare (salience 20))
    ?q <- (Current-Question (id ?id))
    (User-Response (question-id ?id))
    =>
    (retract ?q)
)

;; ---------------------------------------------------------
;; WARSTWA 1: DIALOG (ASKER)
;; ---------------------------------------------------------
(defrule Ask-Who
    (Context (companion nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-who)))
)
(defrule Boss-Ask-Invited
    (Context (companion boss) (initiator nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-boss-invited)))
)
(defrule Boss-Ask-Celebrating
    (Context (companion boss) (initiator external) (is-celebrating nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-boss-celebrating)))
)
(defrule Boss-Ask-Trouble
    (Context (companion boss) (initiator external) (is-celebrating no) (is-worried nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-boss-trouble)))
)
(defrule Boss-Ask-TalkBack
    (Context (companion boss) (initiator external) (is-worried yes) (will-talk-back nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-talk-back)))
)
(defrule Boss-Ask-Sleep
    (or
    (Context (companion boss) (initiator external) (is-worried no) (sexual-advances nil))
    (Context (companion boss) (initiator me) (intent other))
    )
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-boss-sleep)))
)
(defrule Boss-Ask-Intent
    (Context (companion boss) (initiator me) (intent nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-boss-my-intent)))
)
(defrule Boss-Ask-GoodIdea
    (Context (companion boss) (initiator me) (intent seduction) (is-good-idea nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-boss-good-idea)))
)

;; ---------------------------------------------------------
;; WARSTWA 1: ASKER (CLIENT PATH)
;; ---------------------------------------------------------
(defrule Client-Ask-Intent
    (Context (companion client) (client-intent nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-client-intent)))
)
(defrule Client-Ask-Expense
    (Context (companion client) (client-intent close-deal) (budget nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-expense-account)))
)
(defrule Client-Ask-Dinner
    (Context (companion client) (client-intent close-deal) (budget high) (dining-plan nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-dinner)))
)
(defrule Client-Ask-Drinker-Type
    (Context (companion client) (client-intent shmoozing) (client-habit nil))
    
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-client-drinker)))
)
(defrule Client-Ask-Mormon
    (Context (companion client) (client-intent shmoozing) (client-habit light-drinker) (client-restriction nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-client-mormon)))
)
(defrule Client-Ask-Keep-Up
    (Context (companion client) (client-intent shmoozing) (client-habit heavy-drinker) (obligation nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-keep-up)))
)
;; --- ŚCIEŻKA COLLEAGUE ---
(defrule Colleague-Ask-Reason
    (Context (companion colleague) (colleague-reason nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-col-reason)))
)
(defrule Colleague-Ask-Expensable
    (Context (companion colleague) (colleague-reason gripe) (expense-covered nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-col-expensable)))
)
(defrule Colleague-Ask-Gender
    (Context (companion colleague) (colleague-reason gripe) (expense-covered yes) (companion-gender nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-col-companion-gender)))
)
(defrule Colleague-Ask-GirlsNight
    (Context (companion colleague) (colleague-reason gripe) (expense-covered yes) (companion-gender female) (is-girls-night nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-col-girls-night)))
)
(defrule Colleague-Ask-Fired
    (Context (companion colleague) (colleague-reason ask-advice) (fired-risk nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-col-fired)))
)
(defrule Colleague-Ask-Promotion
    (Context (companion colleague) (colleague-reason ask-advice) (fired-risk no) (promotion-scheme nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-col-promotion)))
)
(defrule Colleague-Ask-Helper
    (Context (companion colleague) (colleague-reason ask-advice) (promotion-scheme yes) (useful-contact nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-col-helper)))
)
(defrule Colleague-Ask-Bitchfest
    (Context (companion colleague) (colleague-reason ask-advice) (bitchfest-risk nil))
    (or (Context (promotion-scheme no)) 
        (Context (useful-contact no)))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-col-bitchfest)))
)
(defrule Colleague-Ask-Invited
    (Context (companion colleague) (colleague-reason give-advice) (initiator nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-col-invited)))
)
(defrule Colleague-Ask-HandleTruth
    (Context (companion colleague) (colleague-reason give-advice) (initiator external) (handle-truth nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-col-handle-truth)))
)
(defrule Colleague-Ask-PerfWarning
    (Context (companion colleague) (colleague-reason give-advice) (initiator me) (performance-warning nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-col-perf-warning)))
)
(defrule Colleague-Ask-Crier
    (Context (companion colleague) (colleague-reason give-advice) (is-crier nil))
    (or (Context (handle-truth no))
        (Context (performance-warning yes)))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-col-crier)))
)
;; --- ŚCIEŻKA GROUP ---
(defrule Group-Ask-Official
    (Context (companion group) (is-official nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-official)))
)
(defrule Group-Ask-Event-Type
    (Context (companion group) (is-official yes) (event-type nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-event-type)))
)
(defrule Group-Ask-Like-People
    (Context (companion group) (is-official no) (like-people nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-like-people)))
)
(defrule Group-Ask-Write-Off
    (Context (companion group) (like-people yes) (write-off nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-write-off)))
)
(defrule Group-Ask-Like-Guest
    (Context (companion group) (event-type going-away) (like-guest nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-like-guest)))
)
(defrule Group-Ask-Wasted-Holiday
    (Context (companion group) (event-type holiday-party) (get-wasted nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-wasted)))
)
(defrule Group-Ask-Wasted-Major
    (Context (companion group) (event-type performance-reward) (major yes) (get-wasted nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-wasted)))
)
(defrule Group-Ask-Major
    (Context (companion group) (event-type performance-reward) (major nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-major)))
)
(defrule Group-Ask-Friday
    (Context (companion group) (get-wasted yes) (is-friday nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-friday)))
)
(defrule Group-Ask-Career

    (Context (companion group) (is-friday no) (career-long nil))
    (not (Current-Question))
    =>
    (assert (Current-Question (id q-career)))
)
;; ---------------------------------------------------------
;; WARSTWA 2: PRZETWARZANIE ODPOWIEDZI BOSS (LISTENER)
;; ---------------------------------------------------------
(defrule Process-Companion
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-who) (value ?val))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (companion ?val))
)
(defrule Process-Boss-Invited-Yes
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-boss-invited) (value yes))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (initiator external))
)
(defrule Process-Boss-Invited-No
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-boss-invited) (value no))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (initiator me))
)
(defrule Process-Boss-Celebrating
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-boss-celebrating) (value ?val)) ;; yes/no
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (is-celebrating ?val))
)
(defrule Process-Boss-Trouble
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-boss-trouble) (value ?val)) ;; yes/no
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (is-worried ?val))
)
(defrule Process-Talk-Back
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-talk-back) (value ?val)) ;; yes/no
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (will-talk-back ?val))
)
(defrule Process-Boss-Sleep
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-boss-sleep) (value ?val)) ;; yes/no
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (sexual-advances ?val))
)
(defrule Process-My-Intent
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-boss-my-intent) (value ?val))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (intent ?val))
)
(defrule Process-Good-Idea
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-boss-good-idea) (value ?val)) ;; yes/no
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (is-good-idea ?val))
)
;; ---------------------------------------------------------
;; WARSTWA 2: LISTENER (CLIENT PATH)
;; ---------------------------------------------------------
(defrule Process-Client-Intent
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-client-intent) (value ?val))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (client-intent ?val))
)
(defrule Process-Client-Expense-High
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-expense-account) (value yes))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (budget high))
)
(defrule Process-Client-Expense-Low
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-expense-account) (value no))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (budget low))
)
(defrule Process-Client-Dinner-Yes
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-dinner) (value yes))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (dining-plan dinner-after))
)
(defrule Process-Client-Dinner-No
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-dinner) (value no))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (dining-plan no-dinner))
)
(defrule Process-Client-Drinker-Heavy
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-client-drinker) (value yes))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (client-habit heavy-drinker))
)
(defrule Process-Client-Drinker-Light
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-client-drinker) (value no))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (client-habit light-drinker))
)
(defrule Process-Client-Mormon-Yes
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-client-mormon) (value yes))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (client-restriction mormon))
)
(defrule Process-Client-Mormon-No
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-client-mormon) (value no))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (client-restriction none))
)
(defrule Process-Client-KeepUp-Yes
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-keep-up) (value yes))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (obligation keep-up))
)
(defrule Process-Client-KeepUp-No
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-keep-up) (value no))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (obligation relax))
)
(defrule Process-Official
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-official) (value ?val))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (is-official ?val))
)
(defrule Process-Event-Type
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-event-type) (value ?val))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (event-type ?val))
)
(defrule Process-Like-People
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-like-people) (value ?val))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (like-people ?val))
)
(defrule Process-Write-Off
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-write-off) (value ?val))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (write-off ?val))
)
(defrule Process-Like-Guest
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-like-guest) (value yes))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (like-guest yes))
)
(defrule Process-Dislike-Guest
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-like-guest) (value no))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (like-guest no))
)
(defrule Process-Major
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-major) (value ?val))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (major ?val))
)
(defrule Process-Wasted
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-wasted) (value ?val))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (get-wasted ?val))
)
(defrule Process-Friday
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-friday) (value ?val))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (is-friday ?val))
)
(defrule Process-Career
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-career) (value ?val))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (career-long ?val))
)

;; --- OBSŁUGA COLLEAGUE ---
(defrule Process-Col-Reason
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-col-reason) (value ?val))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (colleague-reason ?val))
)
(defrule Process-Col-Expensable
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-col-expensable) (value ?val))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (expense-covered ?val))
)
(defrule Process-Col-Gender
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-col-companion-gender) (value ?val))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (companion-gender ?val))
)
(defrule Process-Col-GirlsNight
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-col-girls-night) (value ?val))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (is-girls-night ?val))
)
(defrule Process-Col-Fired
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-col-fired) (value ?val))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (fired-risk ?val))
)
(defrule Process-Col-Promotion
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-col-promotion) (value ?val))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (promotion-scheme ?val))
)
(defrule Process-Col-Helper
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-col-helper) (value ?val))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (useful-contact ?val))
)
(defrule Process-Col-Bitchfest
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-col-bitchfest) (value ?val))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (bitchfest-risk ?val))
)
(defrule Process-Col-Invited-Yes
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-col-invited) (value yes))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (initiator external))
)
(defrule Process-Col-Invited-No
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-col-invited) (value no))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (initiator me))
)
(defrule Process-Col-HandleTruth
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-col-handle-truth) (value ?val))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (handle-truth ?val))
)
(defrule Process-Col-PerfWarning
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-col-perf-warning) (value ?val))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (performance-warning ?val))
)
(defrule Process-Col-Crier
    (declare (salience 10))
    ?ans <- (User-Response (question-id q-col-crier) (value ?val))
    ?ctx <- (Context)
    =>
    (retract ?ans)
    (modify ?ctx (is-crier ?val))
)
;; ---------------------------------------------------------
;; WARSTWA 3: LOGIKA BIZNESOWA (PROFILER)
;; Buduje profil na podstawie stanu Context.
;; ---------------------------------------------------------
(defrule Profile-Boss-Celebration
    (Context (companion boss) (initiator external) (is-celebrating yes))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style bubbly) (alcohol-content low)))
)
(defrule Profile-Boss-Trouble-TalkBack
    (Context (companion boss) (initiator external) (is-worried yes) (will-talk-back yes))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (alcohol-content zero) (style basic)))
)
(defrule Profile-Boss-Trouble-Humble
    (Context (companion boss) (initiator external) (is-worried yes) (will-talk-back no))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style classy) (alcohol-content low)))
)
(defrule Profile-Boss-Sexual-Advances
    (Context (companion boss) (initiator external) (is-worried no) (sexual-advances yes))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (alcohol-content zero) (style basic)))
)
(defrule Profile-Boss-Normal
    (Context (companion boss) (initiator external) (is-worried no) (sexual-advances no))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style classy) (alcohol-content low)))
)
(defrule Profile-Boss-Career
    (Context (companion boss) (initiator me) (intent raise|promotion))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (restriction stop-office) (alcohol-content zero)))
)
(defrule Profile-Boss-Seduction-BadIdea
    (Context (companion boss) (initiator me) (intent seduction) (is-good-idea no))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style classy) (alcohol-content high)))
)
(defrule Profile-Boss-Seduction-GoodIdea
    (Context (companion boss) (initiator me) (intent seduction) (is-good-idea yes))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style fancy) (alcohol-content high)))
)
(defrule other-intent-without-sexual
    (Context (companion boss) (initiator me) (intent other) (sexual-advances no))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style classy) (alcohol-content low)))
)
(defrule other-intent-with-sexual
    (Context (companion boss) (initiator me) (intent other) (sexual-advances yes))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (alcohol-content zero)))
)
;; ---------------------------------------------------------
;; WARSTWA 3: PROFILER (CLIENT PATH)
;; ---------------------------------------------------------

(defrule Profile-Client-NoLife
    (Context (companion client) (client-intent no-agenda))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (restriction stop-life)))
)
(defrule Profile-Client-Martini
    (Context (companion client) (client-intent close-deal) (budget high) (dining-plan dinner-after))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style classy) (alcohol-content high))) ;; Martini
)
(defrule Profile-Client-Classic-NoDinner
    (Context (companion client) (client-intent close-deal) (budget high) (dining-plan no-dinner))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style classy) (alcohol-content low)))
)
(defrule Profile-Client-Fancy-LowBudget
    (Context (companion client) (client-intent close-deal) (budget low))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style fancy)))
)
(defrule Profile-Client-Highball
    (Context (companion client) (client-intent shmoozing) (client-habit heavy-drinker) (obligation keep-up))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style highball)))
)
(defrule Profile-Client-Shmooze-Fancy
    (Context (companion client) (client-intent shmoozing) (client-habit heavy-drinker) (obligation relax))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style fancy)))
)
(defrule Profile-Client-Mormon
    (Context (companion client) (client-intent shmoozing) (client-habit light-drinker) (client-restriction mormon))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (alcohol-content zero)))
)
(defrule Profile-Client-Wine
    (Context (companion client) (client-intent shmoozing) (client-habit light-drinker) (client-restriction none))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style classy) (alcohol-content low)))
)

;; --- COLLEAGUE ---
(defrule Prof-Col-Gripe-NoExpense
    (Context (colleague-reason gripe) (expense-covered no))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style casual) (budget cheap))) ;; Beer profile
)
(defrule Prof-Col-Gripe-Expense-Male
    (Context (colleague-reason gripe) (expense-covered yes) (companion-gender male))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style lowball)))
)
(defrule Prof-Col-Gripe-GirlsNight
    (Context (colleague-reason gripe) (expense-covered yes) (companion-gender female) (is-girls-night yes))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style fancy)))
)
(defrule Prof-Col-Gripe-NotGirlsNight
    (Context (colleague-reason gripe) (expense-covered yes) (companion-gender female) (is-girls-night no))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style casual) (budget cheap))) ;; Beer
)
(defrule Prof-Col-Fired
    (Context (colleague-reason ask-advice) (fired-risk yes))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style classy) (alcohol-content high)))
)
(defrule Prof-Col-Promotion-Helper
    (Context (colleague-reason ask-advice) (fired-risk no) (promotion-scheme yes) (useful-contact yes))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style classy) (alcohol-content low)))
)
(defrule Prof-Col-Bitchfest-Yes
    (Context (colleague-reason ask-advice) (bitchfest-risk yes))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style casual) (budget cheap)))
)
(defrule Prof-Col-Bitchfest-No
    (Context (colleague-reason ask-advice) (bitchfest-risk no))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style highball)))
)
(defrule Prof-Col-Give-HandleTruth
    (Context (colleague-reason give-advice) (initiator external) (handle-truth yes))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style classy) (alcohol-content low)))
)
(defrule Prof-Col-Give-NoWarning
    (Context (colleague-reason give-advice) (initiator me) (performance-warning no))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style lowball)))
)
(defrule Prof-Col-Crier-Yes
    (Context (colleague-reason give-advice) (is-crier yes))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style classy) (alcohol-content high)))
)
(defrule Prof-Col-Crier-No
    (Context (colleague-reason give-advice) (is-crier no))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style fancy)))
)

;; -----------GROUP-----------
(defrule Profile-Group-NoLike
    (Context (companion group) (is-official no) (like-people no))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style fancy)))
)
(defrule Profile-Group-Like-NoWriteOff
    (Context (companion group) (is-official no) (like-people yes) (write-off no))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style casual) (budget cheap)))
)
(defrule Profile-Group-Like-WriteOff
    (Context (companion group) (is-official no) (like-people yes) (write-off yes))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style lowball)))
)
(defrule Profile-Group-Away-Like
    (Context (companion group) (event-type going-away) (like-guest yes))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style bubbly)))
)
(defrule Profile-Group-Holiday-NoWasted
    (Context (companion group) (event-type holiday-party) (get-wasted no))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style classy) (alcohol-content low)))
)
(defrule Profile-Group-Holiday-Wasted-NotFriday
    (Context (companion group) (get-wasted yes) (is-friday no))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style classy) (alcohol-content high)))
)
(defrule Profile-Group-Holiday-Wasted-Friday-ShortTerm
    (Context (companion group) (is-friday yes) (career-long no))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style classy) (alcohol-content high)))
)
(defrule Profile-Group-Holiday-Wasted-Friday-LongTerm
    (Context (companion group) (is-friday yes) (career-long yes))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style bubbly)))
)
(defrule Profile-Reward-Not-Major
    (Context (companion group) (event-type performance-reward) (major no))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style highball)))
)
(defrule Profile-Friday-Wasted
    (Context (companion group) (is-friday yes))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (style classy) (alcohol-content high)))
)
(defrule dislike-guest
    (Context (companion group) (like-guest no))
    (not (Drink-Profile))
    =>
    (assert (Drink-Profile (restriction stop-life)))
)
;; ---------------------------------------------------------
;; WARSTWA 4: REKOMENDACJA (RECOMMENDER)
;; ---------------------------------------------------------
(defrule Recommend-Office
    (Drink-Profile (restriction stop-office) (alcohol-content zero))
    =>
    (assert (Recommendation (name drink-stop-office)))
)
(defrule Recommend-Life
    (Drink-Profile (restriction stop-life))
    =>
    (assert (Recommendation (name drink-stop-life)))
)
(defrule Recommend-Martini
    (Drink-Profile (style classy) (alcohol-content high))
    =>
    (assert (Recommendation (name drink-martini)))
)
(defrule Recommend-Wine
    (Drink-Profile (style classy) (alcohol-content low))
    =>
    (assert (Recommendation (name drink-wine)))
)
(defrule Recommend-Bubbly
    (Drink-Profile (style bubbly))
    =>
    (assert (Recommendation (name drink-bubbly))) 
)
(defrule Recommend-Fancy
    (Drink-Profile (style fancy))
    =>
    (assert (Recommendation (name drink-fancy)))
)
(defrule Recommend-Zero
    (Drink-Profile (alcohol-content zero) (restriction nil))
    =>
    (assert (Recommendation (name drink-zero)))
)
(defrule Recommend-Highball
    (Drink-Profile (style highball))
    =>
    (assert (Recommendation (name drink-highball)))
)
(defrule Recommend-Beer
    (Drink-Profile (style casual) (budget cheap))
    =>
    (assert (Recommendation (name drink-beer)))
)
(defrule Recommend-Lowball
    (Drink-Profile (style lowball))
    =>
    (assert (Recommendation (name drink-lowball)))
)