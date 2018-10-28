-- EX 01
USE LMS;

--EX 02
SELECT 
	A.NOME AS NOME_ALUNO, 
	A.RA AS RA_ALUNO,
	D.NOME AS NOME_DISCIPLINA,
	P.NOME AS NOME_PROFESSOR
FROM SOLICITACAOMATRICULA S 
JOIN ALUNO A ON S.IDALUNO = A.ID
JOIN DISCIPLINAOFERTADA DO ON S.IDDOFERTADA = DO.ID
JOIN DISCIPLINA D ON DO.IDDISCIPLINA = D.ID
JOIN PROFESSOR P ON DO.IDPROFESSOR = P.ID
WHERE S.STATUS = 'APROVADA';


--EX 03
SELECT 
	C.NOME,
	DO.SEMESTRE,
	DO.TURMA,
	D.NOME,
	D.ID,
	DO.IDDISCIPLINA
FROM DISCIPLINAOFERTADA DO 
JOIN DISCIPLINA D ON DO.IDDISCIPLINA = D.ID 
JOIN CURSO C ON C.ID = DO.IDCURSO
WHERE D.STATUS = 'ABERTA' AND DO.ANO = 2018
ORDER BY ID;


-- EX 04
SELECT
	 E.TITULO AS ATIVIDADES_NÃO_ENTREGUES,
	 E.STATUS
FROM DISCIPLINAOFERTADA AS DO
INNER JOIN ATIVIDADEVINCULADA AS AV
ON DO.ID = AV.IDDOFERTADA
INNER JOIN ENTREGA AS E 
ON E.IDAVINCULADA = AV.ID
WHERE E.STATUS NOT IN( 'CORRIGIDO' , 'ENTREGUE')


-- EX 05
SELECT
	 E.TITULO AS ATIVIDADES_ENTREGUES,
	 E.STATUS
FROM DISCIPLINAOFERTADA AS DO
INNER JOIN ATIVIDADEVINCULADA AS AV
ON DO.ID = AV.IDDOFERTADA
INNER JOIN ENTREGA AS E 
ON E.IDAVINCULADA = AV.ID
WHERE E.STATUS = ('ENTREGUE')


--EX 06
SELECT 
	D.NOME AS DISCIPLINA_SEM_PROFESSOR
FROM DISCIPLINAOFERTADA DO 
JOIN DISCIPLINA D ON D.ID = DO.IDDISCIPLINA
WHERE DO.IDPROFESSOR IS NULL


-- EX 07
SELECT D.NOME, COUNT(S.IDALUNO ) AS QTDE
FROM DISCIPLINA D  
 JOIN DISCIPLINAOFERTADA DO ON D.ID = DO.IDDISCIPLINA
LEFT JOIN SOLICITACAOMATRICULA S ON DO.ID = S.IDDOFERTADA 

GROUP BY D.NOME 
ORDER BY 2 DESC ,D.NOME
SELECT * FROM DISCIPLINA WHERE ID =47;

SELECT * FROM SOLICITACAOMATRICULA WHERE IDDOFERTADA = 1;


