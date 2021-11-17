CREATE OR REPLACE PACKAGE BODY gruppo1 AS

/*
 grant execute on gruppo1 to anonymous;
 *http://131.114.73.203:8080/apex/fgiannotti.gruppo1.InserisciUtente
 * OPERAZIONI SUGLI UTENTI
 * - Inserimento ✅
 * - Modifica ❌
 * - Visualizzazione ❌
 * - Cancellazione (rimozione) ❌
 * OPERAZIONI STATISTICHE E MONITORAGGIO
 * - Numero Musei visitati in un arco temporale scelto ❌
 * - Numero Titoli d’Ingresso  acquistati in un arco temporale scelto ❌
 * - Numero medio Titoli d’Ingresso acquistati in un arco temporale scelto ❌
 * - Età media utenti ❌
 * - Spesa media di un visitatore in un arco temporale scelto ❌
 */


/*
 *  OPERAZIONI SULLE TIPOLOGIE DI INGRESSO
 * - Inserimento ❌
 * - Modifica ❌
 * - Visualizzazione ❌
 * - Cancellazione (rimozione) ❌
 * OPERAZIONI STATISTICHE E MONITORAGGIO
 * - Tipologia più scelta in un arco temporale scelto ❌
 * - Lista Tipologie in ordine di prezzo crescente ❌
*/

/*
 *  OPERAZIONI SUI TITOLI DI INGRESSO
 * - Modifica ❌
 * - Cancellazione❌
 * - Visualizzazione ❌
 * - Acquisto abbonamento museale ❌
 * - Acquisto biglietto ❌
 * OPERAZIONI STATISTICHE E MONITORAGGIO
 * - Numero Titoli d’Ingresso emessi in un arco temporale scelto ❌
 * - Numero Titoli d’Ingresso emessi da un Museo in un arco temporale scelto ❌
 * - Abbonamenti in scadenza nel mese corrente ❌
*/

