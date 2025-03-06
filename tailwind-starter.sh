#!/bin/bash

# Variabili
NO_CONFIRM=false

# Controlla argomenti
for arg in "$@"; do
  if [[ "$arg" == "--no-confirm" ]]; then
    NO_CONFIRM=true
  fi
done

# Funzioni per messaggi colorati e leggibili
info() {
  echo -e "🔵 \033[1;34m[INFO]\033[0m $1"
}

success() {
  echo -e "✅ \033[1;32m[SUCCESS]\033[0m $1"
}

warning() {
  echo -e "⚠️ \033[1;33m[WARNING]\033[0m $1"
}

error() {
  echo -e "❌ \033[1;31m[ERROR]\033[0m $1"
}

ask_confirmation() {
  if [[ "$NO_CONFIRM" == true ]]; then
    return 0
  fi

  while true; do
    read -rp "❓ $1 [y/n]: " response
    case "$response" in
      [Yy]) return 0 ;;
      [Nn]) return 1 ;;
      *) warning "Risposta non valida. Digita 'y' o 'n'." ;;
    esac
  done
}

# Controlla la presenza di Node.js e npm
info "Verificando che Node.js e npm siano installati..."
if ! command -v node &> /dev/null || ! command -v npm &> /dev/null; then
  error "Node.js e npm sono richiesti. Installa entrambi e riprova. 🚫"
  exit 1
fi
success "Node.js e npm sono presenti! 🎉"

# Aggiorna npm
if ask_confirmation "Vuoi aggiornare npm all'ultima versione?"; then
  info "🔄 Aggiornamento di npm in corso..."
  npm install -g npm@latest &>/dev/null
  success "NPM aggiornato alla versione $(npm -v) 🚀"
else
  warning "Aggiornamento di npm saltato. ⏩"
fi

# Installa Tailwind CSS (lasciato come richiesto)
if ask_confirmation "Vuoi installare Tailwind CSS?"; then
  info "📦 Installazione di Tailwind CSS in corso..."
  npm install tailwindcss @tailwindcss/cli &>/dev/null
  success "Tailwind CSS installato con successo! 🖌️"
else
  warning "Installazione di Tailwind CSS saltata. ⏩"
fi

# Crea la struttura base del progetto
if [[ -d "src" ]]; then
  if ask_confirmation "La cartella 'src' esiste già. Vuoi sovrascriverla? (Attenzione: i file esistenti verranno persi)"; then
    rm -rf src
    info "Cartella 'src' rimossa. 🗑️"
  else
    warning "Creazione struttura saltata. 🚫"
    exit 1
  fi
fi

info "📂 Creazione della struttura base del progetto..."
mkdir -p src
touch src/index.html src/input.css
success "Struttura creata: 📁 src (con index.html e input.css)"

# Scrive la configurazione del Design System in input.css
if ask_confirmation "Vuoi aggiungere la configurazione al file 'input.css'? (Se esiste, verrà sovrascritto)"; then
  info "📝 Aggiunta della configurazione in input.css..."
  cat << 'EOF' > src/input.css
/*Here you should import the font family*/
/*@import url("https://fonts.googleapis.com/css2?family=Roboto&display=swap");*/

@import "tailwindcss";

