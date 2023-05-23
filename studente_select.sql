select to_char(data,'yy-mm-dd')||'-'||materia_des materia,voto,
round(avg(voto) over(order by data),2) media_voti_progressiva
 from unv_esame_vw a
 where stato_esame='PASSATO'
   and studente_id = :P24_ID
 order by materia_des;
 
 
