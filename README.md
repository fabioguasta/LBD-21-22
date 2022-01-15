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
consigliabile eseguirlo direttamente nella macchina virtuale, se possibile.

##Spec
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
Nel progetto, è di interesse rappresentare la topologia del Museo (occorre tenere traccia di quali sono
le sale raggiungibili da qualsiasi altra sala e le informazioni di interesse di ciascuna sala), i nomi degli
ambienti, l’esclusività e il modo in cui sono utilizzati i diversi ambienti.
E’ di interesse rappresentare quali sono le opere esposte nelle diverse sale e rappresentare i loro artisti.
Il monitoraggio delle presenze dei visitatori all’interno del Museo viene effettuato come segue:
1. All’ingresso del Museo, a ciascun visitatore viene consegnato un dispositivo elettronico di
rilevamento.
2. Nel Museo, ciascun varco è dotato di un sensore; ogni volta che un visitatore transita
attraverso un varco, per entrare in un altro ambiente, il sensore del varco invia al sistema di
monitoraggio i dati sul transito rilevato.
3. Quando un visitatore esce dal Museo, restituisce il dispositivo elettronico di rilevamento.
Un visitatore può acquistare un abbonamento.

Gli abbonamenti possono essere semplici o esclusivi.
Gli abbonamenti possono essere singoli o multipli: in tal caso occorre tenere traccia di tutte le persone
associate al particolare abbonamento anche se l’acquisto viene effettuato da una sola persona.
Esempi di abbonamenti semplici:
• 100 sale in un anno (30 euro): 100 sale del sistema museale (anche 100 visite alla stessa sala).
Un visitatore non abbonato paga una visita singola, scegliendo prima della visita il tipo di tariffa.
Le tariffe sono flessibili e possono variare nel tempo.
Esempi di tariffe:
● Tariffa bianca (a sale): Il prezzo della visita è calcolato in base al numero di sale visitate (senza
limiti di tempo): moltiplicando il numero di sale in cui il Visitatore pensa di entrare per un
fattore moltiplicativo fisso di 3 euro per le collezioni permanenti e di 5 euro a sala per le
mostre temporanee.
Il visitatore potrà accedere al museo, dopo che il Sistema avrà registrato il pagamento e generato una
ricevuta.
Nel caso di un abbonamento, occorre verificare che l’abbonamento ha ancora un numero di sale
visitabili maggiore di zero. Nel caso in cui il numero di sale rimanenti diventa zero occorre invitare
il visitatore ad uscire dal museo, senza soffermarsi in altre sale.
Il sistema gestisce anche l’invio, via mail, di due newsletter bimensili, “il Museo Scientifico” e “il
Museo d’Arte”, cui chiunque può iscriversi per essere informato sulle mostre temporanee.
Il dispositivo permette anche di avere, gratuitamente, una descrizione delle sale e delle opere,
leggendo i QR code posti ai varchi e di fianco alle opere. Il Visitatore può scegliere la lingua e il tipo
di descrizione: per adulti e per bambini.
La base di dati deve tenere traccia di tutte le persone (nominativi, recapiti, ...) che visitano il museo
(cioè le sale museali e/o quelle mostre), ma non di quelle che accedono agli ambienti di servizio; il sistema tiene traccia dello storico, cioè di tutto ciò che è avvenuto nel tempo - con riferimento ad
abbonamenti, biglietti, riviste spedite, sale visitate - senza cancellare nulla.
Ogni museo prevede dei campi estivi per fasce di età, prevalentemente minorenni.
Occorre quindi gestire tali attività sia dal punto di vista economico (acquisto, prenotazione, ecc…)
sia dal punto di vista degli utenti (al campo estivo partecipano più ragazzi, ma il pagamento è
effettuato da uno dei genitori, e così via).