@theme {
  /***********************/
  /* Spacing */
  /***********************/
  --spacing-none: 0rem;
  --spacing-xxs: 0.125rem;
  --spacing-xs: 0.25rem;
  --spacing-sm: 0.375rem;
  --spacing-md: 0.5rem;
  --spacing-lg: 0.75rem;
  --spacing-xl: 1rem;
  --spacing-2xl: 1.25rem;
  --spacing-3xl: 1.5rem;
  --spacing-4xl: 2rem;
  --spacing-5xl: 2.5rem;
  --spacing-6xl: 3rem;
  --spacing-7xl: 4rem;
  --spacing-8xl: 5rem;
  --spacing-9xl: 6rem;
  --spacing-10xl: 8rem;
  --spacing-11xl: 10rem;

  /***********************/
  /* Border Radius */
  /***********************/
  --radius-none: 0rem;
  --radius-xxs: 0.125rem;
  --radius-xs: 0.25rem;
  --radius-sm: 0.375rem;
  --radius-md: 0.5rem;
  --radius-lg: 0.625rem;
  --radius-xl: 0.75rem;
  --radius-2xl: 1rem;
  --radius-3xl: 1.25rem;
  --radius-4xl: 1.5rem;
  --radius-full: 9999px;

  /***********************/
  /* Typography */
  /***********************/

  /*Font Family */
  --font-sans: 'Inter',
    sans-serif;
  --font-serif: 'Merriweather',
    serif;
  --font-mono: 'Roboto Mono',
    monospace;

  /*Font sizes*/
  --text-xs: 0.75rem;
  --text-sm: 0.875rem;
  --text-md: 1rem;
  --text-lg: 1.125rem;
  --text-xl: 1.25rem;
  --text-display-sm: 1.5rem;
  --text-display-md: 2.25rem;
  --text-display-lg: 3rem;
  --text-display-xl: 3.75rem;
  --text-display-2xl: 4.5rem;


  /***********************/
  /***********************/
  /* PRIMITIVES VARIABLES */
  /***********************/
  /***********************/

  /***********************/
  /* Colors */
  /***********************/

  /*Base Colors*/
  --color-base-white: #FFFFFF;
  --color-base-black: #000000;
  --color-base-transparent: #ffffff00;


  /*Brand colors*/
  --color-brand-25: #F5FEFF;
  --color-brand-50: #ECFDFF;
  --color-brand-100: #CFF9FE;
  --color-brand-200: #A5F0FC;
  --color-brand-300: #67E3F9;
  --color-brand-400: #22CCEE;
  --color-brand-500: #06AED4;
  --color-brand-600: #088AB2;
  --color-brand-700: #0E7090;
  --color-brand-800: #155B75;
  --color-brand-900: #164C63;
  --color-brand-950: #0D2D3A;

  /*Gray Light Mode Colors*/
  --color-gray-light-25: #FDFDFD;
  --color-gray-light-50: #FAFAFA;
  --color-gray-light-100: #F5F5F5;
  --color-gray-light-200: #E9EAEB;
  --color-gray-light-300: #D5D7DA;
  --color-gray-light-400: #A4A7AE;
  --color-gray-light-500: #717680;
  --color-gray-light-600: #535862;
  --color-gray-light-700: #414651;
  --color-gray-light-800: #252B37;
  --color-gray-light-900: #181D27;
  --color-gray-light-950: #0A0D12;

  /*Gray Light Mode Colors*/
  --color-gray-dark-25: #FAFAFA;
  --color-gray-dark-50: #F7F7F7;
  --color-gray-dark-100: #F0F0F1;
  --color-gray-dark-200: #ECECED;
  --color-gray-dark-300: #CECFD2;
  --color-gray-dark-400: #94979C;
  --color-gray-dark-500: #85888E;
  --color-gray-dark-600: #61656C;
  --color-gray-dark-700: #373A41;
  --color-gray-dark-800: #22262F;
  --color-gray-dark-900: #13161B;
  --color-gray-dark-950: #0C0E12;

  /*Gray dark mode alpha*/
  --color-gray-dark-alpha-25: #FFFFFFFA;
  /* 98% */
  --color-gray-dark-alpha-50: #FFFFFFF5;
  /* 96% */
  --color-gray-dark-alpha-100: #FFFFFFF0;
  /* 94% */
  --color-gray-dark-alpha-200: #FFFFFFEB;
  /* 92% */
  --color-gray-dark-alpha-300: #FFFFFFCC;
  /* 80% */
  --color-gray-dark-alpha-400: #FFFFFF8F;
  /* 56% */
  --color-gray-dark-alpha-500: #FFFFFF80;
  /* 50% */
  --color-gray-dark-alpha-600: #FFFFFF59;
  /* 35% */
  --color-gray-dark-alpha-700: #FFFFFF29;
  /* 16% */
  --color-gray-dark-alpha-800: #FFFFFF14;
  /* 8% */
  --color-gray-dark-alpha-900: #FFFFFF0A;
  /* 4% */
  --color-gray-dark-alpha-950: #FFFFFF00;
  /* 0% */

  /*Error Colors*/
  --color-error-25: #FFFBFA;
  --color-error-50: #FEF3F2;
  --color-error-100: #FEE4E2;
  --color-error-200: #FECDCA;
  --color-error-300: #FDA29B;
  --color-error-400: #F97066;
  --color-error-500: #F04438;
  --color-error-600: #D92D20;
  --color-error-700: #B42318;
  --color-error-800: #912018;
  --color-error-900: #7A271A;
  --color-error-950: #55160C;

  /*Warning Colors*/
  --color-warning-25: #FFFCF5;
  --color-warning-50: #FFFAEB;
  --color-warning-100: #FEF0C7;
  --color-warning-200: #FEDF89;
  --color-warning-300: #FEC84B;
  --color-warning-400: #FDB022;
  --color-warning-500: #F79009;
  --color-warning-600: #DC6803;
  --color-warning-700: #B54708;
  --color-warning-800: #93370D;
  --color-warning-900: #7A2E0E;
  --color-warning-950: #4E1D09;

  /*Success Colors */
  --color-success-25: #F6FEF9;
  --color-success-50: #ECFDF3;
  --color-success-100: #DCFAE6;
  --color-success-200: #ABEFC6;
  --color-success-300: #75E0A7;
  --color-success-400: #47CD89;
  --color-success-500: #17B26A;
  --color-success-600: #079455;
  --color-success-700: #067647;
  --color-success-800: #085D3A;
  --color-success-900: #074D31;
  --color-success-950: #053321;

  /*Gradient Colors*/
  --gradient-01: 180deg, #A5C0EE 0%, #FBC5EC 100%;
  --gradient-02: 180deg, #FBC2EB 0%, #A18CD1 105.25%;
  --gradient-03: 180deg, #FFD1FF 0%, #FAD0C4 100%;
  --gradient-04: 225deg, #FAD0C4 0%, #FF9A9E 100%;
  --gradient-05: 225deg, #FAD0C4 0%, #FF9A9E 100%;
  --gradient-06: 180deg, #FECFEF 0%, #FF989C 100%;
  --gradient-07: 45deg, #FF9DE4 0%, #FFEAF6 100%;
  --gradient-08: 180deg, #E6DEE9 0%, #FDCAF1 100%;
  --gradient-09: 45deg, #A6C0FE 0%, #FFEAF6 100%;
  --gradient-10: 0deg, #CFC7F8 0%, #EBBBA7 100%;
  --gradient-11: 135deg, #FCCB90 0%, #D57EEB 100%;
  --gradient-12: 45deg, #7B6AE0 0%, #FFBB89 100%;
  --gradient-13: 135deg, #E0C3FC 0%, #8EC5FC 100%;
  --gradient-14: 0deg, #FED6E3 0%, #A8EDEA 100%;
  --gradient-15: 135deg, #F5F7FA 0%, #C3CFE2 100%;
  --gradient-16: 45deg, #DFD1C5 0%, #FFF6EB 100%;
  --gradient-17: 135deg, #FFF6B7 0%, #FB758A 100%;
  --gradient-18: 45deg, #FF7EC7 0%, #FFED46 100%;
  --gradient-19: 0deg, #FEAFA8 0%, #F5EFEF 100%;
  --gradient-20: 45deg, #E9DEFA 0%, #FFF6EB 100%;
  --gradient-21: 0deg, #FFF1EB 0%, #ACE0F9 100%;
  --gradient-22: 0deg, #C1DFC4 0%, #DEECDD 100%;
  --gradient-23: 45deg, #A1C4FD 0%, #C2E9FB 100%;
  --gradient-24: 0deg, #ACCBEE 0%, #E7F0FD 100%;
  --gradient-25: 0deg, #84FAB0 0%, #ACCBEE 100%;
  --gradient-26: 45deg, #39A0FF 0%, #8FFF85 100%;
  --gradient-27: 270deg, #74EBD5 0%, #9FACE6 100%;
  --gradient-28: 45deg, #4A879A 0%, #C5EDF5 100%;
  --gradient-29: 0deg, #9890E3 0%, #B1F4CF 100%;
  --gradient-30: 45deg, #7CDADA 0%, #F697AA 100%;
  --gradient-31: 45deg, #B1FF96 0%, #FFADF7 100%;
  --gradient-32: 0deg, #96FBC4 0%, #F9F586 100%;
  --gradient-33: 45deg, #4DEF8E 0%, #FFEB3A 100%;
  --gradient-34: 135deg, #F0FF00 0%, #58CFFB 100%;
  --gradient-35: 0deg, #D1FDFF 0%, #FDDB92 100%;
  --gradient-36: 0deg, #EBC0FD 0%, #D9DED8 100%;
  --gradient-37: 45deg, #FFA4F6 0%, #B7DCFF 100%;
  --gradient-38: 0deg, #CD9CF2 -30.65%, #F6F3FF 100%;
  --gradient-39: 315deg, #F5C8F5 0%, #DADDFA 83.85%;
  --gradient-40: 0deg, #E6DEE9 0%, #BDC2E8 100%;
  --gradient-41: 0deg, #6A85B6 0%, #BAC8E0 100%;
  --gradient-42: 45deg, #8B8B8B 0%, #EAEAEA 100%;
  --gradient-43: 135deg, #E2B0FF 0%, #9F44D3 100%;
  --gradient-44: 135deg, #CE9FFC 0%, #7367F0 100%;
  --gradient-45: 135deg, #72EDF2 0%, #5151E5 100%;
  --gradient-46: 0deg, #A3BDED 0%, #6991C7 100%;
  --gradient-47: 0deg, #FBC8D4 0%, #9795F0 100%;
  --gradient-48: 0deg, #A7A6CB 0%, #8989BA 100%;
  --gradient-49: 0deg, #D9AFD9 0%, #97D9E1 100%;
  --gradient-50: 135deg, #81FFEF 0%, #F067B4 100%;
  --gradient-51: 135deg, #DCB0ED 0%, #9999CC 100%;
  --gradient-52: 135deg, #FFF5C3 0%, #9452A5 100%;
  --gradient-53: 135deg, #F1CA74 0%, #A64DB6 100%;
  --gradient-54: 45deg, #4D6AD0 0%, #FF9D7E 100%;
  --gradient-55: 135deg, #FFCF71 0%, #2376DD 100%;
  --gradient-56: 135deg, #E8D07A 0%, #5312D6 100%;
  --gradient-57: 180deg, #BFD9FE 0%, #DF89B5 100%;
  --gradient-58: 0deg, #FA71CD 0%, #C471F5 100%;
  --gradient-59: 135deg, #43CBFF 0%, #9708CC 100%;
  --gradient-60: 180deg, #7579FF 0%, #B224EF 100%;
  --gradient-61: 45deg, #AD00FE 0%, #00E0EE 100%;
  --gradient-62: 135deg, #89F7FE 0%, #66A6FF 100%;
  --gradient-63: 0deg, #009EFD -30.65%, #2AF598 100%;
  --gradient-64: 45deg, #FFB800 0%, #FFF500 100%;
  --gradient-65: 135deg, #FFA8A8 0%, #FCFF00 100%;
  --gradient-66: 45deg, #FF7A00 0%, #FFD439 100%;
  --gradient-67: 135deg, #FFD3A5 0%, #FD6585 100%;
  --gradient-68: 180deg, #F9D423 0%, #E14FAD 100%;
  --gradient-69: 135deg, #F74FAC 0%, #FCB24F 100%;
  --gradient-70: 135deg, #F49062 0%, #FD371F 100%;
  --gradient-71: 45deg, #FF6C6C 0%, #DD7BFF 100%;
  --gradient-72: 135deg, #F97794 0%, #623AA2 100%;
  --gradient-73: 180deg, #C569CF 0%, #EE609C 100%;
  --gradient-74: 0deg, #C7EAFD 0%, #E8198B 100%;
  --gradient-75: 135deg, #F093FB 0%, #F5576C 100%;
  --gradient-76: 135deg, #F6CEEC 0%, #D939CD 100%;
  --gradient-77: 135deg, #EE9AE5 0%, #5961F9 100%;
  --gradient-78: 270deg, #6A11CB 0%, #2575FC 100%;
  --gradient-79: 45deg, #0017E4 0%, #3793FF 100%;
  --gradient-80: 0deg, #00C6FB 0%, #005BEA 100%;
  --gradient-81: 45deg, #4B73FF 0%, #7CF7FF 100%;
  --gradient-82: 135deg, #5EFCE8 0%, #736EFE 100%;
  --gradient-83: 0deg, #7028E4 0%, #E5B2CA 100%;
  --gradient-84: 90deg, #7873F5 0%, #EC77AB 100%;
  --gradient-85: 135deg, #B01EFF 0%, #E1467C 100%;
  --gradient-86: 45deg, #D079EE 0%, #8A88FB 100%;
  --gradient-87: 135deg, #C99FFF 0%, #981ED2 100%;
  --gradient-88: 0deg, #9B23EA 0%, #5F72BD 100%;
  --gradient-89: 135deg, #B39FFF 0%, #6A1ED2 100%;
  --gradient-90: 45deg, #4300B1 0%, #A531DC 100%;
  --gradient-91: 315deg, #764BA2 0%, #667EEA 100%;





  /***********************/
  /***********************/
  /* TOKENS VARIABLES */
  /***********************/
  /***********************/


  /* Text Tokens - Light Mode */
  --text-color-primary: var(--color-gray-light-900);
  --text-color-primary-on-brand: var(--color-base-white);
  --text-color-secondary: var(--color-gray-light-700);
  --text-color-secondary-hover: var(--color-gray-light-800);
  --text-color-secondary-on-brand: var(--color-brand-200);
  --text-color-tertiary: var(--color-gray-light-600);
  --text-color-tertiary-hover: var(--color-gray-light-700);
  --text-color-tertiary-on-brand: var(--color-brand-200);
  --text-color-quaternary: var(--color-gray-light-500);
  --text-color-quaternary-on-brand: var(--color-brand-300);
  --text-color-white: var(--color-base-white);
  --text-color-disabled: var(--color-gray-light-500);
  --text-color-placeholder: var(--color-gray-light-500);
  --text-color-placeholder-subtle: var(--color-gray-light-300);
  --text-color-brand-primary: var(--color-brand-900);
  --text-color-brand-secondary: var(--color-brand-700);
  --text-color-brand-tertiary: var(--color-brand-600);
  --text-color-brand-tertiary-alt: var(--color-brand-600);
  --text-color-error-primary: var(--color-error-600);
  --text-color-warning-primary: var(--color-warning-600);
  --text-color-success-primary: var(--color-success-600);

  /* Border Tokens - Light Mode */
  --border-color-primary: var(--color-gray-light-300);
  --border-color-secondary: var(--color-gray-light-200);
  --border-color-tertiary: var(--color-gray-light-100);
  --border-color-disabled: var(--color-gray-light-300);
  --border-color-disabled-subtle: var(--color-gray-light-200);
  --border-color-brand: var(--color-brand-500);
  --border-color-brand-alt: var(--color-brand-600);
  --border-color-error: var(--color-error-500);
  --border-color-error-subtle: var(--color-error-300);

  /* Background Tokens - Light Mode */
  --background-color-primary: var(--color-base-white);
  --background-color-primary-alt: var(--color-base-white);
  --background-color-primary-hover: var(--color-gray-light-50);
  --background-color-primary-solid: var(--color-gray-light-950);
  --background-color-secondary: var(--color-gray-light-50);
  --background-color-secondary-alt: var(--color-gray-light-50);
  --background-color-secondary-hover: var(--color-gray-light-100);
  --background-color-secondary-subtle: var(--color-gray-light-25);
  --background-color-secondary-solid: var(--color-gray-light-600);
  --background-color-tertiary: var(--color-gray-light-100);
  --background-color-quaternary: var(--color-gray-light-200);
  --background-color-active: var(--color-gray-light-50);
  --background-color-disabled: var(--color-gray-light-100);
  --background-color-disabled-subtle: var(--color-gray-light-50);
  --background-color-overlay: var(--color-gray-light-950);
  --background-color-brand-primary: var(--color-brand-500);
  --background-color-brand-primary-alt: var(--color-gray-light-50);
  --background-color-brand-secondary: var(--color-brand-100);
  --background-color-brand-solid: var(--color-brand-600);
  --background-color-brand-solid-hover: var(--color-brand-700);
  --background-color-brand-section: var(--color-brand-800);
  --background-color-brand-section-subtle: var(--color-brand-700);
  --background-color-error-primary: var(--color-error-50);
  --background-color-error-secondary: var(--color-error-100);
  --background-color-error-solid: var(--color-error-600);
  --background-color-warning-primary: var(--color-warning-50);
  --background-color-warning-secondary: var(--color-warning-100);
  --background-color-warning-solid: var(--color-warning-600);
  --background-color-success-primary: var(--color-success-50);
  --background-color-success-secondary: var(--color-success-100);
  --background-color-success-solid: var(--color-success-600);

  /***********************/
  /* Shadows - Light Mode */
  /***********************/
  --shadow-xs: 0 1px 2px 0 rgba(10, 13, 18, 0.05);
  --shadow-sm-01: 0 2px 4px 0 rgba(10, 13, 18, 0.10);
  --shadow-sm-02: 0 2px 6px 0 rgba(10, 13, 18, 0.10);
  --shadow-md-01: 0 4px 6px 0 rgba(10, 13, 18, 0.10);
  --shadow-md-02: 0 4px 8px 0 rgba(10, 13, 18, 0.06);
  --shadow-lg-01: 0 6px 10px 0 rgba(10, 13, 18, 0.08);
  --shadow-lg-02: 0 8px 12px 0 rgba(10, 13, 18, 0.03);
  --shadow-lg-03: 0 8px 14px 0 rgba(10, 13, 18, 0.04);
  --shadow-xl-01: 0 10px 16px 0 rgba(10, 13, 18, 0.08);
  --shadow-xl-02: 0 12px 18px 0 rgba(10, 13, 18, 0.03);
  --shadow-xl-03: 0 14px 20px 0 rgba(10, 13, 18, 0.04);
  --shadow-2xl-01: 0 16px 24px 0 rgba(10, 13, 18, 0.18);
  --shadow-2xl-02: 0 18px 28px 0 rgba(10, 13, 18, 0.04);
  --shadow-3xl-01: 0 20px 32px 0 rgba(10, 13, 18, 0.14);
  --shadow-3xl-02: 0 22px 36px 0 rgba(10, 13, 18, 0.04);
  --shadow-skeuomorphic-inset-01: inset 0 1px 2px 0 rgba(12, 14, 18, 0.05);
  --shadow-skeuomorphic-inset-02: inset 0 4px 8px 0 rgba(12, 14, 18, 0.18);
}

