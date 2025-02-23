# 📄 **Documentazione - Configurazione Tailwind CSS v4**

Questa documentazione spiega come utilizzare lo script fornito per configurare automaticamente un progetto con **Tailwind CSS v4**, generare un file `input.css` con un design system personalizzato e creare una struttura di progetto pronta all'uso.

---

## 🏗️ **1. Installazione e Setup**
### 📦 **Passaggi dello script di installazione**
Lo script bash fornito automatizza i seguenti passaggi:

1. **Aggiornamento di npm:**
   ```bash
   npm install -g npm@latest
   ```
   ➡️ Assicura di avere la versione più recente di npm.

2. **Installazione di Tailwind CSS:**
   ```bash
   npm install tailwindcss @tailwindcss/cli
   ```
   ➡️ Installa Tailwind CSS e la CLI ufficiale.

3. **Creazione della struttura base del progetto:**
   ```bash
   mkdir src
   touch src/index.html src/input.css
   ```
   ➡️ Crea la cartella `src` con i file `index.html` e `input.css`.

4. **Generazione e configurazione del file input.css:**
   - Importa `tailwindcss`.
   - Definisce un design system con variabili CSS personalizzate.

5. **Generazione del file HTML di partenza:**
   ```html
   <h1 class="text-3xl font-bold underline">Hello world!</h1>
   ```
   ➡️ Permette di verificare subito la configurazione di Tailwind.

---

## 🎨 **2. Configurazione del Design System (`input.css`)**
Il file `input.css` definisce un sistema di design personalizzato utilizzando variabili CSS. Tailwind genera automaticamente le utility class a partire da queste variabili.

### 📑 **2.1 Token vs Variabili Primitive**
🔔 **Nota importante:** Quando utilizzi i colori, devi sempre fare riferimento alle **variabili dei token** (es. `--color-text-primary`, `--color-bg-secondary`) e **non** alle variabili primitive (es. `--color-brand-500`, `--color-base-white`). 

➡️ Questo approccio rispecchia la modalità di utilizzo delle variabili su Figma e garantisce coerenza tra design e sviluppo. 

✅ **Perché usare i token?**  
- I token sono contestualizzati per finalità d’uso (testo, sfondo, bordi, ecc.).  
- Sono mappati automaticamente per supportare modalità chiara (light) e scura (dark).  
- Consentono una gestione centralizzata dei colori per un design system scalabile.  

---

### 🗂️ **2.2 Struttura dei Token**
I token sono suddivisi per finalità specifiche, rendendo chiaro e intuitivo il loro utilizzo:

- 🎨 **Token per sfondi:** `--color-bg-primary`, `--color-bg-secondary`  
- 📝 **Token per testi:** `--color-text-primary`, `--color-text-secondary`  
- 🔲 **Token per bordi:** `--color-border-primary`, `--color-border-secondary`  
- 🎛️ **Token per foreground (elementi in primo piano):** `--color-fg-primary`, `--color-fg-secondary`  
- 🚫 **Token per stati (es. errori, avvisi, successi):** `--color-error-primary`, `--color-warning-primary`, `--color-success-primary`  

✅ **Esempio di utilizzo:**
```html
<!-- Uso corretto dei token -->
<div class="bg-bg-primary text-text-primary p-md">Box con sfondo primario e testo primario</div>

<!-- ❌ Evita questo approccio -->
<div class="bg-brand-500">Uso diretto di variabile primitiva - NON consigliato</div>
```

---

### 🌗 **2.3 Gestione Light e Dark Mode**
I token sono configurati per essere in **modalità chiara di default**. Tuttavia, è possibile attivare la modalità scura aggiungendo l’attributo `data-theme="dark"` al `<body>`.

✅ **Come funziona:**
- In modalità predefinita (light), i token applicano i valori chiari.
- Se `data-theme="dark"` è specificato, i token passano automaticamente ai valori scuri.

