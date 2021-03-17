-- Q1-Donner les différents jobs des employés.

-- Q2-Donner le numéro des projets auxquels participe l'employé numéro 7900 avec le nombre d’heures.

-- Q3-Donner le nom et la catégorie des projets avec des employés.

-- Q4-Donner le numéro des projets auxquels participent ADAMS ou MARTIN.

-- Q5-Donner le nom des départements avec des clerk qui travaillent sur le projet 2.

-- Q6-Donner le nom des employés dirigés directement par KING.

-- Q7-Donner le numéro des employés embauchés avant leur manager.

-- Q8-Donner la requête SQL correspondant à la requête algébrique.

-- Q9-Donner le numéro et le nom de tous les départements avec leurs jobs.

-- Q10-Donner le numéro des départements qui n'ont pas d'employé.
    SELECT DEPTNO FROM DEPT WHERE DEPTNO NOT IN (SELECT DEPTNO from EMP)   
-- Q11-Donner le nom des projets auxquels participent l'employé numéro 7900 et l'employé numéro 7521.
    SELECT p.pno, PR.PNAME from PROJECT PR JOIN PARTICIPATION P ON PR.PNO=P.PNO WHERE P.EMPNO='7900' and P.EMPNO='7521' ;
 -- Pas possible car avec une jointure le and ne fonctionne pas car la colonne ne peut prendre que une val, voir correction pour bonne version

-- Q12-Donner le numéro des projets de la catégorie A ou mobilisant l'employé numéro 7876.
    SELECT distinct PR.PNO FROM PROJECT PR JOIN PARTICIPATION P ON PR.PNO=P.PNO WHERE PR.CAT='A' or P.EMPNO='7876';
    
    SELECT PNO FROM PROJECT WHERE CAT='A';
-- Q13-Donner le nombre de jobs différents.
    SELECT COUNT(DISTINCT JOB) from EMP;

-- Q14-Donner le salaire moyen et la commission moyenne pour chaque job.
    SELECT JOB, AVG(SAL) as Average_salary, AVG(COMM) as Average_com from EMP group by job; 

-- Q15-Donner le numéro des projets avec au moins 4 participants.
    
    
    SELECT PNO from participation group by PNO having count(EMPNO)>=4;


-- Q16-Donner le nom des employés dont le nom commence par A et participant à au moins 2 projets.
    SELECT ENAME FROM EMP WHERE ENAME LIKE 'A%' and EMPNO IN (SELECT EMPNO FROM PARTICIPATION GROUP BY EMPNO HAVING COUNT(PNO)>=2);
    
-- Q17-Donner le nombre de projets par employés (afficher leur numéro et leur nom).
    SELECT E.EMPNO, ENAME, COUNT(P.PNO) FROM EMP E JOIN PARTICIPATION P on E.EMPNO=P.EMPNO group by E.EMPNO, ENAME;
    
-- Q18-Donner le nombre d'employés moyen par job.

   SELECT AVG(NB) from (SELECT COUNT(EMPNO) as NB FROM EMP GROUP BY JOB); 
   
   SELECT AVG(COUNT(*)) Fr  om EMP GROUP BY JOB;
   
-- Q19-Donner le job ayant le salaire moyen le plus faible.
   SELECT JOB from( SELECT JOB, AVG(SAL) as AVG FROM EMP GROUP BY JOB ORDER BY AVG ASC) where ROWNUM = 1;

-- Q20-Donner le numéro des employés qui participent à tous les projets.
   Select EMPNO from participation group by empno having count(pno)=(SELECT COUNT(PNO) from project) ;

-- Q21-Donner le numéro des employés qui participent à tous les projets de la catégorie C.
    
   
     SELECT EMPNO FROM (SELECT EMPNO, count(PA.PNO) AS TOTAL FROM PARTICIPATION PA JOIN PROJECT P ON PA.PNO=P.PNO where P.CAT='C' group by EMPNO) where TOTAL = (SELECT COUNT(PNO) from project where cat='C');
     
-- Q22-Donner le nom des projets de la catégorie B qui mobilisent tous les employés.
    
    Select PNO FROM ( SELECT PA.PNO, COUNT(EMPNO) AS TOTAL from participation PA join project P on P.PNO=PA.PNO where cat='B' group by PA.PNO) where TOTAL= (SELECT COUNT(EMPNO) from EMP);
    
    Select PNAME FROM PARTICIPATION P JOIN PARTICIPATION PR ON P.PNO=PR.PNO WHERE CAT='B' GROUP BY P.PNO, PNAME HAVING COUNT(EMPNO) FROM EMP);
-- Q23-Donner le nom des employés qui dépendent (directement ou non) de JONES.
    SELECT ENAME FROM EMP CONNECT BY PRIOR EMPNO=MGR START WITH ENAME='JONES';
-- Q24-Donner le nom des employés dirigés directement par KING.
-- Requête Q6 mais en utilisant CONNECT BY et LEVEL.

    SELECT ENAME FROM EMP WHERE LEVEL='2' CONNECT BY PRIOR EMPNO=MGR START WITH ENAME='KING';

-- Q25-Donner le nom des supérieurs de SMITH.
    SELECT ENAME FROM EMP CONNECT BY PRIOR MGR=EMPNO START WITH ENAME='SMITH';
-- Q26-Donner le numéro, le nom et la date d'embauche (formatée en DD/MM)
-- des employés embauchés entre le 01/04/1981 et le 30/09/1981
-- par ordre décroissant de la date puis nom croissant.
    SELECT EMPNO, ENAME, TO_CHAR(HIREDATE, 'DD/MM') FROM EMP WHERE HIREDATE BETWEEN '1981-04-01' AND '1981-09-30' ORDER BY HIREDATE ASC;
    SELECT EMPNO, ENAME, TO_CHAR(HIREDATE, 'DD/MM') FROM EMP WHERE HIREDATE BETWEEN '1981-04-01' AND '1981-09-30' ORDER BY ENAME DESC;
-- Q27-Donner le numéro, le nom et le revenu total des employés embauchés un 13/05
-- par ordre croissant de la date puis revenu décroissant.
    
    SELECT EMPNO, ENAME, (SAL+COMM) AS TOTSAL FROM EMP WHERE EMPNO IN ( SELECT EMPNO FROM EMP WHERE TO_CHAR(HIREDATE,'DD/MM')='13/05');
    
 