[data-theme="dark"] {
  /* Text Tokens - Dark Mode */
  --text-color-primary: var(--color-gray-dark-50);
  --text-color-primary-on-brand: var(--color-gray-dark-50);
  --text-color-secondary: var(--color-gray-dark-300);
  --text-color-secondary-hover: var(--color-gray-dark-200);
  --text-color-secondary-on-brand: var(--color-gray-dark-300);
  --text-color-tertiary: var(--color-gray-dark-400);
  --text-color-tertiary-hover: var(--color-gray-dark-300);
  --text-color-tertiary-on-brand: var(--color-gray-dark-400);
  --text-color-quaternary: var(--color-gray-dark-400);
  --text-color-quaternary-on-brand: var(--color-gray-dark-400);
  --text-color-white: var(--color-base-white);
  --text-color-disabled: var(--color-gray-dark-500);
  --text-color-placeholder: var(--color-gray-dark-500);
  --text-color-placeholder-subtle: var(--color-gray-dark-700);
  --text-color-brand-primary: var(--color-brand-900);
  --text-color-brand-secondary: var(--color-brand-700);
  --text-color-brand-tertiary: var(--color-brand-600);
  --text-color-brand-tertiary-alt: var(--color-gray-dark-50);
  --text-color-error-primary: var(--color-error-400);
  --text-color-warning-primary: var(--color-warning-400);
  --text-color-success-primary: var(--color-success-400);

  /* Border Tokens - Dark Mode */
  --border-color-primary: var(--color-gray-dark-700);
  --border-color-secondary: var(--color-gray-dark-800);
  --border-color-tertiary: var(--color-gray-dark-800);
  --border-color-disabled: var(--color-gray-dark-700);
  --border-color-disabled-subtle: var(--color-gray-dark-800);
  --border-color-brand: var(--color-brand-400);
  --border-color-brand-alt: var(--color-gray-dark-700);
  --border-color-error: var(--color-error-400);
  --border-color-error-subtle: var(--color-error-400);

  /* Background Tokens - Dark Mode */
  --background-color-primary: var(--color-gray-dark-950);
  --background-color-primary-alt: var(--background-color-secondary);
  --background-color-primary-hover: var(--color-gray-dark-800);
  --background-color-primary-solid: var(--background-color-secondary);
  --background-color-secondary: var(--color-gray-dark-900);
  --background-color-secondary-alt: var(--background-color-primary);
  --background-color-secondary-hover: var(--color-gray-dark-800);
  --background-color-secondary-subtle: var(--color-gray-dark-900);
  --background-color-secondary-solid: var(--color-gray-dark-600);
  --background-color-tertiary: var(--color-gray-dark-800);
  --background-color-quaternary: var(--color-gray-dark-700);
  --background-color-active: var(--color-gray-dark-800);
  --background-color-disabled: var(--color-gray-dark-800);
  --background-color-disabled-subtle: var(--color-gray-dark-900);
  --background-color-overlay: var(--color-gray-dark-800);
  --background-color-brand-primary: var(--color-brand-500);
  --background-color-brand-primary-alt: var(--background-color-secondary);
  --background-color-brand-secondary: var(--color-brand-600);
  --background-color-brand-solid: var(--color-brand-600);
  --background-color-brand-solid-hover: var(--color-brand-500);
  --background-color-brand-section: var(--background-color-secondary);
  --background-color-brand-section-subtle: var(--background-color-primary);
  --background-color-error-primary: var(--color-error-500);
  --background-color-error-secondary: var(--color-error-600);
  --background-color-error-solid: var(--color-error-600);
  --background-color-warning-primary: var(--color-warning-500);
  --background-color-warning-secondary: var(--color-warning-600);
  --background-color-warning-solid: var(--color-warning-600);
  --background-color-success-primary: var(--color-success-500);
  --background-color-success-secondary: var(--color-success-600);
  --background-color-success-solid: var(--color-success-600);

  /***********************/
  /* Shadows - Dark Mode */
  /***********************/
  --shadow-xs: 0 1px 2px 0 rgba(12, 14, 18, 0.05);
  --shadow-sm-01: 0 2px 4px 0 rgba(12, 14, 18, 0.10);
  --shadow-sm-02: 0 2px 6px 0 rgba(12, 14, 18, 0.10);
  --shadow-md-01: 0 4px 6px 0 rgba(12, 14, 18, 0.10);
  --shadow-md-02: 0 4px 8px 0 rgba(12, 14, 18, 0.06);
  --shadow-lg-01: 0 6px 10px 0 rgba(12, 14, 18, 0.08);
  --shadow-lg-02: 0 8px 12px 0 rgba(12, 14, 18, 0.03);
  --shadow-lg-03: 0 8px 14px 0 rgba(12, 14, 18, 0.04);
  --shadow-xl-01: 0 10px 16px 0 rgba(12, 14, 18, 0.08);
  --shadow-xl-02: 0 12px 18px 0 rgba(12, 14, 18, 0.03);
  --shadow-xl-03: 0 14px 20px 0 rgba(12, 14, 18, 0.04);
  --shadow-2xl-01: 0 16px 24px 0 rgba(12, 14, 18, 0.18);
  --shadow-2xl-02: 0 18px 28px 0 rgba(12, 14, 18, 0.04);
  --shadow-3xl-01: 0 20px 32px 0 rgba(12, 14, 18, 0.14);
  --shadow-3xl-02: 0 22px 36px 0 rgba(12, 14, 18, 0.04);
  --shadow-skeuomorphic-inset-01: inset 0 1px 2px 0 rgba(12, 14, 18, 0.05);
  --shadow-skeuomorphic-inset-02: inset 0 4px 8px 0 rgba(12, 14, 18, 0.18);
}

