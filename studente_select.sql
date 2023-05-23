Elenco Esami Fatti - combinato
select to_char(data,'yy-mm-dd')||'-'||materia_des materia,voto,
round(avg(voto) over(order by data),2) media_voti_progressiva
 from unv_esame_vw a
 where stato_esame='PASSATO'
   and studente_id = :P24_ID
 order by materia_des;
 
-- Numero Esami - torta 
-- Esami Fatti
select 'Esami Fatti' etichetta, count(distinct materia) valore
 from unv_esame_vw a
 where stato_esame='PASSATO'
   and studente_id = :P24_ID

-- Esami da Fare
select 'Esami da Fare'etichetta,count(distinct m.id)valore 
  from unv_materia m
  join unv_studente s on m.laurea_id = s.laurea_id
 where m.id not in (select e.materia_id from unv_esame_vw e where s.id = e.studente_id and e.stato_esame='PASSATO')  
   and s.id=:P24_ID
   
-- Badge List   
select count(distinct materia) numero_esami,
       nvl(sum(crediti),0)CFU,
        nvl(round(avg(voto),2),0) media_voti,
        nvl(min(voto),0)voto_minimo,
        nvl(max(voto),0)voto_massimo
 from unv_esame_vw a
 where stato_esame='PASSATO'
   and studente_id = :P24_ID

--Lista Esami - timeline
 select id,
       'Cod. Esame: '||esame user_name,
       appello,
       esame,
       data event_date,
       'docente: '||docente event_desc,
       materia_des event_title,
       docente,
       voto user_avatar,
       round(avg(voto) over(order by data),2) media_voti_progressiva,
       decode(stato_esame,'PASSATO','is-new','NON PASSATO','is-removed','is-updated') event_status,
       decode(stato_esame,'PASSATO','fa fa-smile-o','NON PASSATO','fa fa-frown-o','fa fa-question-circle-o') event_icon,
       decode(stato_esame,'PASSATO','u-success','NON PASSATO','u-danger','u-info') user_color,
       stato_esame event_type
  from unv_esame_vw
 where studente_id = :P24_ID
 order by data desc, materia_des
 
-- Appelli - classic
select a.ID,
       a.APPELLO,
       a.DATA,
       a.LAUREA_ID,
       a.LAUREA,
       a.MATERIA_ID,
       a.MATERIA,
       a.MATERIA_DES,
       a.ANNO
  from UNV_APPELLO_VW a
  join unv_studente s on a.laurea_id = s.laurea_id
  and a.MATERIA_ID not in (select e.materia_id from unv_esame_vw e where s.id = e.studente_id and e.stato_esame='PASSATO')  
  where s.id = :P24_ID
