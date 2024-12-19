import clips

def main():
    env = clips.Environment()
    env.load("baza_wiedzy2.clp")

    while True:
        env.run()  # Uruchamiamy reguły

        # Sprawdź, czy jest wynik
        result_fact = None
        for fact in env.facts():
            if fact.template.name == "wynik":
                result_fact = fact
                break

        if result_fact:
            print("\nSuggested Game:", result_fact[0])
            break

        # Sprawdź, czy jest pytanie
        question_fact = None
        for fact in env.facts():
            if fact.template.name == "pytanie":
                question_fact = fact
                break

        if question_fact:
            question = question_fact[0]
            answers = question_fact[1:]
            #Zadanie pytania
            print("\n" + question)
            for i, ans in enumerate(answers, start=1):
                print(f"{i}) {ans}")
            #Wybór odpowiedzi na pytanie
            choice = None
            while True:
                inp = input("Your choice: ")
                try:
                    idx = int(inp) - 1
                    if 0 <= idx < len(answers):
                        choice = answers[idx]
                        break
                    else:
                        print("Invalid choice, try again.")
                except:
                    print("Enter a number.")
            #Dodanie odpowiedzi do puli faktów
            env.assert_string(f'(odpowiedz "{choice}")')

if __name__ == "__main__":
    main()