#### 💻 **Esempio pratico:**
```html
<body>
  <div class="bg-bg-primary text-text-primary p-sm">Light mode attivo (default)</div>
</body>

<body data-theme="dark">
  <div class="bg-bg-primary text-text-primary p-sm">Dark mode attivo</div>
</body>
```
✅ **Vantaggio:** Non è necessario modificare le classi per gestire la modalità scura; è tutto automatico grazie ai token.

---

## 🖌️ **3. Utility Class Generate da Variabili**
### 🖍️ **3.1 Colori**
🔑 **Utility generate automaticamente dai token:**
- `bg-nomeToken` → Cambia lo sfondo.  
- `text-nomeToken` → Cambia il colore del testo.  
- `border-nomeToken` → Cambia il colore dei bordi.  
- `fg-nomeToken` → Cambia il colore degli elementi in primo piano.  

#### 💻 **Esempio pratico:**
```html
<div class="bg-bg-secondary text-text-secondary p-md">
  Box con sfondo secondario e testo secondario.
</div>
```

### 🌈 **3.2 Gradienti Lineari**
Le variabili gradienti sono definite come `--gradient-nomegradiente` e generano la classe `bg-linear-(nomegradiente)`.

#### 💻 **Esempio pratico:**
```html
<div class="bg-linear-gradient-01 text-text-primary p-sm">
  Sfondo con gradiente e testo primario.
</div>
```

### 🌟 **3.3 Ombre (Shadows)**
🔑 **Utility generata:** `shadow-nomeshadow`

#### 💻 **Esempio pratico:**
```html
<button class="shadow-lg-01 p-sm">Pulsante con ombra personalizzata</button>
```

### 📝 **3.4 Tipografia (Font)**
🔑 **Utility generata:** `font-nomefont`

#### 💻 **Esempio pratico:**
```html
<p class="font-sans text-lg">Testo con font sans-serif personalizzato</p>
```

### 📏 **3.5 Spaziature (Spacing)**
🔑 **Utility generate:**
- Padding: `p-sm`, `p-md`, `p-lg`
- Margin: `m-sm`, `m-md`, `m-lg`

#### 💻 **Esempio pratico:**
```html
<div class="m-md p-lg">Box con margine medio e padding grande</div>
```

---

## 🚀 **4. Avvio del progetto**
Dopo aver eseguito lo script, utilizza questo comando per avviare Tailwind in modalità watch:
```bash
npx @tailwindcss/cli -i ./src/input.css -o ./src/output.css --watch
```
➡️ Monitora le modifiche al CSS e aggiorna `output.css` automaticamente.

---

## 🧭 **5. Best Practices e Suggerimenti**
- 📂 Organizza le variabili CSS per categoria (colori, spaziature, tipografia) per una migliore leggibilità.
- 📝 Utilizza sempre i **token** per garantire coerenza con il design system di Figma.
- 🌗 Gestisci la modalità scura con `data-theme="dark"` sul `<body>`, senza cambiare classi.
- 🧩 Estendi i token solo se necessario per mantenere la scalabilità.
- 🚫 **Nota:** Assicurati di importare `tailwindcss` prima di definire `@theme` per evitare errori di compilazione.

---

## ⚠️ **6. Errori Comuni e Soluzioni**
| Errore | Causa | Soluzione |
|--------|--------|-----------|
| `output.css` non generato | Comando `npx` non eseguito | Esegui `npx @tailwindcss/cli ...` |
| Utility class non funzionanti | Uso di variabili primitive anziché token | Usa `--color-text-primary` invece di `--color-brand-500` |
| Modalità scura non applicata | `data-theme="dark"` mancante sul `<body>` | Aggiungi l’attributo per abilitare la dark mode |
| Gradienti non visibili | Nome classe errato | Usa `bg-linear-nomegradiente` |

---

✅ **Ora sei pronto per creare progetti con Tailwind CSS v4 e un design system personalizzato e conforme agli standard di Figma!** 🚀