body {
  font-family: var(--font-sans);
}
EOF
  success "input.css aggiornato con la configurazione base. 🖋️"
else
  warning "Modifica di input.css saltata. ⏩"
fi

# Scrive il boilerplate in index.html
if ask_confirmation "Vuoi aggiungere il boilerplate a 'index.html'? (Se esiste, verrà sovrascritto)"; then
  info "💻 Creazione di index.html con contenuto di esempio..."
  cat << 'EOF' > src/index.html
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="./output.css" rel="stylesheet">
  <title>Tailwind Setup</title>
</head>
<body class="flex items-center justify-center h-screen bg-secondary">
  <h1 class="text-4xl font-bold text-primary animate-pulse">
    👋 Hello, Tailwind CSS v4!
  </h1>
</body>
</html>
EOF
  success "index.html creato con successo! 📄"
else
  warning "Creazione di index.html saltata. ⏩"
fi

# Genera output.css
if ask_confirmation "Vuoi generare il file 'output.css'?"; then
  info "⚙️ Generazione di output.css..."
  npx @tailwindcss/cli -i ./src/input.css -o ./src/output.css &>/dev/null
  success "output.css generato correttamente! 🪄"
else
  warning "Generazione di output.css saltata. ⏩"
fi

# Messaggio finale
success "🎉 Setup completato!"
echo -e "🚀 Per avviare la modalità watch esegui:"
echo -e "\033[1;32mnpx @tailwindcss/cli -i ./src/input.css -o ./src/output.css --watch\033[0m"
echo -e "🔍 Apri \033[1;36mindex.html\033[0m per visualizzare il risultato! 👀"
echo -e "💡 Puoi eseguire lo script senza conferme con il flag: \033[1;33m--no-confirm\033[0m"