-- EX 08
SELECT 
	   DISTINCT 
       A.NOME AS ALUNO, 
       ISNULL((SELECT EN.NOTA FROM ENTREGA EN JOIN ATIVIDADEVINCULADA ATV ON ATV.ID = EN.IDAVINCULADA WHERE EN.IDALUNO = E.IDALUNO AND ATV.IDATIVIDADE = 1 AND ATV.IDPROFESSOR = AV.IDPROFESSOR), 0) AS AC_1,
       ISNULL((SELECT EN.NOTA FROM ENTREGA EN JOIN ATIVIDADEVINCULADA ATV ON ATV.ID = EN.IDAVINCULADA WHERE EN.IDALUNO = E.IDALUNO AND ATV.IDATIVIDADE = 2 AND ATV.IDPROFESSOR = AV.IDPROFESSOR), 0) AS AC_2,
	   ISNULL((SELECT EN.NOTA FROM ENTREGA EN JOIN ATIVIDADEVINCULADA ATV ON ATV.ID = EN.IDAVINCULADA WHERE EN.IDALUNO = E.IDALUNO AND ATV.IDATIVIDADE = 3 AND ATV.IDPROFESSOR = AV.IDPROFESSOR), 0) AS AC_3,
	   ISNULL((SELECT EN.NOTA FROM ENTREGA EN JOIN ATIVIDADEVINCULADA ATV ON ATV.ID = EN.IDAVINCULADA WHERE EN.IDALUNO = E.IDALUNO AND ATV.IDATIVIDADE = 4 AND ATV.IDPROFESSOR = AV.IDPROFESSOR), 0) AS AC_4,
	   ISNULL((SELECT EN.NOTA FROM ENTREGA EN JOIN ATIVIDADEVINCULADA ATV ON ATV.ID = EN.IDAVINCULADA WHERE EN.IDALUNO = E.IDALUNO AND ATV.IDATIVIDADE = 5 AND ATV.IDPROFESSOR = AV.IDPROFESSOR), 0) AS AC_5,
       ISNULL((SELECT EN.NOTA FROM ENTREGA EN JOIN ATIVIDADEVINCULADA ATV ON ATV.ID = EN.IDAVINCULADA WHERE EN.IDALUNO = E.IDALUNO AND ATV.IDATIVIDADE = 6 AND ATV.IDPROFESSOR = AV.IDPROFESSOR), 0) AS AC_6,
	   ISNULL((SELECT EN.NOTA FROM ENTREGA EN JOIN ATIVIDADEVINCULADA ATV ON ATV.ID = EN.IDAVINCULADA WHERE EN.IDALUNO = E.IDALUNO AND ATV.IDATIVIDADE = 7 AND ATV.IDPROFESSOR = AV.IDPROFESSOR), 0) AS AC_7,
	   ISNULL((SELECT EN.NOTA FROM ENTREGA EN JOIN ATIVIDADEVINCULADA ATV ON ATV.ID = EN.IDAVINCULADA WHERE EN.IDALUNO = E.IDALUNO AND ATV.IDATIVIDADE = 8 AND ATV.IDPROFESSOR = AV.IDPROFESSOR), 0) AS AC_8,
	   ISNULL((SELECT EN.NOTA FROM ENTREGA EN JOIN ATIVIDADEVINCULADA ATV ON ATV.ID = EN.IDAVINCULADA WHERE EN.IDALUNO = E.IDALUNO AND ATV.IDATIVIDADE = 9 AND ATV.IDPROFESSOR = AV.IDPROFESSOR), 0) AS AC_9,
	   ISNULL((SELECT EN.NOTA FROM ENTREGA EN JOIN ATIVIDADEVINCULADA ATV ON ATV.ID = EN.IDAVINCULADA WHERE EN.IDALUNO = E.IDALUNO AND ATV.IDATIVIDADE = 10 AND ATV.IDPROFESSOR = AV.IDPROFESSOR), 0) AS AC_10
FROM ALUNO A  
LEFT JOIN ENTREGA E  ON  A.ID = E.IDALUNO
LEFT JOIN ATIVIDADEVINCULADA AV ON E.IDAVINCULADA = AV.ID
ORDER BY A.NOME


-- EX 09
CREATE VIEW VW_MEDIA_AC AS
SELECT  A.NOME,D.NOME AS DISIPLINA,DO.ANO,DO.SEMESTRE,DO.TURMA,AVG(E.MEDIA) AS MEDIA,CASE  when AVG(E.MEDIA)>=6 THEN 'aprovado' else 'reprovado' END AS STATUS FROM
(SELECT TOP 7 NOTA AS MEDIA,A.ID AS ALUNO FROM ENTREGA JOIN ALUNO A ON A.ID=ENTREGA.IDALUNO ORDER BY ENTREGA.NOTA DESC) E 
JOIN ALUNO A ON E.ALUNO = A.ID 
JOIN SOLICITACAOMATRICULA SM ON SM.IDALUNO = A.ID 
JOIN DISCIPLINAOFERTADA DO ON DO.ID = SM.IDDOFERTADA 
JOIN DISCIPLINA D ON D.ID = DO.IDDISCIPLINA GROUP BY A.NOME,D.NOME,DO.ANO,DO.SEMESTRE,DO.TURMA

-- EX 10
CREATE VIEW VW_TEMPO_CORRECAO AS
SELECT * FROM ENTREGA;
SELECT E.ROTULO,DATEDIFF(DD,A.DTENTREGA,A.DTAVALIACAO) AS DIFERENCA  FROM ENTREGA A JOIN ATIVIDADEVINCULADA E ON E.ID = A.IDAVINCULADA WHERE A.NOTA IS NOT NULL;
