CREATE OR REPLACE PACKAGE BODY PackageStanze as
    
    ---SALE---
    
    PROCEDURE visualizzaSale (
        idSessione IN int default 0,
        Sort IN int default 0
    ) is 
    museosel musei.nome%TYPE;
    BEGIN
        modGUI1.ApriPagina('Sale', idSessione);
        modGUI1.Header(idSessione);
        htp.br;htp.br;htp.br;htp.br;
        modGUI1.ApriDiv('class="w3-center"');
            htp.prn('<h1>Sale</h1>'); --TITOLO
            if (idSessione=1)
            then
                modGUI1.Collegamento('Aggiungi','packagestanze.formSala?idSessione='||idSessione,'w3-btn w3-round-xxlarge w3-black'); /*bottone che rimanda alla procedura inserimento solo se la sessione è 1*/
            END if;
        modGUI1.ChiudiDiv;
        --FORM ORINDAMENTO-------------------
        modGUI1.APRITABELLA('w3-margin-right w3-right');
            modGUI1.APRIRIGATABELLA;
                modgui1.APRIELEMENTOTABELLA;
                    modGUI1.LABEL('Ordina per:');
                modgui1.chiudiElementoTabella;
                modgui1.APRIELEMENTOTABELLA;
                    modGUI1.ApriForm('PackageStanze.visualizzaSale',NULL,'" style="display:inline;');
                        HTP.FORMHIDDEN('idSessione',idSessione);
                        modGUI1.SELECTOPEN('Sort');
                            modGUI1.SELECTOPTION(1,'Nome');
                            modGUI1.SELECTOPTION(2,'Tipo');
                            modGUI1.SELECTOPTION(3,'Dimensione');
                            modGUI1.SELECTOPTION(4,'Numero Opere');
                        modGUI1.SELECTCLOSE;
                modgui1.chiudiElementoTabella;
                modgui1.APRIELEMENTOTABELLA;
                        htp.prn('<input type="submit" class="w3-button w3-round w3-black" value="VAI" style="display:inline;">');
                    modGUI1.ChiudiForm;
                modgui1.chiudiElementoTabella;
            modgui1.chiudiRigaTabella;
        modGUI1.chiudiTabella;
        ----------------------------------
        htp.br;
        modGUI1.ApriDiv('class="w3-row w3-container"');
        --INIZIO LOOP DELLA VISUALIZZAZIONE
                FOR sala IN (SELECT * FROM sale NATURAL JOIN stanze /*WHERE STANZE.eliminato=0*/ORDER BY 
                (CASE WHEN Sort<>1 AND Sort<>2 AND Sort<>3 AND Sort<>4 then idstanza end),
                (CASE WHEN Sort=1 then nome end),
                (CASE WHEN Sort=2 then tiposala end),
                (CASE WHEN Sort=3 then dimensione end),
                (CASE WHEN Sort=4 then numopere end)
                ) 
                LOOP
            htp.prn('<a style="text-decoration:none;" href='||COSTANTI.server || costanti.radice ||'packagestanze.visualizzaSala?idSessione='||idSessione||'&varIdSala='||sala.Idstanza||'>');
                modGUI1.ApriDiv('class="w3-col l4 w3-padding-large w3-center w3-hover-light-grey"');
                    modGUI1.ApriDiv('class="w3-card-4"');
                    htp.prn('<img src="https://www.23bassi.com/wp-content/uploads/2019/03/vuota-web.jpg" alt="Alps" style="width:100%">');
                            modGUI1.ApriDiv('class="w3-container w3-center"');
                            --INIZIO DESCRIZIONI
                                SELECT nome INTO museosel FROM MUSEI WHERE (musei.idmuseo=sala.museo);
                                htp.prn('<p><b>Museo: </b>'|| museosel ||'</p>');
                                htp.prn('<h2><b>'|| sala.nome||'</b></h2>');
                                htp.prn('<h4>Tipo '|| sala.tiposala||'</h4>');
                                htp.prn('<p>Dim: '||sala.dimensione || 'mq / ');
                                htp.prn('Max opere: '|| sala.numopere||'</p>');

                            --FINE DESCRIZIONI
                            modGUI1.ChiudiDiv;
                            
                            if(idSessione=1) then --Bottoni visualizzati in base alla sessione 
                               modGUI1.Collegamento('Modifica','packagestanze.formSala?idSessione='||idSessione||'&modifica=1&varIdStanza='||sala.idstanza||'&varSalaMuseo='||sala.museo||'&varSalaNome='||sala.nome||'&varSalaDimensione='||sala.dimensione||'&varSalaTipo='||sala.tiposala||'&varSalaOpere='||sala.numopere,'w3-button w3-green');
                               modGUI1.Collegamento('Rimuovi','packagestanze.rimuoviSala?idSessione='||idSessione||'&varIdStanza='||sala.idstanza,'w3-button w3-red w3-margin');
                            END if;

                    modGUI1.ChiudiDiv;
                modGUI1.ChiudiDiv;
            htp.prn('</a>');
            END LOOP;
        --FINE LOOP
        modGUI1.chiudiDiv;  
    END;

    PROCEDURE formSala (
        idSessione IN int default 0,
        modifica IN NUMBER default 0,
        varIdStanza IN NUMBER default NULL,
        varSalaMuseo IN NUMBER default NULL,
        varSalaNome VARCHAR2 default NULL,
        varSalaDimensione NUMBER default NULL,
        varSalaTipo NUMBER default NULL,
        varSalaOpere NUMBER default NULL
        ) is
        NomeMuseo MUSEI.Nome%TYPE;
        varIdMuseo MUSEI.IdMuseo%TYPE;
    BEGIN
        modGUI1.ApriPagina('Form Sala',idSessione);
        modGUI1.Header(idSessione);
        
        modGUI1.ApriDiv('style="margin-top: 110px"');
            htp.prn('<h1 class="w3-center">Inserimento sala</h1>');
                modGUI1.ApriDivCard;
                    if (modifica=0)
                    then
                        modGUI1.ApriForm('packagestanze.inseriscisala',NULL,'w3-container');
                    else
                        modGUI1.ApriForm('packagestanze.modificasala',NULL,'w3-container');
                    end if;

                            ----CAMPI STANZA----
                            modGUI1.Label('Museo:');
                            modGUI1.SelectOpen('selectMusei');
                                for museo in (select IdMuseo from MUSEI)
                                loop
                                    select IdMuseo, Nome into varIdMuseo, NomeMuseo
                                    from MUSEI
                                    where IdMuseo = museo.IdMuseo;
                                    if (museo.idmuseo=VarSalaMuseo)
                                    then
                                        modGUI1.SelectOption(varIdMuseo,NomeMuseo,1);
                                    else
                                        modGUI1.SelectOption(varIdMuseo,NomeMuseo);
                                    END if;
                                END loop;
                            modGUI1.SelectClose;
                            htp.br;
                            modGUI1.Label('Nome sala:');
                            modGUI1.InputText('nomeSala',NULL,NULL,varSalaNome);
                            htp.br;
                            modGUI1.Label('Dimensione sala:');
                            modGUI1.InputNumber('idDimSala','dimSala',NULL,varSalaDimensione);
                            htp.br;
                            ----CAMPI SALA----
                            modGUI1.Label('Tipo sala:');
                            if(varSalaTipo=0)
                                then
                                    modGUI1.InputRadioButton('Tipo 0 ','tipoSalaform','0',1);
                                    modGUI1.InputRadioButton('Tipo 1 ','tipoSalaform','1');
                                else
                                    modGUI1.InputRadioButton('Tipo 0 ','tipoSalaform','0');
                                    modGUI1.InputRadioButton('Tipo 1 ','tipoSalaform','1',1);
                            END if;
                            htp.br;
                            modGUI1.Label('Numero Opere: ');
                            modGUI1.InputNumber('idnOpere','nOpereform',NULL,varSalaOpere);
                            htp.br;
                            modGUI1.InputReset;
                            HTP.FORMHIDDEN('idSessione',idSessione);
                            if (modifica=0)
                            then
                                modGUI1.InputSubmit('Aggiungi');
                            else
                                htp.FORMHIDDEN('varIdStanza',varIdStanza);
                                modGUI1.InputSubmit('Modifica');
                            END if;

                    modGUI1.ChiudiForm;
                modGUI1.ChiudiDiv;
        modGUI1.ChiudiDiv();
    END;

    PROCEDURE visualizzaSala(
        idSessione in INT default 0,
        varIdSala in NUMBER
        )is
        varNome VARCHAR2(20);
        varDimensione NUMBER;
        varMuseo MUSEI.IDMUSEO%TYPE;
        varTiposala NUMBER;
        varNumopere NUMBER;
        varNomeMuseo MUSEI.NOME%TYPE;
    BEGIN
        SELECT nome,dimensione,museo,tiposala,numopere INTO varNome,varDimensione,varMuseo,varTiposala,varNumopere FROM Stanze NATURAL JOIN Sale WHERE idstanza=varIdSala;
        modGUI1.APRIPAGINA('Sala '||varIdSala,idSessione);
        modGUI1.HEADER(idSessione);
        htp.br;htp.br;htp.br;htp.br;htp.br;
        SELECT nome INTO varNomeMuseo FROM MUSEI WHERE (MUSEI.IDMUSEO=varMuseo);
        modGUI1.ApriDiv('class="w3-light-grey w3-container" style="margin:auto;width:60%;"');
            htp.prn('<img src="https://www.23bassi.com/wp-content/uploads/2019/03/vuota-web.jpg" alt="Alps" class="w3-third w3-margin">');
            MODGUI1.ApriDiv('class="twothird w3-margin w3-center"');
                htp.prn('<p><b>Museo: </b>'|| varNomeMuseo ||'</p>');
                                htp.prn('<h2><b>'|| varNome ||'</b></h2>');
                                htp.prn('<h4>Tipo '|| VarTiposala ||'</h4>');
                                htp.prn('<p>Dim: '|| varDimensione || 'mq</p>');
                                htp.prn('<p>Max opere: '|| varNumopere ||'</p>');  
            MODGUI1.ChiudiDiv;
            MODGUI1.ApriDiv('class="w3-container"');
            htp.prn('<h3>Opere:</h3>');
                MODGUI1.APRITABELLA('w3-table-all');
                    MODGUI1.APRIRIGATABELLA;
                        MODGUI1.APRIELEMENTOTABELLA;
                            htp.prn('<p><b>Titolo</b></p>');
                        MODGUI1.CHIUDIELEMENTOTABELLA;
                        MODGUI1.APRIELEMENTOTABELLA;
                            htp.prn('<p><b>Anno</b></p>');
                        MODGUI1.CHIUDIELEMENTOTABELLA;
                    MODGUI1.CHIUDIRIGATABELLA;
                    FOR varOpere IN (SELECT * FROM OPERE INNER JOIN SALEOPERE ON SALEOPERE.opera=OPERE.idopera WHERE SALEOPERE.SALA=varIdSala ORDER BY OPERE.titolo) LOOP
                    MODGUI1.APRIRIGATABELLA('w3-hover-grey');
                        MODGUI1.APRIELEMENTOTABELLA;
                            htp.prn('<p>'||varOpere.Titolo||'</p>');
                        MODGUI1.CHIUDIELEMENTOTABELLA;
                        MODGUI1.APRIELEMENTOTABELLA;
                            htp.prn('<p>'||varOpere.Anno||'</p>');
                        MODGUI1.CHIUDIELEMENTOTABELLA;
                    MODGUI1.CHIUDIRIGATABELLA;
                    END LOOP;
                MODGUI1.CHIUDITABELLA;
            MODGUI1.ChiudiDiv;
        modGUI1.ChiudiDiv;
        

    END;
    PROCEDURE inserisciSala (
        idSessione IN int default 0,
        selectMusei IN musei.idmuseo%TYPE,
        nomeSala       IN  VARCHAR2,
        dimSala            IN  NUMBER,
        tipoSalaform         IN  NUMBER,
        nOpereform           IN NUMBER
    ) IS
        idstanzacreata sale.idstanza%TYPE;
    
    BEGIN    	
        idstanzacreata := idstanzaseq.nextval;
        INSERT INTO STANZE (
            idstanza,
            nome,
            dimensione,
            museo,
            eliminato
        ) VALUES (
            idstanzacreata,
            nomeSala,
            dimSala,
            selectMusei,
            0
        );
        INSERT INTO SALE (
            idstanza,
            tiposala,
            numopere,
            eliminato    
        ) VALUES (
            idstanzacreata,
            tipoSalaForm,
            nOpereform,
            0
        );
        MODGUI1.REDIRECTESITO(idSessione, 'Inserimento effettuato',
                              'L''inserimento è stato effettuato correttamente',
                              'Torna a visualizzare le sale',
                              'PackageStanze.visualizzaSale',
                              NULL);
    END;

    PROCEDURE modificaSala (
        idSessione IN int default 0,
        varIdStanza IN NUMBER,
        selectMusei IN musei.idmuseo%TYPE,
        nomeSala       IN  VARCHAR2,
        dimSala            IN  NUMBER,
        tipoSalaform         IN  NUMBER,
        nOpereform           IN NUMBER
    ) IS
    BEGIN
        
        UPDATE STANZE
        SET
        nome=nomeSala,
        dimensione=dimSala,
        museo=selectMusei
        WHERE idstanza=varIdStanza;

        UPDATE SALE
        SET
        tiposala=tipoSalaform,
        numopere=nOpereform
        WHERE
        idstanza=varIdStanza;
        MODGUI1.REDIRECTESITO(idSessione, 'Modifica effettuata',
                              'La modifica è stata effettuata correttamente',
                              'Torna a visualizzare le sale',
                              'PackageStanze.visualizzaSale',
                              NULL);
    END;

    PROCEDURE rimuoviSala (
        idSessione IN int default 0,
        varIdStanza IN NUMBER
    ) IS
    BEGIN
        
        UPDATE STANZE
        SET
        eliminato=1
        WHERE idstanza=varIdStanza;

        MODGUI1.REDIRECTESITO(idSessione, 'Eliminazione effettuata',
                              'L''eliminazione è stata effettuata correttamente',
                              'Torna a visualizzare le sale',
                              'PackageStanze.visualizzaSale',
                              NULL);
    END;

    ---AMBIENTI DI SERVIZIO---
    
    PROCEDURE visualizzaAmbientiServizio (idSessione IN int default 0) is 
    museosel musei.nome%TYPE;
    BEGIN
        modGUI1.ApriPagina('Ambienti di servizio', idSessione);
        modGUI1.Header(idSessione);
        htp.br;htp.br;htp.br;htp.br;
        modGUI1.ApriDiv('class="w3-center"');
            htp.prn('<h1>Ambienti di servizio</h1>'); --TITOLO
            if (idSessione=1)
            then
                modGUI1.Collegamento('Aggiungi','packagestanze.formAmbienteServizio','w3-btn w3-round-xxlarge w3-black'); /*bottone che rimanda alla procedura inserimento solo se la sessione è 1*/
            END if;
        modGUI1.ChiudiDiv;
        htp.br;
        modGUI1.ApriDiv('class="w3-row w3-container"');
        --INIZIO LOOP DELLA VISUALIZZAZIONE
            FOR AmbS IN (SELECT * FROM ambientidiservizio NATURAL JOIN stanze ORDER BY idstanza) LOOP
                modGUI1.ApriDiv('class="w3-col l4 w3-padding-large w3-center"');
                    modGUI1.ApriDiv('class="w3-card-4"');
                    htp.prn('<img src="https://cdn.pixabay.com/photo/2016/10/22/15/32/water-1761027__480.jpg" alt="Alps" style="width:100%">');
                            modGUI1.ApriDiv('class="w3-container w3-center"');
                            --INIZIO DESCRIZIONI
                                SELECT nome INTO museosel FROM MUSEI WHERE (musei.idmuseo=AmbS.museo);
                                htp.prn('<p><b>Museo: </b>'|| museosel ||'</p>');
                                htp.prn('<h2><b>'|| AmbS.nome||'</b></h2>');
                                htp.prn('<h4>'|| AmbS.tipoambiente||'</h4>');
                                htp.prn('<p>Dim: '||AmbS.dimensione || 'mq</p>');

                            --FINE DESCRIZIONI
                            modGUI1.ChiudiDiv;
                            
                            if(idSessione=1) then --Bottoni visualizzati in base alla sessione 
                                modGUI1.Collegamento('Modifica','packagestanze.formAmbienteServizio?modifica=1&varASMuseo='||AmbS.museo||'&varASNome='||AmbS.nome||'&varASDimensione='||AmbS.dimensione||'&varASTipo='||AmbS.tipoambiente,'w3-button w3-green');
                                modGUI1.Collegamento('Rimuovi','packagestanze.rimuoviAmbienteServizio?idAS='||AmbS.idstanza, 'w3-button w3-red w3-margin');
                            END if;

                    modGUI1.ChiudiDiv;
                modGUI1.ChiudiDiv;
            END LOOP;
        --FINE LOOP
        modGUI1.chiudiDiv;  
    END;
    
    

    PROCEDURE formAmbienteServizio (
        modifica IN NUMBER default 0,
        varASMuseo IN NUMBER default NULL,
        varASNome VARCHAR2 default NULL,
        varASDimensione NUMBER default NULL,
        varASTipo VARCHAR2 default NULL
    ) is
        NomeMuseo MUSEI.Nome%TYPE;
        varIdMuseo MUSEI.IdMuseo%TYPE;
    BEGIN
        modGUI1.ApriPagina();
        modGUI1.Header();
        modGUI1.ApriDiv('style="margin-top: 110px"');
            htp.prn('<h1 class="w3-center">Inserimento ambiente di servizio</h1>');
                modGUI1.ApriDivCard;
                    if (modifica=0)
                    then
                        modGUI1.ApriForm('packagestanze.inserisciambienteservizio',NULL,'w3-container');
                    else 
                        modGUI1.ApriForm('packagestanze.modificaambienteservizio',NULL,'w3-container');
                    end if;
                            ----CAMPI STANZA----
                            modGUI1.Label('Museo:');
                            modGUI1.SelectOpen('selectMusei');
                                for museo in (select IdMuseo from MUSEI)
                                loop
                                    select IdMuseo, Nome into varIdMuseo, NomeMuseo
                                    from MUSEI
                                    where IdMuseo = museo.IdMuseo;                                    
                                    if (museo.idmuseo=VarASMuseo)
                                    then
                                        modGUI1.SelectOption(varIdMuseo,NomeMuseo,1);
                                    else
                                        modGUI1.SelectOption(varIdMuseo,NomeMuseo);
                                    END if;
                                END loop;
                            modGUI1.SelectClose;
                            htp.br;
                            modGUI1.Label('Nome ambiente di servizio:');
                            modGUI1.InputText('nomeSala',NULL,NULL,varASNome);
                            htp.br;
                            modGUI1.Label('Dimensione sala:');
                            modGUI1.InputNumber('idDimSala','dimSala',NULL,varASDimensione);
                            htp.br;
                            ----CAMPI AMBIENTE SERVIZIO----
                            modGUI1.Label('Tipo Ambiente:');
                            modGUI1.InputText('tipoAmbienteform',NULL,NULL,varASTipo);
                            htp.br;
                            modGUI1.InputReset;
                            if (modifica=0)
                            then
                                modGUI1.InputSubmit('Aggiungi');
                            else
                                modGUI1.InputSubmit('Modifica');
                            END if;

                    modGUI1.ChiudiForm;
                modGUI1.ChiudiDiv;
        modGUI1.ChiudiDiv();
    END;

    PROCEDURE inserisciAmbienteServizio (
        selectMusei IN musei.idmuseo%TYPE,
        nomeSala       IN  VARCHAR2,
        dimSala            IN  NUMBER,
        tipoAmbienteForm   IN VARCHAR2
    ) IS
        idstanzacreata sale.idstanza%TYPE;
    
    BEGIN
    	
        idstanzacreata := idstanzaseq.nextval;


        INSERT INTO STANZE (
            idstanza,
            nome,
            dimensione,
            museo,
            eliminato
        ) VALUES (
            idstanzacreata,
            nomeSala,
            dimSala,
            selectMusei,
            0
        );
        INSERT INTO AMBIENTIDISERVIZIO (
            idstanza,
            tipoambiente,
            eliminato    
        ) VALUES (
            idstanzacreata,
            tipoAmbienteForm,
            0
        );
        htp.prn('DONE');
    END;

END PackageStanze;
