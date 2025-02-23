# 📄 **Documentazione - Configurazione Tailwind CSS v4**

Questa documentazione spiega come utilizzare lo script fornito per configurare automaticamente un progetto con **Tailwind CSS v4**, generare un file `input.css` con un design system personalizzato e creare una struttura di progetto pronta all'uso.

---

## 🏗️ **1. Utilizzo dello Script di Setup**

### 🚀 **Come rendere lo script eseguibile**
1. Salva lo script in un file, ad esempio `tailwind-starter.sh`.
2. Rendi lo script eseguibile con il comando:
   ```bash
   chmod +x tailwind-starter.sh
   ```

### 🖥️ **Modalità di esecuzione**
Lo script può essere eseguito in due modalità:

#### 🔎 **1. Modalità interattiva (default)**
Richiede conferma per ogni step del processo.
```bash
./tailwind-starter.sh
```
➡️ **Ideale** se vuoi controllare ogni passaggio manualmente.

#### ⚡ **2. Modalità automatica (senza conferme)**
Esegue tutti i passaggi senza richiedere conferma.
```bash
./tailwind-starter.sh --no-confirm
```
➡️ **Ideale** per velocizzare il processo in ambienti di sviluppo ripetitivi.

---

## 🗂️ **2. Struttura del progetto generata**
Dopo l’esecuzione dello script, la struttura del progetto sarà la seguente:

```
├── package-lock.json   # File generato da npm per gestire le dipendenze esatte.
├── package.json        # Contiene le dipendenze e gli script npm del progetto.
└── src/                # Cartella principale dei file sorgente.
    ├── index.html      # File HTML di esempio per testare le utility di Tailwind.
    ├── input.css       # File di input contenente i token e la configurazione del design system.
    └── output.css      # File CSS generato automaticamente da Tailwind.
```

✅ **Spiegazione dei file:**
- **package.json:** Gestisce le dipendenze e le versioni dei pacchetti installati.
- **package-lock.json:** Blocca le versioni esatte dei pacchetti per coerenza tra ambienti.
- **src/index.html:** Contiene un boilerplate per testare le utility di Tailwind CSS.
- **src/input.css:** Include la definizione dei token e le variabili CSS per il design system.
- **src/output.css:** File CSS finale generato da Tailwind in base a `input.css`.

---

## 🎨 **3. Configurazione del Design System (`input.css`)**
Il file `input.css` definisce un sistema di design personalizzato tramite variabili CSS. Queste variabili sono la base per generare automaticamente le utility class di Tailwind CSS.

### 📑 **3.1 Token vs Variabili Primitive**
🔔 **Importante:** Utilizza sempre le **variabili dei token** (es. `--color-text-primary`, `--color-bg-secondary`) e **mai** le variabili primitive (es. `--color-brand-500`, `--color-base-white`). 

➡️ Questo approccio garantisce coerenza tra design e sviluppo, rispecchiando le pratiche di utilizzo delle variabili su Figma.

✅ **Perché usare i token?**
- I token sono contestualizzati per finalità d’uso (testo, sfondo, bordi, ecc.).
- Consentono un passaggio automatico tra modalità chiara e scura.
- Offrono una gestione centralizzata per uno stile consistente e scalabile.

---

### 🗂️ **3.2 Suddivisione dei Token**
I token sono organizzati in categorie per semplificare l’utilizzo e garantire la leggibilità:

#### 🎨 **3.2.1 Token per sfondi**
Gestiscono i colori di sfondo degli elementi.
- `--color-bg-primary`
- `--color-bg-secondary`
- `--color-bg-brand-primary`

💻 **Esempio:**
```html
<div class="bg-bg-primary p-md">Sfondo primario</div>
```

---

#### 📝 **3.2.2 Token per testi**
Gestiscono i colori del testo.
- `--color-text-primary`
- `--color-text-secondary`
- `--color-text-brand-primary`

💻 **Esempio:**
```html
<p class="text-text-primary">Testo con colore primario</p>
```

---

#### 🔲 **3.2.3 Token per bordi**
Gestiscono i colori dei bordi.
- `--color-border-primary`
- `--color-border-secondary`
- `--color-border-brand`

💻 **Esempio:**
```html
<div class="border border-border-primary p-sm">Box con bordo primario</div>
```

---

#### 🎛️ **3.2.4 Token per foreground**
Gestiscono il colore degli elementi in primo piano (es. icone, testi in overlay).
- `--color-fg-primary`
- `--color-fg-secondary`

💻 **Esempio:**
```html
<svg class="fill-fg-primary">Icona foreground</svg>
```

---

#### 🚦 **3.2.5 Token per stati (errori, avvisi, successi)**
- `--color-error-primary`
- `--color-warning-primary`
- `--color-success-primary`

💻 **Esempio:**
```html
<span class="text-error-primary">Messaggio di errore</span>
```

---

### 🌗 **3.3 Gestione Light e Dark Mode**
I token sono configurati per essere in **modalità chiara (light mode) di default**. Per attivare la modalità scura, aggiungi l’attributo `data-theme="dark"` al tag `<body>`.

💻 **Esempio pratico:**
```html
<body>
  <div class="bg-bg-primary text-text-primary">Light mode attivo</div>
</body>

<body data-theme="dark">
  <div class="bg-bg-primary text-text-primary">Dark mode attivo</div>
</body>
```

✅ **Vantaggi:**
- Non è necessario cambiare le classi CSS per la dark mode.
- La gestione dei temi è centralizzata e reattiva.

---

## 🖥️ **4. Avvio e Watch Mode**
Una volta completata la configurazione:

### ▶️ **Comando per avviare la modalità watch**
```bash
npx @tailwindcss/cli -i ./src/input.css -o ./src/output.css --watch
```
➡️ Monitora le modifiche al file `input.css` e aggiorna automaticamente `output.css`.

✅ **Consiglio:** Mantieni questo comando attivo durante lo sviluppo per vedere le modifiche in tempo reale.

---

## 🧭 **5. Best Practices**
- 📂 Organizza le variabili CSS per categoria (colori, spaziature, tipografia) per una migliore leggibilità.
- 📝 Utilizza sempre i **token** per mantenere la coerenza con il design system su Figma.
- 🌗 Gestisci la dark mode tramite `data-theme="dark"` sul `<body>`, senza modificare le classi.
- 🧩 Estendi i token solo se strettamente necessario per evitare ridondanze.
- 🚫 **Evita l’uso diretto di variabili primitive** per prevenire incoerenze tra design e sviluppo.

---

## ⚠️ **6. Errori Comuni e Soluzioni**
| Errore | Causa | Soluzione |
|--------|--------|-----------|
| `output.css` non generato | Comando `npx` non eseguito | Avvia `npx @tailwindcss/cli --watch` |
| Classi non funzionanti | Uso di variabili primitive anziché token | Usa `--color-text-primary` anziché `--color-brand-500` |
| Dark mode non attiva | Attributo `data-theme="dark"` mancante | Aggiungi `data-theme="dark"` al `<body>` |
| Gradienti non visibili | Classe CSS errata | Usa `bg-linear-gradient-01` correttamente |

---

✅ **Se hai seguito correttamente la guida, sei pronto per lavorare con Tailwind CSS v4 e un design system solido e conforme agli standard di Figma!** 🚀

