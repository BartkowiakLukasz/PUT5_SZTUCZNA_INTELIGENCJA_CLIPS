import tkinter as tk
from tkinter import messagebox
import clips
import json
import os

CLIPS_FILE = 'logic.clp'
JSON_FILE = 'questions.json'

class DrinksAdvisorGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("System Ekspercki: Doradca Drinków")
        self.root.geometry("600x450")

        self.questions_data = {}
        self.env = None
        self.current_question_id = None

        self.lbl_status = tk.Label(root, text="Start systemu...", font=("Arial", 10), fg="gray")
        self.lbl_status.pack(pady=5)

        self.lbl_main_text = tk.Label(root, text="", font=("Arial", 14, "bold"), wraplength=550, justify="center")
        self.lbl_main_text.pack(pady=20, expand=True, fill="both")

        self.buttons_frame = tk.Frame(root)
        self.buttons_frame.pack(pady=10, fill="both", expand=True)

        self.btn_restart = tk.Button(root, text="Zacznij od nowa", command=self.reset_system, bg="#ffcccb")
        
        self.load_data()
        self.init_clips()
        self.run_step()

    def load_data(self):
        """Wczytuje JSON z pytaniami."""
        if not os.path.exists(JSON_FILE):
            messagebox.showerror("Błąd", f"Nie znaleziono pliku {JSON_FILE}")
            self.root.destroy()
            return
        try:
            with open(JSON_FILE, 'r', encoding='utf-8') as f:
                self.questions_data = json.load(f)
        except Exception as e:
            messagebox.showerror("Błąd JSON", f"Błąd parsowania JSON: {e}")
            self.root.destroy()

    def init_clips(self):
        """Inicjalizuje silnik CLIPS."""
        self.env = clips.Environment()
        try:
            self.env.load(CLIPS_FILE)
        except Exception as e:
            messagebox.showerror("Błąd CLIPS", f"Nie udało się załadować reguł: {e}")
            self.root.destroy()
            return
        self.reset_system()

    def reset_system(self):
        """Resetuje stan CLIPSa i GUI do początku."""
        self.env.reset()
        self.btn_restart.pack_forget()
        self.run_step()

    def clear_buttons(self):
        """Usuwa stare przyciski odpowiedzi."""
        for widget in self.buttons_frame.winfo_children():
            widget.destroy()

    def run_step(self):
        """Główna pętla logiczna - uruchamia CLIPSa i sprawdza fakty."""
        self.env.run()

        recommendation = None
        self.current_question_id = None

        for fact in self.env.facts():
            template_name = fact.template.name
            
            if template_name == 'Recommendation':
                recommendation = fact
                break
            
            if template_name == 'Current-Question':
                self.current_question_id = str(fact['id'])

        if recommendation:
            self.show_recommendation(recommendation)
        elif self.current_question_id:
            self.show_question(self.current_question_id)
        else:
            self.lbl_main_text.config(text="Błąd: System utknął (brak pytania i brak wyniku).")

    def show_question(self, q_id):
        """Wyświetla pytanie i generuje przyciski."""
        self.btn_restart.pack_forget()
        
        self.buttons_frame.pack(pady=10, fill="both", expand=True)
        
        self.clear_buttons()
        
        q_data = self.questions_data.get(q_id)
        if not q_data:
            self.lbl_main_text.config(text=f"Błąd: Nieznane ID pytania w JSON: {q_id}")
            return

        self.lbl_main_text.config(text=q_data['text'], fg="black")
        self.lbl_status.config(text="System zadaje pytanie...")

        options = q_data['options']
        
        for user_text, clips_symbol in options.items():
            btn = tk.Button(
                self.buttons_frame, 
                text=user_text, 
                font=("Arial", 12),
                width=40,
                height=2,
                bg="#f0f0f0",
                command=lambda v=clips_symbol: self.submit_answer(v)
            )
            btn.pack(pady=5)

    def submit_answer(self, selected_symbol):
        """Wysyła odpowiedź do CLIPSa i idzie dalej."""
        if not self.current_question_id:
            return

        fact_str = f'(User-Response (question-id {self.current_question_id}) (value {selected_symbol}))'
        print(f"DEBUG: Asserting -> {fact_str}")
        self.env.assert_string(fact_str)
        
        self.run_step()

    def show_recommendation(self, recommendation_fact):
        """Wyświetla ekran końcowy."""
        self.clear_buttons()
        
        self.buttons_frame.pack_forget()
        
        rec_symbol = str(recommendation_fact['name'])
        
        all_recs = self.questions_data.get("recommendations", {})
        rec_details = all_recs.get(rec_symbol)

        if rec_details:
            title = rec_details.get("title", rec_symbol).upper()
            desc = rec_details.get("description", "Brak opisu.")
            full_text = f"🍸 REKOMENDACJA: {title}\n\n{desc}"
        else:
            full_text = f"Rekomendacja: {rec_symbol}\n(Brak opisu w pliku JSON)"

        self.lbl_main_text.config(text=full_text, fg="#2E8B57")
        self.lbl_status.config(text="Proces zakończony.")

        self.btn_restart.pack(side="bottom", pady=20)

if __name__ == "__main__":
    root = tk.Tk()
    app = DrinksAdvisorGUI(root)
    root.mainloop()