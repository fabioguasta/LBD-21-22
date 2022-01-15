# LBD2122
Progetto musei Laboratorio di basi di dati 2021/2022
In ciascuna subdirectory sono presenti i file plsql dei pacchetti e script creati dai vari gruppi
per la realizzazione dell'applicazione
## files
API per il caricamento di un file nella base di dati
## gestioneDB
Files per la gestione delle tabelle ed il caricamento dati
## modGUI
Directory contenete il pacchetto dell'interfaccia grafica, la procedura di login/logout e la home page
## Altre subdirectory
Pacchetti dei vari gruppi della terza fase
## run_all.plsql
Uno script SQL attraverso il quale creare le tabelle, caricare i dati e creare i pacchetti di tutti i gruppi
Data la dimensione del populate_table l'esecuzione dello script potrebbe richiedere molto tempo, per cui è 
consigliabile eseguirlo direttamente nella macchina virtuale, se possibile

Si richiede di progettare e sviluppare Un giorno al Museo, un software di gestione di un sistema
museale.
Alcune informazioni sul generico museo (Museo d’ora in poi):
Il Museo possiede una propria collezione di opere, che espone in modo stabile. Ad esempio,
l’Autoritratto giovanile di Rembrandt se un museo d’arte, o un cannocchiale di Galileo, se un museo
della scienza
Il Museo inoltre ospita delle mostre temporanee, con opere prestate da altri musei, anche non
appartenenti al sistema museale della Toscana. Ad esempio, una mostra su Cindy Sherman o una
mostra sui sestanti.
Il Museo è composto di diversi ambienti (cioè stanze), di varie tipologie, come segue:
● Sale museali, dedicate stabilmente all’esposizione delle opere della collezione del Museo.
● Sale per mostre, dedicate all’esposizione di mostre temporanee.
● Sale “esclusive”, dedicate all’esposizione di “opere esclusive”, solo per alcuni abbonamenti
“speciali”. che consentono di accedere a delle sale esclusive per “opere esclusive”. Tali sale
non sono quindi visitabili dai visitatori che hanno abbonamenti “semplici” o che accedono al
museo con biglietto;
● Nessuna sala viene utilizzata per esporre sia opere della collezione del Museo che opere di
mostre temporanee.
● Altri ambienti di servizio (che non contengono opere): la biglietteria, un bar, un ristorante,
alcuni bagni.
I diversi ambienti del museo sono collegati tra di loro tramite dei varchi (ovvero passaggi di vario
tipo, come aperture, porte o scale). Ogni varco collega, dunque, un ambiente con un altro ambiente
del Museo.

