-- CREAZIONE TABELLE
@gestioneDB/delete_data.plsql
@gestioneDB/create_table.plsql
@modGui/Login/trigger_utenti.plsql
@modGui/Login/hasRole.plsql

-- INSERIMENTO DATI
@gestioneDB/populate_table.plsql

-- TRIGGERS
@triggers/triggercreatesaleopere.plsql;
@triggers/triggerdeleteopera.plsql;
@triggers/triggerDeleteSalaAfter.plsql;
@triggers/triggerdeletesalabefore.plsql;
@triggers/triggerdeletestanza.plsql;
@triggers/triggerupdatevisita.plsql;

----------------
-- OPERAZIONI --
----------------

-- MODGUI
@modGui/PagineTest/WEBPAGESpks.plsql
@modGui/PagineTest/WEBPAGESpkb.plsql
@modGui/COSTANTI.plsql
@modGui/MODGUI1PKS.plsql
@modGui/MODGUI1PKB.plsql

-- GRUPPO 3
@operazioneGruppo3/view_visite.plsql
@operazioneGruppo3/visite.plsql
@operazioneGruppo3/visiteBody.plsql
@operazioneGruppo3/PACKAGESTANZE/PackageStanzePKS.plsql
@operazioneGruppo3/PACKAGESTANZE/PackageStanzePKB.plsql
@operazioneGruppo3/PackageVarchi/PackageVarchi.pks
@operazioneGruppo3/PackageVarchi/PackageVarchi.pkb

-- GRUPPO 2
@operazioni_gruppo2/sql/vistaOpereEsposte.plsql
@operazioni_gruppo2/sql/gruppo2PKS.pkb
@operazioni_gruppo2/sql/gruppo2PKB.pkb

-- GRUPPO 1
@operazioniGruppo1/sql/view_titoli.plsql
@operazioniGruppo1/sql/Utenti.pks
@operazioniGruppo1/sql/Utenti.pkb
@operazioniGruppo1/sql/Newsletters.plsql
@operazioniGruppo1/sql/NewslettersB.plsql
@operazioniGruppo1/sql/TitoliIngresso.plsql
@operazioniGruppo1/sql/TitoliIngressoBody.plsql
@operazioniGruppo1/sql/OperazioniTipologieIng.pks
@operazioniGruppo1/sql/OperazioniTipologieIng.pkb

-- GRUPPO 4
@operazioniGruppo4/sql/visitaetamedia.sql
@operazioniGruppo4/sql/operazioni.pks
@operazioniGruppo4/sql/operazioni.pkb
-- @operazioniGruppo4/sql/pagamentiCampiEstivi.pks
-- @operazioniGruppo4/sql/pagamentiCampiEstivi.pkb
-- @operazioniGruppo4/sql/tariffeCampiEstivi.pks
-- @operazioniGruppo4/sql/tariffeCampiEstivi.pkb

grant execute on modgui1 to anonymous;
grant execute on modgui1 to public;
grant execute on webpages to anonymous;
grant execute on webpages to public;
grant execute on packageacquistatitoli to anonymous;
grant execute on packageacquistatitoli to public;
grant execute on newsletters to anonymous;
grant execute on newsletters to public;
grant execute on gruppo1 to anonymous;
grant execute on gruppo1 to public;
grant execute on packageutenti to anonymous;
grant execute on packageutenti to public;
grant execute on gruppo2 to anonymous;
grant execute on gruppo2 to public;
grant execute on packagevisite to anonymous;
grant execute on packagevisite to public;
grant execute on packagestanze to anonymous;
grant execute on packagestanze to public;
grant execute on packagevarchi to anonymous;
grant execute on packagevarchi to public;
grant execute on operazionigruppo4 to anonymous;
grant execute on operazionigruppo4 to public;
-- grant execute on tariffeCampiEstiviOperazioni to anonymous;
-- grant execute on tariffeCampiEstiviOperazioni to public;
/*
grant execute on PagamentiCampiEstivi to anonymous;
grant execute on PagamentiCampiEstivi to public;
*/

