# Olivetti M40 — BCOS: istruzioni per Windows

Questa guida descrive come creare un sistema BCOS, avviarlo e aprire BASIC.
Per usare il sistema fornito senza crearne uno nuovo, passare ad
[Avviare il sistema fornito](#avviare-il-sistema-fornito).

## Prerequisiti

Verificare di avere quanto segue. **Se è già tutto pronto, passare alle
istruzioni.** Scaricare o copiare soltanto ciò che manca.

- **MAME per Windows con supporto M40:** una versione compilata dal
  [ramo `olivetti_m40` di MAME](https://github.com/tpaxia/mame/tree/olivetti_m40)
  che includa la nuova **mappatura US/ANSI con combinazioni Alt** descritta
  sotto. Usare il commit `a421751bf44` o successivo; le versioni precedenti
  assegnano diversamente alcuni tasti.
- **ROM M40:** il file `m40rom-6.0.bin` nella cartella `roms\m40` oppure
  nell'archivio `roms\m40.zip`, all'interno della cartella di MAME. Se manca,
  procurarsi la ROM separatamente: non è inclusa né nei sorgenti dell'emulatore
  né in questo archivio di dischi.
- **Dischi BCOS:** le immagini elencate sotto, nella cartella `flop` di MAME.
  Scaricare quelle mancanti dalla [cartella BCOS di questo repository](./)
  e copiarle lì. Creare `flop` se necessario. Le prime due servono per
  configurare un nuovo sistema; le altre due per avviare il sistema fornito.
- **Una tastiera PC con tastierino numerico.**
- **Profilo dei comandi MAME per M40:** copiare [m40-ui.cfg](m40-ui.cfg)
  nella cartella `ctrlr` di MAME, creandola se necessario. Il profilo riserva
  F12 ai comandi dell'interfaccia e disattiva la scorciatoia F12 per le
  schermate, che altrimenti entrerebbe in conflitto.

| File | Utilizzo |
|---|---|
| `K02733_BCOS_II_3.3_CONFIGURATOR.imd` | Crea il sistema |
| `K02741_BCOS_II_3.3_JJKEYB.imd` | Contiene i file della tastiera |
| `BCOS_LOAD.imd` | Avvia il sistema fornito |
| `BCOS_RUN.imd` | Esegue il sistema fornito e BASIC |

Aprire il **Prompt dei comandi** nella cartella contenente `mame.exe`.
Se l'eseguibile si chiama `m40.exe`, usare quel nome al posto di `mame.exe`
nei comandi seguenti.

## Breve introduzione ai comandi MAME per M40

Questa sezione presenta i comandi usati nella guida. La procedura di
configurazione inizia da [1. Preparare i dischi di lavoro](#1-preparare-i-dischi-di-lavoro).

### Aprire il menu di MAME

Normalmente MAME si avvia pronto a inviare i tasti a BCOS. Per usare i menu:

1. Premere **F12**. Deve apparire **UI controls enabled**.
2. Premere **Tab** per aprire il menu. Usare le frecce e **Invio principale**.
3. Al termine, chiudere il menu con **Tab**.
4. Premere nuovamente **F12**. Verificare che appaia **UI controls disabled**
   prima di scrivere in BCOS.

Disattivare i comandi solo se sono stati attivati. Per fare clic sui selettori
della barra di stato non serve premere F12. Se i comandi sono già attivi,
iniziare dal punto 2.

Con il profilo `m40-ui`, **F12** attiva e disattiva i comandi MAME sia su
Windows sia su macOS. Né F12 né Scroll Lock inviano un tasto all'M40.
Se assegnazioni personalizzate salvate in precedenza prevalgono sul profilo,
assegnare F12 a **Toggle UI Controls** e cancellare l'assegnazione di
**Save Snapshot** in **Input Settings → Input Assignments (general) →
User Interface**. Premere F12 da solo, senza Shift, Ctrl o Alt.

### Selezionare l'avvio da floppy e leggere la barra di stato

Fare clic su **HD/FLOPPY** per cambiare il dispositivo di avvio. Per questa
guida scegliere **FLOPPY**. Lasciare **K1, K2 e K3** su **NORMAL**; fare clic
sulla relativa etichetta per cambiare posizione.

Se si cambia il dispositivo di avvio dopo l'accensione, riavviare la macchina:
premere **F12**, **Shift+F3**, quindi ancora **F12**. Questa sequenza presuppone
che i comandi MAME fossero inizialmente disattivati. Non riavviare durante
una scrittura su disco.

Le quattro spie sono **READY, L1, L2 e SHIFT**. Sono controllate da BCOS;
READY non deve necessariamente restare accesa. **L2 si accende quando è
attiva la modalità TEST.** Le spie sono indicatori, non interruttori cliccabili.

### Inserire o cambiare un floppy

**flop1 corrisponde a FD1 in BCOS; flop2 corrisponde a FD2.**

Per inserire un disco in un'unità vuota, aprire il menu di MAME come descritto
sopra, scegliere **File Manager**, selezionare l'unità e poi l'immagine.
Se richiesto, scegliere **Read-write** per un disco di lavoro. Tornare quindi
a BCOS seguendo la procedura di chiusura del menu.

Per sostituire un disco:

1. In **File Manager**, selezionare l'unità e usare la voce di espulsione
   o di unità vuota per rimuovere il disco.
2. Tornare a BCOS e lasciarlo funzionare per **due secondi con l'unità vuota**.
3. Aprire nuovamente **File Manager** e inserire il nuovo disco nella stessa unità.
4. Tornare a BCOS e attendere **tre secondi** prima di rispondere alla richiesta.

Il tempo trascorso in un menu con l'emulazione in pausa non conta come
intervallo con l'unità vuota.

### Tasti da usare in BCOS

Usare le normali posizioni QWERTY delle lettere sulla tastiera PC.
**Invio principale e Invio del tastierino numerico sono tasti diversi.**
In questa guida **Shift** indica il tasto Maiusc.

| Tasto PC | Utilizzo in BCOS |
|---|---|
| **Cifre del tastierino numerico** | Date, numeri dei menu e cifra di FD2 |
| **Invio del tastierino numerico** | Confermare campi e comandi |
| **Invio principale** | Rispondere a `AFTER ANY KEY : GO` e `Press S bar` |
| **Shift + lettera** | Lettere maiuscole nelle risposte e nella password |
| **Alt+C** | Cancellare l'errore di tastiera indicato da E o KE |
| **F8** | RUN/riprova; confermare il messaggio `ERROR` del generatore |
| **Ctrl+F8** | Attivare/disattivare TEST al prompt `/SYS`; controllare L2 |
| **Frecce sinistra/destra** | Spostarsi all'interno di un campo |

Entrambi i tasti Ctrl del PC inviano CONTROL all'M40; entrambi i tasti Shift
inviano SHIFT. Caps Lock invia il tasto LOCK dell'M40, non una conversione
in maiuscolo eseguita da Windows. Usare Shift per le risposte maiuscole.
Non dare per scontato che Backspace modifichi i campi numerici come una
casella di testo di Windows.

Le tastiere originali hanno etichette diverse. Nella fotografia dell'ANK1402,
il tasto rosso **CLEAR** corrisponde ad **Alt+C** sul PC. Nella fotografia
dell'ANK1426, la stessa posizione è etichettata `*`. Il tasto **RES**
dell'ANK1426 corrisponde a **End** sul PC: non è il tasto usato qui per
cancellare gli errori. Il tasto originale **F8/F16** corrisponde a **F8**
sul PC. Il distinto tasto **RUN** dell'ANK1426 corrisponde ad **Alt+R**,
non alla funzione RUN usata da BCOS in questa guida.

Per tasti funzione, navigazione, punteggiatura e combinazioni Alt, consultare
la [mappa completa della tastiera PC e le sequenze diagnostiche](M40_KEYBOARD.md)
(in inglese).

<details>
<summary>Fotografie delle tastiere originali</summary>

ANK1426 — QWERTY, con tasti etichettati per BASIC:

![ANK1426](BCOS_GUIDE_IMAGES/ANK1426.jpg)

ANK1402 — usare la foto per identificare i comandi, non per riordinare
le lettere sulla tastiera PC:

![ANK1402](BCOS_GUIDE_IMAGES/ANK1402.jpeg)

</details>

## 1. Preparare i dischi di lavoro

Eseguire questi comandi una volta sola. Scegliere un nuovo nome di cartella
se `work\bcos` contiene già un sistema da conservare.

```bat
mkdir work\bcos
copy "flop\K02733_BCOS_II_3.3_CONFIGURATOR.imd" "work\bcos\CONFIG.imd"
copy "flop\K02741_BCOS_II_3.3_JJKEYB.imd" "work\bcos\KEYBOARD.imd"
copy "flop\K02741_BCOS_II_3.3_JJKEYB.imd" "work\bcos\LOAD.imd"
copy "flop\K02741_BCOS_II_3.3_JJKEYB.imd" "work\bcos\RUN.imd"
attrib -R "work\bcos\*.imd"
```

LOAD e RUN iniziano come copie di un disco formattato. Il configuratore
ne sostituirà il contenuto. Lasciare inalterati gli originali in `flop`.

## 2. Avviare il configuratore

Inserire questo comando su una sola riga:

```bat
mame.exe m40 -window -ramsize 2048K -uimodekey F12 -ctrlr m40-ui -flop1 "work\bcos\CONFIG.imd" -flop2 "work\bcos\KEYBOARD.imd"
```

1. Confermare gli eventuali avvisi iniziali di MAME.
2. Controllare la barra di stato. Se indica **HD**, fare clic per selezionare
   **FLOPPY** e riavviare come descritto nella sezione sui comandi.
3. Attendere **DATE YYMMDD**. L'avvio può richiedere circa 90 secondi.
4. Digitare **860909** sul tastierino numerico e premere **Invio del tastierino**.
5. Alla richiesta **SYS**, digitare **sys** e premere **Invio del tastierino**.
6. Alla scelta Continue/Exit, digitare **C** maiuscola e premere **Invio del tastierino**.

## 3. Scegliere il sistema e la tastiera

1. In **SYSTEM ENVIRONMENT CHOICE**, impostare **COMPLETE SYSTEM = Y**.
   Se **RUN-TIME ONLY WITH DEBUGGER** è ancora modificabile, impostarlo su **N**.
2. Scegliere una password e annotarla. Usare **Shift** per le lettere maiuscole.
3. Confermare i campi con **Invio del tastierino** e scegliere **C** per continuare.
4. Se viene chiesto il tipo di sistema o di unità di memorizzazione,
   scegliere **M40, floppy-only / mono FDU**.
5. Nelle schermate delle opzioni software, selezionare **tutte le opzioni
   disponibili** per il sistema completo, non solo BASIC. È la configurazione
   usata per il sistema LOAD/RUN fornito.
6. Confermare le scelte. Quando viene chiesta l'unità contenente i file della
   tastiera, digitare **FD2** e premere **Invio del tastierino**. Il comando
   di avvio ha già inserito il disco della tastiera in FD2: non occorre
   inserire o cambiare alcun disco a questo punto.
   Usare Shift per F e D, poi rilasciarlo e premere 2 sul tastierino.
   Se il cursore parte dalla seconda posizione del campo, premere prima
   **una volta la freccia sinistra**.
7. Quando richiesto, confermare il volume visualizzato.
8. Nell'elenco delle tastiere nazionali, scegliere **13 — USA-ASCII** con
   le cifre del tastierino e premere **Invio del tastierino**.
   Attendere **Firmware file copied**.
9. Alla richiesta **Press S bar**, premere **Invio principale**, non Spazio.

## 4. Creare LOAD e RUN

Lasciare **CONFIG in FD1** per tutta la generazione.

1. Quando viene chiesto di rimuovere il disco della tastiera, espellere
   **KEYBOARD da FD2**.
2. Seguire la procedura di cambio disco descritta sopra e inserire
   **work\bcos\LOAD.imd** in FD2.
3. Per il primo disco di destinazione, inserire **DRIVE NAME: FD2**,
   **VOLUME CODE: LOAD** e **OWNER: TP**. Confermare e attendere il termine
   della scrittura e della verifica.
4. Quando viene richiesto il disco RUN-TIME, espellere LOAD e inserire
   il distinto file **work\bcos\RUN.imd** in FD2, seguendo la stessa procedura
   di cambio disco.
5. Inserire **DRIVE NAME: FD2**, **VOLUME CODE: RUN** e **OWNER: TP**.
6. Attendere il termine della generazione, quindi usare l'opzione Exit visualizzata.
7. Chiudere la finestra di MAME solo quando le scritture su disco sono terminate.

Ora ci sono due dischi diversi. **Generarli entrambi: non creare RUN copiando
il disco LOAD già generato.** I nomi LOAD e RUN inseriti in BCOS sono le
etichette dei volumi; rinominare il file immagine in Windows non cambia
l'etichetta del volume.

## 5. Avviare il nuovo sistema

```bat
mame.exe m40 -window -ramsize 2048K -uimodekey F12 -ctrlr m40-ui -flop1 "work\bcos\LOAD.imd"
```

1. Verificare che la barra di stato indichi **FLOPPY**. Se indica **HD**,
   cambiare la selezione e riavviare come descritto nella sezione sui comandi.
2. Attendere **DISMOUNT LOAD-TIME DISK / MOUNT RUN-TIME DISK**.
3. Espellere **LOAD da FD1**, lasciare funzionare il sistema con l'unità
   vuota per almeno due secondi, poi inserire **work\bcos\RUN.imd in FD1**.
   Attendere circa tre secondi.
4. Alla richiesta **AFTER ANY KEY : GO**, premere **Invio principale**.
5. Inserire la password scelta durante la configurazione e premere
   **Invio del tastierino**.
6. Inserire **860909** con le cifre del tastierino e premere **Invio del tastierino**.
7. Attendere **/SYS**. Lasciare RUN inserito in FD1.

## 6. Aprire BASIC

1. Al prompt **/SYS**, controllare **L2**. Se è spenta, tenere premuto
   **Ctrl**, premere e rilasciare **F8**, poi rilasciare Ctrl. L2 dovrebbe
   accendersi. Se è già accesa, non premere la combinazione.
2. Digitare **basic** e premere **Invio del tastierino**.
3. Dovrebbe apparire **EDIT**.

**Verificato finora: BASIC si apre mostrando EDIT.** L'inserimento e
l'esecuzione di programmi non sono ancora stati verificati. Questi passaggi
sono stati provati su macOS; la verifica su Windows è ancora da effettuare.

## Avviare il sistema fornito

Per saltare la configurazione, copiare la coppia LOAD/RUN fornita:

```bat
mkdir work\ready
copy "flop\BCOS_LOAD.imd" "work\ready\LOAD.imd"
copy "flop\BCOS_RUN.imd" "work\ready\RUN.imd"
attrib -R "work\ready\*.imd"
mame.exe m40 -window -ramsize 2048K -uimodekey F12 -ctrlr m40-ui -flop1 "work\ready\LOAD.imd"
```

Seguire **5. Avviare il nuovo sistema**, usando `work\ready\RUN.imd` per
il cambio disco. Usare la password configurata per il sistema fornito.
Proseguire con **6. Aprire BASIC**.

## In caso di problemi

| Problema | Cosa fare |
|---|---|
| Tab non apre il menu | Premere F12 per attivare i comandi MAME, poi Tab |
| Compare E o KE in basso a sinistra | Premere Alt+C una volta |
| Il generatore mostra ERROR dopo una c minuscola | Cancellare KE se presente, premere F8, poi inserire C maiuscola e Invio del tastierino |
| BASIC segnala SYS ERR.163 | Cancellare l'errore con Alt+C; attivare TEST con Ctrl+F8 e controllare L2 |
| Compare SYS ERR.006 dopo il cambio da LOAD a RUN | Riavviare e seguire la procedura di espulsione, attesa e inserimento |
