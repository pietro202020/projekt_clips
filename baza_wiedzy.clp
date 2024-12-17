;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Szablon startowy: brak wyników, brak pytań, brak odpowiedzi
;; Tworzymy pierwsze pytanie.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule start
   (not (exists (wynik $?)))
   (not (exists (pytanie $?)))
   (not (exists (odpowiedz $?)))
   =>
   (assert (pytanie "What type of game are you looking for?" "I want a Wargame" "A Strategy Game")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Wybór główny: Wargame czy A Strategy Game
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule choose-wargame
   ?o <- (odpowiedz "I want a Wargame")
   ?p <- (pytanie "What type of game are you looking for?" "I want a Wargame" "A Strategy Game")
   =>
   (retract ?o ?p)
   (assert (pytanie "For how many players?" "Just me" "2 or more")))

(defrule choose-strategy
   ?o <- (odpowiedz "A Strategy Game")
   ?p <- (pytanie "What type of game are you looking for?" "I want a Wargame" "A Strategy Game")
   =>
   (retract ?o ?p)
   (assert (wynik "Not implemented for A Strategy Game")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WARGAME ŚCIEŻKA
;; For how many players?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule wargame-just-me
   ?o <- (odpowiedz "Just me")
   ?p <- (pytanie "For how many players?" "Just me" "2 or more")
   =>
   (retract ?o ?p)
   (assert (pytanie "Which theme do you prefer?" "Historic Battles" "Modern Air Support" "Science Fiction")))

(defrule wargame-2plus
   ?o <- (odpowiedz "2 or more")
   ?p <- (pytanie "For how many players?" "Just me" "2 or more")
   =>
   (retract ?o ?p)
   (assert (pytanie "Do you have any wargaming experience?" "It's new to me" "Yes")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WARGAME + JUST ME
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule wargame-just-me-historic
   ?o <- (odpowiedz "Historic Battles")
   ?p <- (pytanie "Which theme do you prefer?" "Historic Battles" "Modern Air Support" "Science Fiction")
   =>
   (retract ?o ?p)
   (assert (wynik "Field Commander Series (Historic Battles)")))

(defrule wargame-just-me-modern
   ?o <- (odpowiedz "Modern Air Support")
   ?p <- (pytanie "Which theme do you prefer?" "Historic Battles" "Modern Air Support" "Science Fiction")
   =>
   (retract ?o ?p)
   (assert (wynik "Thunderbolt: Apache Leader (Modern Air Support)")))

(defrule wargame-just-me-scifi
   ?o <- (odpowiedz "Science Fiction")
   ?p <- (pytanie "Which theme do you prefer?" "Historic Battles" "Modern Air Support" "Science Fiction")
   =>
   (retract ?o ?p)
   (assert (wynik "Space Infantry (Science Fiction)")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WARGAME + 2 or more
;; Pytanie o doświadczenie
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule wargame-2plus-new
   ?o <- (odpowiedz "It's new to me")
   ?p <- (pytanie "Do you have any wargaming experience?" "It's new to me" "Yes")
   =>
   (retract ?o ?p)
   (assert (pytanie "Are you a fan of Risk?" "Yes" "No")))

(defrule wargame-2plus-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "Do you have any wargaming experience?" "It's new to me" "Yes")
   =>
   (retract ?o ?p)
   (assert (pytanie "Want to command Roman legions?" "Yes" "No")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; It's new to me -> Are you a fan of Risk?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule wargame-risk-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "Are you a fan of Risk?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (wynik "Risk: Legacy")))

(defrule wargame-risk-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "Are you a fan of Risk?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "World history, or high fantasy?" "World history" "High fantasy")))

(defrule wargame-new-world
   ?o <- (odpowiedz "World history")
   ?p <- (pytanie "World history, or high fantasy?" "World history" "High fantasy")
   =>
   (retract ?o ?p)
   (assert (wynik "Memoir '44 (History)")))

(defrule wargame-new-fantasy
   ?o <- (odpowiedz "High fantasy")
   ?p <- (pytanie "World history, or high fantasy?" "World history" "High fantasy")
   =>
   (retract ?o ?p)
   (assert (wynik "Battles of Westeros (Fantasy)")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Experience = Yes -> Want to command Roman legions?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule wargame-roman-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "Want to command Roman legions?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (wynik "Commands & Colors: Ancients")))

(defrule wargame-roman-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "Want to command Roman legions?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "Lead 19th Century battle lines?" "Yes" "No")))

(defrule wargame-19th-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "Lead 19th Century battle lines?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (wynik "1812: The Invasion of Canada")))

(defrule wargame-19th-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "Lead 19th Century battle lines?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "How about World War II?" "Yes" "No")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; World War II?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule wargame-ww2-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "How about World War II?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "Card- or dice-driven combat?" "Card" "Dice")))

(defrule wargame-ww2-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "How about World War II?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "Modern Warfare, then?" "Yes, I like the immediacy" "No, I'm tired of real wars")))

(defrule wargame-ww2-card
   ?o <- (odpowiedz "Card")
   ?p <- (pytanie "Card- or dice-driven combat?" "Card" "Dice")
   =>
   (retract ?o ?p)
   (assert (wynik "Combat Commander Series (shuffle shuffle)")))

(defrule wargame-ww2-dice
   ?o <- (odpowiedz "Dice")
   ?p <- (pytanie "Card- or dice-driven combat?" "Card" "Dice")
   =>
   (retract ?o ?p)
   (assert (wynik "Tide of Iron (roll roll roll)")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Modern Warfare
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule wargame-modern-yes
   ?o <- (odpowiedz "Yes, I like the immediacy")
   ?p <- (pytanie "Modern Warfare, then?" "Yes, I like the immediacy" "No, I'm tired of real wars")
   =>
   (retract ?o ?p)
   (assert (wynik "Labyrinth: The War on Terror")))

(defrule wargame-modern-no
   ?o <- (odpowiedz "No, I'm tired of real wars")
   ?p <- (pytanie "Modern Warfare, then?" "Yes, I like the immediacy" "No, I'm tired of real wars")
   =>
   (retract ?o ?p)
   (assert (pytanie "Science Fictions or alternate history?" "Alt-History" "Science Fiction")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sci-Fi or Alt-History
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule wargame-alt
   ?o <- (odpowiedz "Alt-History")
   ?p <- (pytanie "Science Fictions or alternate history?" "Alt-History" "Science Fiction")
   =>
   (retract ?o ?p)
   (assert (pytanie "Tactical miniatures, or large-scale strategy?" "Tactical miniatures" "Large-scale strategy")))

(defrule wargame-scifi
   ?o <- (odpowiedz "Science Fiction")
   ?p <- (pytanie "Science Fictions or alternate history?" "Alt-History" "Science Fiction")
   =>
   (retract ?o ?p)
   (assert (pytanie "Space ships or giant robots?" "Space ships" "Giant robots")))

(defrule wargame-alt-tactical
   ?o <- (odpowiedz "Tactical miniatures")
   ?p <- (pytanie "Tactical miniatures, or large-scale strategy?" "Tactical miniatures" "Large-scale strategy")
   =>
   (retract ?o ?p)
   (assert (wynik "Dust Tactics (Tactical)")))

(defrule wargame-alt-strategy
   ?o <- (odpowiedz "Large-scale strategy")
   ?p <- (pytanie "Tactical miniatures, or large-scale strategy?" "Tactical miniatures" "Large-scale strategy")
   =>
   (retract ?o ?p)
   (assert (wynik "Fortress America (Strategic)")))

(defrule wargame-scifi-ships
   ?o <- (odpowiedz "Space ships")
   ?p <- (pytanie "Space ships or giant robots?" "Space ships" "Giant robots")
   =>
   (retract ?o ?p)
   (assert (wynik "Battleship Galaxies (Ships)")))

(defrule wargame-scifi-robots
   ?o <- (odpowiedz "Giant robots")
   ?p <- (pytanie "Space ships or giant robots?" "Space ships" "Giant robots")
   =>
   (retract ?o ?p)
   (assert (wynik "Battletech (Mechs)")))
