import clips

env = clips.Environment()
env.load("drinks.clp")
env.reset()
while (1):
    question = None
    facts = env.facts()
    for fact in facts:
        if (fact.template.name == "Question"):
            question = fact
            break
    if question is None:
        print("Koniec pytan :)")
        break
    print(f"Question: {question['question-text']}")
    y = 1
    for i in range(1,len(question['question-answers']),2):
        print(f"{y}. {question['question-answers'][i]}")
        y+=1
    user_answer_index = int(input("Podaj odpowiedz: ")) - 1
    selected_answer = question['question-answers'][user_answer_index*2]
    print(f"Your answer: {selected_answer}")
    env.assert_string(f"(UserAnswer (question-id {question['question-id']}) (question-answer {selected_answer}))")
    env.run()