--Procedura per inserimento Utente
PROCEDURE InserisciUtente(
    sessionID NUMBER DEFAULT 0,
	nome VARCHAR2 DEFAULT NULL,
	cognome VARCHAR2 DEFAULT NULL,
	dataNascita VARCHAR2 DEFAULT NULL,
	indirizzo VARCHAR2 DEFAULT NULL,
	email VARCHAR2 DEFAULT NULL,
    telefono VARCHAR2 DEFAULT NULL,
	utenteMuseo VARCHAR2 DEFAULT NULL,
	utenteDonatore VARCHAR2 DEFAULT NULL,
	utenteCampiEstivi VARCHAR2 DEFAULT NULL,
	utenteAssistenza VARCHAR2 DEFAULT NULL
) IS
BEGIN

    MODGUI1.ApriPagina('Inserimento utenti', 0);

	HTP.BodyOpen;
	MODGUI1.Header(); --da capire come combinarlo con il resto
	HTP.header(1,'Inserisci un nuovo utente', 'center');
	modgui1.apridiv('class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px; margin-top:110px"');

	MODGUI1.ApriForm('ConfermaDatiUtente');
	HTP.FORMHIDDEN('sessionID',0);

	MODGUI1.Label('Nome*');
	MODGUI1.InputText('nome', 'Nome utente', 1, nome);
	HTP.BR;
	MODGUI1.Label('Cognome*');
	MODGUI1.InputText('cognome', 'Cognome utente', 1, cognome);
	HTP.BR;
	MODGUI1.Label('Data nascita*');
	MODGUI1.InputDate('dataNascita', 'dataNascita', 1, dataNascita);
	HTP.BR;
	MODGUI1.Label('Indirizzo*');
	MODGUI1.InputText('indirizzo', 'Indirizzo', 1, indirizzo);
	HTP.BR;
	MODGUI1.Label('Email*');
	MODGUI1.InputText('email', 'Email', 1, email);
	HTP.BR;
	MODGUI1.Label('Telefono');
	MODGUI1.InputText('telefono', 'Telefono', 0, telefono);
	HTP.BR;
	if utenteMuseo = 'on' then
		MODGUI1.InputCheckboxOnClick('Utente museo', 'utenteMuseo','check()','utentemuseo', 1);
		MODGUI1.ApriDiv('style="margin-left: 2%; margin-right: 2%; display: block" id="first"');
	else 
		MODGUI1.InputCheckboxOnClick('Utente museo', 'utenteMuseo','check()','utentemuseo');
		MODGUI1.ApriDiv('style="margin-left: 2%; margin-right: 2%; display: none" id="first"');
	end if;
	HTP.BR;
	if utenteDonatore = 'on' then
		MODGUI1.InputCheckbox('Donatore', 'utenteDonatore', 1);
	else 
		MODGUI1.InputCheckbox('Donatore', 'utenteDonatore');
	end if;
	HTP.BR;
	MODGUI1.ChiudiDiv;
	HTP.BR;
	if utenteCampiEstivi = 'on' then
		MODGUI1.InputCheckboxOnClick('Utente campi estivi', 'utenteCampiEstivi', 'check2()', 'utentecampiestivi', 1);
		MODGUI1.ApriDiv('style="margin-left: 2%; margin-right: 2%; display: block" id="second"');
	else
		MODGUI1.InputCheckboxOnClick('Utente campi estivi', 'utenteCampiEstivi', 'check2()', 'utentecampiestivi');
		MODGUI1.ApriDiv('style="margin-left: 2%; margin-right: 2%; display: none" id="second"');
	end if;
	HTP.BR;
	if utenteAssistenza = 'on' then
		MODGUI1.InputCheckbox('Richiede assistenza', 'utenteAssistenza', 1);
	else 
		MODGUI1.InputCheckbox('Richiede assistenza', 'utenteAssistenza');
	end if;
	HTP.BR;
	MODGUI1.ChiudiDiv;

	MODGUI1.InputSubmit('Inserisci');
	MODGUI1.ChiudiForm;

	MODGUI1.ChiudiDiv;

	htp.print('<script type="text/javascript">
			function check() {
				const div1 = document.getElementById("first")
				const checkbox1 = document.getElementById("utentemuseo")
				if(checkbox1.checked == true) {
					div1.style.display = "block"
				}
				else {
					div1.style.display = "none"
					const inputs = div1.getElementsByTagName("input")
					for (let input of inputs) {
						input.checked = false
					}
				}
			}

			function check2() {
				const div1 = document.getElementById("second")
				const checkbox1 = document.getElementById("utentecampiestivi")
				if(checkbox1.checked == true) {
					div1.style.display = "block"
				}
				else {
					div1.style.display = "none"
					const inputs = div1.getElementsByTagName("input")
					for (let input of inputs) {
						input.checked = false
					}
				}
			}
        </script>');

	HTP.BodyClose;
	HTP.HtmlClose;
END;

-- Procedura per confermare i dati dell'inserimento di un Utente
PROCEDURE ConfermaDatiUtente(
	sessionID NUMBER DEFAULT 0,
	nome VARCHAR2 DEFAULT NULL,
	cognome VARCHAR2 DEFAULT NULL,
	dataNascita VARCHAR2 DEFAULT NULL,
	indirizzo VARCHAR2 DEFAULT NULL,
	email VARCHAR2 DEFAULT NULL,
    telefono VARCHAR2 DEFAULT NULL,
	utenteMuseo VARCHAR2 DEFAULT NULL,
	utenteDonatore VARCHAR2 DEFAULT NULL,
	utenteCampiEstivi VARCHAR2 DEFAULT NULL,
	utenteAssistenza VARCHAR2 DEFAULT NULL
) IS
BEGIN
	-- se utente non autorizzato: messaggio errore
	IF nome IS NULL
	OR cognome IS NULL
	OR (dataNascita IS NOT NULL
		AND to_date(dataNascita, 'YYYY-MM-DD') > sysdate)
	OR indirizzo IS NULL
    OR email IS NULL
	THEN
		-- uno dei parametri con vincoli ha valori non validi
		MODGUI1.APRIPAGINA('Pagina errore', 0);
		HTP.BodyOpen;
		MODGUI1.Header();
		MODGUI1.ApriDiv;
		HTP.PRINT('Uno dei parametri immessi non valido');
		MODGUI1.ChiudiDiv;
		HTP.BodyClose;
		HTP.HtmlClose;
	ELSE
		MODGUI1.APRIPAGINA('Pagina OK', 0);
		HTP.BodyOpen;
		MODGUI1.Header();
		HTP.header(1, 'Conferma immissione dati');

		modgui1.apridiv('class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px; margin-top:110px"');
		HTP.header(2, 'Nuovo utente');

		HTP.TableOpen;
		HTP.TableRowOpen;
		HTP.TableData('Nome: ');
		HTP.TableData(nome);
		HTP.TableRowClose;
		HTP.TableRowOpen;
		HTP.TableData('Cognome: ');
		HTP.TableData(cognome);
		HTP.TableRowClose;
		HTP.TableRowOpen;
		HTP.TableData('Data Nascita: ');
		HTP.TableData(dataNascita);
		HTP.TableRowClose;
		HTP.TableRowOpen;
		HTP.TableData('Indirizzo: ');
		HTP.TableData(indirizzo);
		HTP.TableRowClose;
		HTP.TableRowOpen;
		HTP.TableData('Email: ');
		HTP.TableData(email);
		HTP.TableRowClose;
		HTP.TableRowOpen;
        HTP.TableData('Telefono: ');
		HTP.TableData(telefono);
		HTP.TableRowClose;
		if utenteMuseo = 'on' then
			HTP.TableRowOpen;
			HTP.TableData('Utente museo: ');
			HTP.TableData('&#10004');
			HTP.TableRowClose;
			if utenteDonatore = 'on' then
				HTP.TableRowOpen;
				HTP.TableData('Donatore: ');
				HTP.TableData('&#10004');
				HTP.TableRowClose;
			end if;
		end if;
		if utenteCampiEstivi = 'on' then
			HTP.TableRowOpen;
			HTP.TableData('Utente campi estivo: ');
			HTP.TableData('&#10004');
			HTP.TableRowClose;
			if utenteAssistenza = 'on' then 
				HTP.TableRowOpen;
				HTP.TableData('Richiesta assistenza: ');
				HTP.TableData('&#10004');
				HTP.TableRowClose;
			end if;
		end if;
		HTP.TableClose;

		MODGUI1.ApriForm('InserisciDatiUtente');
		HTP.FORMHIDDEN('sessionID', 0);
		HTP.FORMHIDDEN('nome', nome);
		HTP.FORMHIDDEN('cognome', cognome);
		HTP.FORMHIDDEN('dataNascita', dataNascita);
		HTP.FORMHIDDEN('Indirizzo', indirizzo);
		HTP.FORMHIDDEN('utenteEmail', email);
        HTP.FORMHIDDEN('Telefono', telefono);
		if utenteMuseo = 'on' then
			HTP.FORMHIDDEN('utenteMuseo', utenteMuseo);
			if utenteDonatore = 'on' then
				 HTP.FORMHIDDEN('utenteDonatore', utenteDonatore);
			end if;
		end if;
		if utenteCampiEstivi = 'on' then
			HTP.FORMHIDDEN('utenteCampiEstivi', utenteCampiEstivi);
			if utenteAssistenza = 'on' then
				HTP.FORMHIDDEN('utenteAssistenza', utenteAssistenza);
			end if;
		end if;
		MODGUI1.InputSubmit('Conferma');
		MODGUI1.ChiudiForm;
		MODGUI1.Collegamento(
            'Annulla',
			'InserisciUtente?nome='||nome||'&cognome='||cognome||'&dataNascita='||dataNascita||'&indirizzo='||indirizzo||'&email='||email||'&telefono='||telefono||'&utenteMuseo='||utenteMuseo||'&utenteDonatore='||utenteDonatore||'&utenteCampiEstivi='||utenteCampiEstivi||'&utenteAssistenza='||utenteAssistenza,
			'w3-btn'
        );
		MODGUI1.ChiudiDiv;
		HTP.BodyClose;
		HTP.HtmlClose;
	END IF;
	EXCEPTION WHEN OTHERS THEN
		dbms_output.put_line('Error: '||sqlerrm);
END;

PROCEDURE InserisciDatiUtente (
    sessionID NUMBER DEFAULT 0,
	nome VARCHAR2 DEFAULT NULL,
	cognome VARCHAR2 DEFAULT NULL,
	dataNascita VARCHAR2 DEFAULT NULL,
	indirizzo VARCHAR2 DEFAULT NULL,
	utenteEmail VARCHAR2 DEFAULT NULL,
    telefono VARCHAR2 DEFAULT NULL,
	utenteMuseo VARCHAR2 DEFAULT NULL,
	utenteDonatore VARCHAR2 DEFAULT NULL,
	utenteCampiEstivi VARCHAR2 DEFAULT NULL,
	utenteAssistenza VARCHAR2 DEFAULT NULL
) IS
    birth DATE := TO_DATE(dataNascita default NULL on conversion error, 'YYYY-MM-DD');
    EmailPresente EXCEPTION;
    TelefonoPresente EXCEPTION;
    temp NUMBER(10) := 0;
    temp2 NUMBER(10) := 0;
	tempIdUtente NUMBER(10) := 0;

BEGIN

    -- tutti i parametri sono stati controllati prima, dobbiamo solo inserirli nella tabella
    SELECT count(*) INTO temp FROM UTENTI WHERE UTENTI.Email = utenteEmail;

    IF temp > 0 THEN
        RAISE EmailPresente;
    END IF;

    select count(*) INTO temp2 from UTENTI where RecapitoTelefonico = telefono;

    IF temp2 > 0 THEN
        RAISE TelefonoPresente;
    END IF;

    insert into UTENTI
    values (IdUtenteSeq.NEXTVAL, nome, cognome, birth, indirizzo, utenteEmail, telefono);

	select IdUtente into tempIdUtente from UTENTI where UTENTI.Email = utenteEmail;

	if utenteMuseo = 'on' then
		if utenteDonatore = 'on' then
			insert into UTENTIMUSEO
			values (tempIdUtente, 1);
		else
			insert into UTENTIMUSEO
			values (tempIdUtente, 0);
		end if;
	end if;

	if utenteCampiEstivi = 'on' then
		if utenteAssistenza = 'on' then
			insert into UTENTICAMPIESTIVI
			values (tempIdUtente, 1);
		else
			insert into UTENTICAMPIESTIVI
			values (tempIdUtente, 0);
		end if;
	end if;

	IF SQL%FOUND
	THEN
		-- faccio il commit dello statement precedente
		commit;

		MODGUI1.ApriPagina('Utente inserito', sessionID);
		HTP.BodyOpen;
		MODGUI1.Header();
		modgui1.apridiv('class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px; margin-top:110px"');
		HTP.tableopen;
		HTP.tablerowopen;
		HTP.tabledata('Nome: '||nome);
		HTP.tablerowclose;
		HTP.tablerowopen;
		HTP.tabledata('Cognome: '||cognome);
		HTP.tablerowclose;
		HTP.tablerowopen;
		HTP.tabledata('Data nascita: '||birth);
		HTP.tablerowclose;
		HTP.tablerowopen;
		HTP.tabledata('Indirizzo: '||indirizzo);
		HTP.tablerowopen;
		HTP.tablerowclose;
		HTP.tablerowopen;
		HTP.tabledata('Email: '||utenteEmail);
		HTP.tablerowclose;
		HTP.tablerowopen;
		HTP.tabledata('Telefono: '||telefono);
		HTP.tablerowclose;
		if utenteMuseo = 'on' then
			HTP.TableRowOpen;
			HTP.TableData('Utente museo: ');
			HTP.TableData('&#10004');
			HTP.TableRowClose;
			if utenteDonatore = 'on' then
				HTP.TableRowOpen;
				HTP.TableData('Donatore: ');
				HTP.TableData('&#10004');
				HTP.TableRowClose;
			end if;
		end if;
		if utenteCampiEstivi = 'on' then
			HTP.TableRowOpen;
			HTP.TableData('Utente campi estivo: ');
			HTP.TableData('&#10004');
			HTP.TableRowClose;
			if utenteAssistenza = 'on' then 
				HTP.TableRowOpen;
				HTP.TableData('Richiesta assistenza: ');
				HTP.TableData('&#10004');
				HTP.TableRowClose;
			end if;
		end if;
		HTP.tableClose;
		MODGUI1.ChiudiDiv;
		HTP.BodyClose;
		HTP.HtmlClose;
	ELSE
		MODGUI1.ApriPagina('Utente non inserito', sessionID);
		HTP.BodyOpen;

		HTP.PRN('Utente non inserito');

		HTP.BodyClose;
		HTP.HtmlClose;
	END IF;

    EXCEPTION
      when EmailPresente then
        MODGUI1.ApriPagina('Errore', sessionID);
		MODGUI1.Header();
		HTP.BodyOpen;

		MODGUI1.ApriDiv;
		HTP.PRN('Email già presente');
		MODGUI1.collegamento('Inserisci nuovo utente', 'InserisciUtente');
		MODGUI1.ChiudiDiv;

		HTP.BodyClose;
		HTP.HtmlClose;
    when TelefonoPresente then
        MODGUI1.ApriPagina('Errore', sessionID);
		MODGUI1.Header();
		HTP.BodyOpen;

		MODGUI1.ApriDiv;
		HTP.PRN('Telefono già presente');
		MODGUI1.collegamento('Inserisci nuovo utente', 'InserisciUtente');
		MODGUI1.ChiudiDiv;

		HTP.BodyClose;
		HTP.HtmlClose;
END;

PROCEDURE VisualizzaUtente (
    sessionID NUMBER DEFAULT 0,
	utenteID NUMBER
)
IS
	NomeUtente UTENTI.Nome%TYPE;
    CognomeUtente UTENTI.Cognome%TYPE;
    DataNascitaUtente UTENTI.DataNascita%TYPE;
	IndirizzoUtente UTENTI.Indirizzo%TYPE;
	EmailUtente UTENTI.Email%TYPE;
	RecapitoTelefonicoUtente UTENTI.RecapitoTelefonico%TYPE;
	UtenteDonatore UTENTIMUSEO.Donatore%TYPE;
	UtenteAssistenza UTENTICAMPIESTIVI.Richiestaassistenza%TYPE;
	temp NUMBER(10) := 0;
    temp2 NUMBER(10) := 0;


BEGIN

	select NOME, COGNOME, DATANASCITA, INDIRIZZO, EMAIL, RECAPITOTELEFONICO
	into NomeUtente, CognomeUtente, DataNascitaUtente, IndirizzoUtente, EmailUtente, RecapitoTelefonicoUtente
	from UTENTI
	where IDUTENTE = utenteID;

	select count(*) into temp from UTENTIMUSEO
	where utenteID = UTENTIMUSEO.idutente;

	if temp > 0 then
		select Donatore into UtenteDonatore from UTENTIMUSEO
		where utenteID = UTENTIMUSEO.idutente;
	end if;

	select count(*) into temp2 from UTENTICAMPIESTIVI
	where utenteID = UTENTICAMPIESTIVI.idutente;

	if temp2 > 0 then
		select Richiestaassistenza into UtenteAssistenza from UTENTICAMPIESTIVI
		where utenteID = UTENTICAMPIESTIVI.idutente;
	end if;

	IF SQL%FOUND
	THEN

		MODGUI1.ApriPagina('Profile utente', sessionID);
		HTP.BodyOpen;
		MODGUI1.Header(sessionID);
		modgui1.apridiv('class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px; margin-top:110px"');
		/*
		MODGUI1.ApriDiv('class="w3-center" style="margin: 0;
							position: absolute;
							top: 40%;
							left: 50%;
							margin-right: -50%;
							transform: translate(-50%, -50%)"');
		*/
		HTP.tableopen;
		HTP.tablerowopen;
		HTP.tabledata('Nome: '||NomeUtente);
		HTP.tablerowclose;
		HTP.tablerowopen;
		HTP.tabledata('Cognome: '||CognomeUtente);
		HTP.tablerowclose;
		HTP.tablerowopen;
		HTP.tabledata('Data nascita: '||DataNascitaUtente);
		HTP.tablerowclose;
		HTP.tablerowopen;
		HTP.tabledata('Indirizzo: '||IndirizzoUtente);
		HTP.tablerowopen;
		HTP.tablerowclose;
		HTP.tablerowopen;
		HTP.tabledata('Email: '||EmailUtente);
		HTP.tablerowclose;
		HTP.tablerowopen;
		HTP.tabledata('Telefono: '||RecapitoTelefonicoUtente);
		HTP.tablerowclose;
		if temp > 0 then
			HTP.TableRowOpen;
			HTP.TableData('Utente museo: ');
			HTP.TableData('&#10004');
			HTP.TableRowClose;
			if utenteDonatore > 0 then
				HTP.TableRowOpen;
				HTP.TableData('Donatore: ');
				HTP.TableData('&#10004');
				HTP.TableRowClose;
			end if;
		end if;
		if temp2 > 0 then
			HTP.TableRowOpen;
			HTP.TableData('Utente campi estivo: ');
			HTP.TableData('&#10004');
			HTP.TableRowClose;
			if UtenteAssistenza > 0 then 
				HTP.TableRowOpen;
				HTP.TableData('Richiesta assistenza: ');
				HTP.TableData('&#10004');
				HTP.TableRowClose;
			end if;
		end if;
		HTP.tableClose;
		MODGUI1.Collegamento('Modifica', 'ModificaUtente?sessionID='||sessionID||'&utenteID='||utenteID, 'w3-button w3-blue w3-margin');
		MODGUI1.Collegamento('Elimina', 'EliminaUtente?sessionID='||sessionID||'&utenteID='||utenteID, 'w3-button w3-red w3-margin');
		MODGUI1.ChiudiDiv;
		HTP.BodyClose;
		HTP.HtmlClose;
	ELSE
		MODGUI1.ApriPagina('Utente non trovato', sessionID);
		HTP.BodyOpen;

		HTP.PRN('Utente non trovato');

		HTP.BodyClose;
		HTP.HtmlClose;
	END IF;
END;

PROCEDURE ModificaUtente (
    sessionID NUMBER DEFAULT 0,
	utenteID NUMBER DEFAULT NULL
)
IS
	NomeUtente UTENTI.Nome%TYPE;
    CognomeUtente UTENTI.Cognome%TYPE;
    DataNascitaUtente UTENTI.DataNascita%TYPE;
	IndirizzoUtente UTENTI.Indirizzo%TYPE;
	EmailUtente UTENTI.Email%TYPE;
	RecapitoTelefonicoUtente UTENTI.RecapitoTelefonico%TYPE;
	UtenteDonatore UTENTIMUSEO.Donatore%TYPE;
	UtenteAssistenza UTENTICAMPIESTIVI.Richiestaassistenza%TYPE;
	temp NUMBER(10) := 0;
    temp2 NUMBER(10) := 0;

BEGIN

	select NOME, COGNOME, DATANASCITA, INDIRIZZO, EMAIL, RECAPITOTELEFONICO
	into NomeUtente, CognomeUtente, DataNascitaUtente, IndirizzoUtente, EmailUtente, RecapitoTelefonicoUtente
	from UTENTI
	where IDUTENTE = utenteID;

	select count(*) into temp from UTENTIMUSEO
	where utenteID = UTENTIMUSEO.idutente;

	if temp > 0 then
		select Donatore into UtenteDonatore from UTENTIMUSEO
		where utenteID = UTENTIMUSEO.idutente;
	end if;

	select count(*) into temp2 from UTENTICAMPIESTIVI
	where utenteID = UTENTICAMPIESTIVI.idutente;

	if temp2 > 0 then
		select Richiestaassistenza into UtenteAssistenza from UTENTICAMPIESTIVI
		where utenteID = UTENTICAMPIESTIVI.idutente;
	end if;

	IF SQL%FOUND
	THEN

		MODGUI1.ApriPagina('Profile utente', sessionID);
		HTP.BodyOpen;
		MODGUI1.Header(sessionID);
		modgui1.apridiv('class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px; margin-top:110px"');
		MODGUI1.ApriForm('ModificaDatiUtente');
		HTP.FORMHIDDEN('sessionID',0);
		HTP.FORMHIDDEN('utenteID',utenteID);
		MODGUI1.Label('Nome*');
		MODGUI1.InputText('nomeNew', 'Nome utente', 1, NomeUtente);
		HTP.BR;
		MODGUI1.Label('Cognome*');
		MODGUI1.InputText('cognomeNew', 'Cognome utente', 1, CognomeUtente);
		HTP.BR;
		MODGUI1.Label('Data nascita*');
		MODGUI1.InputDate('dataNascita', 'dataNascitaNew', 1, DataNascitaUtente);
		HTP.BR;
		MODGUI1.Label('Indirizzo*');
		MODGUI1.InputText('indirizzoNew', 'Indirizzo', 1, IndirizzoUtente);
		HTP.BR;
		MODGUI1.Label('Email*');
		MODGUI1.InputText('utenteEmailNEW', 'Email', 1, EmailUtente);
		HTP.BR;
		MODGUI1.Label('Telefono');
		MODGUI1.InputText('telefonoNew', 'Telefono', 0, RecapitoTelefonicoUtente);
		HTP.BR;
		if temp > 0 then
		MODGUI1.InputCheckboxOnClick('Utente museo', 'utenteMuseoNew','check()','utentemuseo', 1);
		MODGUI1.ApriDiv('style="margin-left: 2%; margin-right: 2%; display: block" id="first"');
		else 
			MODGUI1.InputCheckboxOnClick('Utente museo', 'utenteMuseoNew','check()','utentemuseo');
			MODGUI1.ApriDiv('style="margin-left: 2%; margin-right: 2%; display: none" id="first"');
		end if;
		HTP.BR;
		if utenteDonatore = 1 then
			MODGUI1.InputCheckbox('Donatore', 'utenteDonatoreNew', 1);
		else 
			MODGUI1.InputCheckbox('Donatore', 'utenteDonatoreNew');
		end if;
		HTP.BR;
		MODGUI1.ChiudiDiv;
		HTP.BR;
		if temp2 > 0 then
			MODGUI1.InputCheckboxOnClick('Utente campi estivi', 'utenteCampiEstiviNew', 'check2()', 'utentecampiestivi', 1);
			MODGUI1.ApriDiv('style="margin-left: 2%; margin-right: 2%; display: block" id="second"');
		else
			MODGUI1.InputCheckboxOnClick('Utente campi estivi', 'utenteCampiEstiviNew', 'check2()', 'utentecampiestivi');
			MODGUI1.ApriDiv('style="margin-left: 2%; margin-right: 2%; display: none" id="second"');
		end if;
		HTP.BR;
		if utenteAssistenza = 1 then
			MODGUI1.InputCheckbox('Richiede assistenza', 'utenteAssistenzaNew', 1);
		else 
			MODGUI1.InputCheckbox('Richiede assistenza', 'utenteAssistenzaNew');
		end if;
		HTP.BR;
		MODGUI1.ChiudiDiv;

		MODGUI1.InputSubmit('Salva');
		MODGUI1.ChiudiForm;
		MODGUI1.Collegamento(
            'Annulla',
			'VisualizzaUtente?sessionId='||sessionID||'&utenteID='||utenteID,
			'w3-btn'
        );
		MODGUI1.ChiudiDiv;
			htp.print('<script type="text/javascript">
			function check() {
				const div1 = document.getElementById("first")
				const checkbox1 = document.getElementById("utentemuseo")
				if(checkbox1.checked == true) {
					div1.style.display = "block"
				}
				else {
					div1.style.display = "none"
					const inputs = div1.getElementsByTagName("input")
					for (let input of inputs) {
						input.checked = false
					}
				}
			}

			function check2() {
				const div1 = document.getElementById("second")
				const checkbox1 = document.getElementById("utentecampiestivi")
				if(checkbox1.checked == true) {
					div1.style.display = "block"
				}
				else {
					div1.style.display = "none"
					const inputs = div1.getElementsByTagName("input")
					for (let input of inputs) {
						input.checked = false
					}
				}
			}
        </script>');

		HTP.BodyClose;
		HTP.HtmlClose;
	ELSE
		MODGUI1.ApriPagina('Utente non trovato', sessionID);
		HTP.BodyOpen;

		HTP.PRN('Utente non trovato');

		HTP.BodyClose;
		HTP.HtmlClose;
	END IF;
END;

PROCEDURE ModificaDatiUtente (
	sessionID NUMBER DEFAULT 0,
	utenteID NUMBER,
	nomeNew VARCHAR2 DEFAULT NULL,
	cognomeNew VARCHAR2 DEFAULT NULL,
	dataNascitaNew VARCHAR2 DEFAULT NULL,
	indirizzoNew VARCHAR2 DEFAULT NULL,
	utenteEmailNew VARCHAR2 DEFAULT NULL,
    telefonoNew VARCHAR2 DEFAULT NULL,
	utenteMuseoNew VARCHAR2 DEFAULT NULL,
	utenteDonatoreNew VARCHAR2 DEFAULT NULL,
	utenteCampiEstiviNew VARCHAR2 DEFAULT NULL,
	utenteAssistenzaNew VARCHAR2 DEFAULT NULL
) IS
    birth DATE := TO_DATE(dataNascitaNew default NULL on conversion error, 'YYYY-MM-DD');
    EmailPresente EXCEPTION;
    TelefonoPresente EXCEPTION;
    temp NUMBER(10) := 0;
    temp2 NUMBER(10) := 0;
	temp3 NUMBER(10) := 0;
    temp4 NUMBER(10) := 0;
	EmailUtente UTENTI.Email%TYPE;
	RecapitoTelefonicoUtente UTENTI.RecapitoTelefonico%TYPE;

BEGIN

	select email into EmailUtente from UTENTI where utenteID = UTENTI.IDutente;
	
	if EmailUtente != utenteEmailNew then 
		SELECT count(*) INTO temp FROM UTENTI WHERE UTENTI.Email = utenteEmailNew;
		IF temp > 0 THEN
			RAISE EmailPresente;
		END IF;
	end if;

	select RecapitoTelefonico into RecapitoTelefonicoUtente from UTENTI where utenteID = UTENTI.IDutente;

	if RecapitoTelefonicoUtente != telefonoNew then
		select count(*) INTO temp2 from UTENTI where RecapitoTelefonico = telefonoNew;
		IF temp2 > 0 THEN
			RAISE TelefonoPresente;
		END IF;
	end if;

	UPDATE UTENTI SET
		nome=nomeNew,
		cognome=cognomeNew,
		dataNascita=birth,
		indirizzo=indirizzoNew,
		email=utenteEmailNew,
		recapitotelefonico=telefonoNew
	WHERE IDutente=utenteID;

	
	select count(*) into temp3 from UTENTIMUSEO where UTENTIMUSEO.IdUtente = utenteID;

	if temp3 > 0 then
		if utenteMuseoNew = 'on' then
			if utenteDonatoreNew = 'on' then
				update UTENTIMUSEO set 
					donatore=1
				where idutente=utenteID;
			else
				update UTENTIMUSEO set 
					donatore=0
				where idutente=utenteID;
			end if;
		else
			delete from UTENTIMUSEO where idutente=utenteID;
		end if;
	else
		if utenteDonatoreNew = 'on' then
			insert into UTENTIMUSEO
			values (utenteID, 1);
		else
			insert into UTENTIMUSEO
			values (utenteID, 0);
		end if;
	end if;

	select count(*) into temp4 from UTENTICAMPIESTIVI where UTENTICAMPIESTIVI.IdUtente = utenteID;

	if temp4 > 0 then
		if utenteCampiEstiviNew = 'on' then
			if utenteCampiEstiviNew = 'on' then
				update UTENTICAMPIESTIVI set 
					Richiestaassistenza=1
				where idutente=utenteID;
			else
				update UTENTICAMPIESTIVI set 
					Richiestaassistenza=0
				where idutente=utenteID;
			end if;
		else
			delete from UTENTICAMPIESTIVI where idutente=utenteID;
		end if;
	else
		if utenteCampiEstiviNew = 'on' then
			insert into UTENTICAMPIESTIVI
			values (utenteID, 1);
		else
			insert into UTENTICAMPIESTIVI
			values (utenteID, 0);
		end if;
	end if;
	

	IF SQL%FOUND THEN
		MODGUI1.ApriPagina('Utente aggiornato', sessionID);
		HTP.BodyOpen;
		MODGUI1.Header(sessionID);
		modgui1.apridiv('class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px; margin-top:110px"');
		htp.print('<p>Utente aggiornato</p>');
		modgui1.chiudiDiv;
		HTP.BodyClose;
		HTP.HtmlClose;
	ELSE
		MODGUI1.ApriPagina('Utente non inserito', sessionID);
		HTP.BodyOpen;
		MODGUI1.Header(sessionID);
		HTP.PRN('Utente non inserito');

		HTP.BodyClose;
		HTP.HtmlClose;
	END IF;


END;

PROCEDURE EliminaUtente(
	sessionID NUMBER DEFAULT 0,
	utenteID NUMBER
)
IS
BEGIN

	delete from UTENTIMUSEO where IDUTENTE=utenteID;
	delete from UTENTICAMPIESTIVI where IDUTENTE=utenteID;
	delete from UTENTI where IDUTENTE=utenteID;

	IF SQL%FOUND THEN
		MODGUI1.ApriPagina('Utente eliminato', sessionID);
		HTP.BodyOpen;
		MODGUI1.Header(sessionID);
		modgui1.apridiv('class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px; margin-top:110px"');
		htp.print('<p>Utente eliminato</p>');
		modgui1.chiudiDiv;
		HTP.BodyClose;
		HTP.HtmlClose;
	ELSE
		MODGUI1.ApriPagina('Errore', sessionID);
		HTP.BodyOpen;
		MODGUI1.Header(sessionID);
		modgui1.apridiv('class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px; margin-top:110px"');
		HTP.PRN('Impossibile eliminare il profilo selezionato');
		modgui1.chiudiDiv;
		HTP.BodyClose;
		HTP.HtmlClose;
	END IF;

END;

PROCEDURE ListaUtenti(
	sessionID NUMBER default 0,
)
begin
        modGUI1.ApriPagina('Lista utenti',sessionID);
        modGUI1.Header(sessionID);
		modGUI1.ApriDiv('class="w3-center"');
        htp.prn('<h1>Lista utenti</h1>');
        modGUI1.ApriDiv('class="w3-row w3-container"');

   		for utente in (select * from utenti)  loop
                modGUI1.ApriDiv('class="w3-col l4 w3-padding-large w3-center"');
                    modGUI1.ApriDiv('class="w3-card-4" style="height:600px;"');
						modGUI1.ApriDiv('class="w3-container w3-center"');
							htp.prn('<p>'|| utente.nome ||'</p>');
							htp.br;
							htp.prn('<p>'|| utente.cognome ||'</p>');
						modGUI1.ChiudiDiv;
						modGUI1.Collegamento('Visualizza',
                            'VisualizzaUtente?sessionID='||sessionID||'&utenteID='||utente.Idutente||,
                            'w3-margin w3-green w3-button');
                        if sessionID = 1 then
						modGUI1.Collegamento('Modifica',
                            'ModificaUtente?sessionID='||sessionID||'&utenteID='||utente.Idutente||,
                            'w3-margin w3-blue w3-button');        
                        modGUI1.Collegamento('Elimina',
                            'EliminaUtente?sessionID='||sessionID||'&utenteID='||utente.Idutente||,
                            'w3-red w3-margin w3-button');
                    	end if;
                	modGUI1.ChiudiDiv;
                modGUI1.ChiudiDiv;
        END LOOP;
        modGUI1.chiudiDiv;
end;


PROCEDURE acquistabiglietto(
	dataEmissionechar IN VARCHAR2,
	dataScadenzachar IN VARCHAR2,
	idmuseoselezionato IN VARCHAR2,
	idtipologiaselezionata IN VARCHAR2,
	idutenteselezionato IN VARCHAR2
) IS
	idbigliettocreato VARCHAR(5);
	emiss DATE := TO_DATE(dataEmissionechar default null on conversion error, 'YYYY-MM-DD');
	scad DATE := TO_DATE(dataScadenzachar default null on conversion error, 'YYYY-MM-DD');
BEGIN
	idbigliettocreato := idtitoloingseq.nextval;

	INSERT INTO TITOLIINGRESSO(
		idtitoloing,
		Emissione,
		Scadenza,
		Acquirente,
		Tipologia,
		Museo
	) VALUES (
		idvisiteseq.nextval,
		emiss,
		scad,
		idutenteselezionato,
		idtipologiaselezionata,
		idmuseoselezionato
	);

	--visualizzabiglietto(idbigliettocreato);
END;

PROCEDURE formacquistabiglietto(
	dataEmissionechar IN VARCHAR2,
	dataScadenzachar IN VARCHAR2,
	idmuseoselezionato IN VARCHAR2 default null,
	idtipologiaselezionata IN VARCHAR2 default null,
	idutenteselezionato IN VARCHAR2 default null
)IS
	nomeutente utenti.nome%TYPE;
	cognomeutente utenti.cognome%TYPE;
	varidutente utenti.Idutente%TYPE;
	nometipologia tipologieingresso.nome%TYPE;
	varidmuseo musei.idmuseo%TYPE;
	nomeMuseo musei.Nome%TYPE;
	varidtipologia tipologieingresso.idtipologiaing%TYPE;
	nometiping VARCHAR(25);
BEGIN
	modgui1.apridiv('class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px"');
	modgui1.apriform('pagina_acquista_biglietto', 'formAcquistaBiglietto', 'w3-container');
	modgui1.apridiv('class="w3-section"');

	modgui1.Label('Data emissione biglietto*: ');
	modgui1.inputdate('DataEmissioneChar', 'DataEmissioneChar', 1, dataEmissionechar);
	HTP.br;

	modgui1.label('Data scadenza biglietto*: ');
	modgui1.inputdate('DataScadenzaChar', 'DataScadenzaChar', 1, dataScadenzachar);
	htp.br;

	modgui1.label('Utente*: ');
	modgui1.selectopen('idutenteselezionato', 'utente-selezionato');
	for utente in (select idutente from utenti)
	loop
		select idutente, nome, cognome
		into varidutente, nomeutente, cognomeutente
		from utenti
		where idutente=utente.idutente;
		if utente.idutente = idutenteselezionato
		then
			MODGUI1.SelectOption(varidutente, ''|| nomeutente ||' '||cognomeutente||'', 1);
		else
			MODGUI1.SelectOption(varidutente, ''|| nomeutente ||' '||cognomeutente||'', 0);
		end if;
	end loop;
	modgui1.selectclose();
	htp.br;

	modgui1.label('Museo*: ');
	modgui1.selectopen('idmuseoselezionato', 'museo-selezionato');
	for museo in (select idmuseo, nome from musei )
	loop
		if museo.idmuseo=idmuseoselezionato
		then modgui1.SelectOption(museo.idmuseo, museo.nome, 1);
		else modgui1.SelectOption(museo.idmuseo, museo.nome, 0);
		end if;
	end loop;
	modgui1.SelectClose();
	htp.br;

	modgui1.label('Tipologia di biglietto*: ');
	modgui1.selectopen('idtipologiaselezionata', 'tipologia-selezionata');
	for tipologia in (
		select TIPOLOGIEINGRESSO.IDTIPOLOGIAING, NOME
		into varidtipologia, nometiping
		from TIPOLOGIEINGRESSOMUSEI JOIN TIPOLOGIEINGRESSO
        ON TIPOLOGIEINGRESSO.IDTIPOLOGIAING=TIPOLOGIEINGRESSOMUSEI.IDTIPOLOGIAING
		where IdMuseo=idmuseoselezionato
	)
	LOOP
		if idtipologiaselezionata= tipologia.idtipologiaing
		then
			modgui1.SelectOption(tipologia.idtipologiaing, tipologia.nome, 1);
		else
			modgui1.SelectOption(tipologia.idtipologiaing, tipologia.nome, 0);
		end if;
	end loop;
	modgui1.selectclose();

	htp.prn('<button class="w3-button w3-block w3-black w3-section w3-padding" type="submit" name="convalida" value="1">Acquista</button>');
	modgui1.ChiudiDiv();
	modgui1.chiudiform();
	modgui1.chiudidiv();
	htp.prn('<script>
				document.getElementById("museo-selezionato").onchange= function inviaFormAcquistaBiglietto(){
					document.formAcquistaBiglietto.submit();
					}
	</script>');
END;

PROCEDURE pagina_acquista_biglietto(
	dataEmissionechar VARCHAR2 DEFAULT NULL,
	dataScadenzachar VARCHAR2 DEFAULT NULL,
	idmuseoselezionato VARCHAR2 DEFAULT NULL,
	idtipologiaselezionata VARCHAR2 DEFAULT NULL,
	idutenteselezionato VARCHAR2 DEFAULT NULL,
	convalida IN NUMBER DEFAULT NULL
) IS
BEGIN
	modgui1.apripagina();
	modgui1.header();
	modgui1.apridiv('style="margin-top: 110px"');
	htp.prn('<h1> Acquisto biglietto </h1>');

	if convalida IS NULL
	then
		formacquistabiglietto(dataEmissionechar, dataScadenzachar,
					idmuseoselezionato, idtipologiaselezionata, idutenteselezionato);
	else
		htp.prn('<h1> Biglietto acquistato </h1>');
		acquistabiglietto(dataEmissionechar, dataScadenzachar,
							idmuseoselezionato, idtipologiaselezionata, idutenteselezionato);
	end if;

	modgui1.chiudidiv();
	HTP.BodyClose;
	HTP.HtmlClose;
END;

-------------------------------------------------------------TODO DA TESTARE
/*
PROCEDURE inserisciNewsLetter (
    sessionID NUMBER DEFAULT 0
) IS
BEGIN
	MODGUI1.ApriPagina('Inserimento newsletter', 0);

	HTP.BodyOpen;
	MODGUI1.Header(); --da capire come combinarlo con il resto
	HTP.header(1,'Inserisci una nuova newsletter', 'center');
	MODGUI1.ApriDiv('style="margin-left: 2%; margin-right: 2%;"');

	MODGUI1.ApriForm('inserisci_newsletter');
	HTP.FORMHIDDEN('sessionID',0);

	MODGUI1.Label('Nome*');
	MODGUI1.InputText('nome', 'Nome newsletter', 1);
	HTP.BR;
	MODGUI1.ChiudiDiv;

	MODGUI1.InputSubmit('Inserisci');
	MODGUI1.ChiudiForm;

	MODGUI1.ChiudiDiv;

END;

PROCEDURE inserisci_newsletter (
    sessionID NUMBER DEFAULT 0
	nome varchar2(25) not null
) IS
BEGIN
	MODGUI1.ApriPagina('Inserimento utenti', 0);

	insert into NEWSLETTER
    values (IdNewsSeq.NEXTVAL, nome);

	HTP.BodyOpen;
	MODGUI1.Header(); --da capire come combinarlo con il resto
	HTP.header(1,'Newsletter inserita', 'center');
	MODGUI1.ApriDiv('style="margin-left: 2%; margin-right: 2%;"');

	MODGUI1.ApriForm('inseriscinewsletter');
	HTP.FORMHIDDEN('sessionID',0);

	MODGUI1.Label('Nome');
	MODGUI1.label(nome);
	MODGUI1.ChiudiDiv;

	MODGUI1.InputSubmit('Continuare?');
	MODGUI1.ChiudiForm;

	MODGUI1.ChiudiDiv;

END;


----- Numero visitatori iscritti alla Newsletter scelta❌



-------------------------------------------------------------FINE TODO */


PROCEDURE numeroVisitatoriNewsletter (
    sessionID NUMBER DEFAULT 0,
	newsletterID NUMBER DEFAULT -1
) IS

	temp NUMBER(10) := 10;
	nomeNew VARCHAR2(100) := '';

begin
	SELECT NOME into nomeNew FROM NEWSLETTER WHERE NEWSLETTER.IDNEWS = newsletterID;
	SELECT count(*) into temp from UTENTI where IdUtente IN (select VISITATORE from VISITE) AND IDUTENTE IN (SELECT IDUTENTE FROM NEWSLETTERUTENTI WHERE IDNEWS = newsletterID);
	modgui1.apripagina('statistica');
	modgui1.header();
	modgui1.apridiv('style="margin-top: 110px"');
	htp.prn('<h1> Numero visitatori per newsletter </h1>');
	htp.br();
	modgui1.Label(CONCAT('newsletter name:', nomeNew));
	modgui1.Label(TO_CHAR(temp));
	modgui1.chiudidiv;
	htp.BodyClose;
	htp.HtmlClose;

	modgui1.chiudiDiv();
	htp.bodyclose;
	htp.htmlclose;

end;

END GRUPPO1;

/*
 *  OPERAZIONI SUI TITOLI DI INGRESSO
 * - Modifica ❌
 * - Cancellazione❌
 * - Visualizzazione ❌
 * - Acquisto abbonamento museale ❌
 * - Acquisto biglietto ❌
 * OPERAZIONI STATISTICHE E MONITORAGGIO
 * - Numero Titoli d’Ingresso emessi in un arco temporale scelto ❌
 * - Numero Titoli d’Ingresso emessi da un Museo in un arco temporale scelto ❌
 * - Abbonamenti in scadenza nel mese corrente ❌
*/
/*

/*
 *  OPERAZIONI SULLE NEWSLETTER
 * - Inserimento ❌ (da testare)
 * - Cancellazione❌
 * - Visualizzazione❌
 * - Iscrizione(rimozione)❌
 * - Cancellazione Iscrizione❌
 * OPERAZIONI STATISTICHE E MONITORAGGIO
 * - Numero visitatori iscritti alla Newsletter scelta FATTO!
 * - Età media dei visitatori iscritti alla Newsletter scelta ❌
 * - Titoli d’ingresso appartenenti ai visitatori iscritti alla Newsletter scelta❌
 * - Lista Opere ordinate per numero di Autori in ordine decrescente ❌
*/