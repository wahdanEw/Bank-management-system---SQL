/*#1*/
/*כתבו שאילתה המחזירה את ת.ז, שם ושם משפחה של כל הלקוחות
. הוותיקים של בנק הפועלים, לקוח ותיק הוא לקוח שגילו מעל 75*/
SELECT C.cid,C.fname,C.lname
FROM Customer C, Banks B, Account_holders AH
WHERE B.bid = AH.bid AND C.cid = AH.cid AND C.birthday < '1946-01-01'


/*#2*/
/*כתבו שאילתה המחזירה את מספרי כל החשבונות שנמצאות ביתרת חובה
גדולה מ 10000 ₪ )כלומר פחות מ -10000 ( בבנק לאומי .*/
SELECT A.aid
FROM Accounts A, Bank B
WHERE A.bid = B.bid AND A.balance < '-10000' AND B.name = 'leumi';
????

/*#3*/
/*כתבו שאילתה המחזירה עבור כל סניף בבנק דיסקונ ט כמה חשבונות
קיימים בו .*/
SELECT BR.brid, COUNT(A.aid) as amountOfAccount_discountBank
FROM Banks B, Branches BR, Accounts A
WHERE A.brid = BR.brid AND BR.bid = B.bid AND BR.bid = A.bid AND B.name = 'discuont'
GROUP BY (A.brid)

/*B.bid = BR.bid AND Br.bid = A.bid AND BR.brid=A.brid*/


/*#04*/
/*בנק לאומי חוגג יום הולדת 70 בתאריך 15.4.2021 ומעוניין לחלק מתנות לכל
לקוחות הבנק שחוגגים יום הולדת באותו התאריך. כתבו שאילתה המחשבת
כמה מתנות צריך להזמין.*/
SELECT COUNT(C.birthday) as Amount_of_gifts
FROM Banks B, Customer C, Account_holders AH
WHERE B.bid = AH.bid AND C.cid = AH.cid AND C.birthday = '2021-04-15'
GROUP BY (C.birthday)


/*#5*/
/*כתוב שאילתה המחזירה את ת.ז והשם של כל הלקוחות בני פחות מ 18
שנים בכל הבנקים, ללא כפילויות*/
SELECT C.cid, C.fname
FROM Customer C, Account_holders AH, Banks B
WHERE C.cid = AH.cid AND B.bid = AH.bid AND C.birthday > '2003-01-01';


/*#6*/
/*אשתו של מנהל הסניף בבנק דיסקונט סניף מספר 52 מחפשת שם ייחודי
לבן\לבת שלה, היא מבקשת מבעלה להביא רשימת שמות של כל לקוחות
הסניף על מנת לבחור שם. אנא צרו רשימת שמות ללא כפילויות של כל
הלקוחות בסניף זה*/
SELECT DISTINCT C.fname
FROM Branches BR, Customer C, Account_holders AH, Banks B
WHERE C.cid = AH.cid AND Br.bid = AH.bid AND BR.brid = AH.brid AND B.name = 'discuont' AND AH.brid = '52'


/*#07*/
/*החזירו את ת.ז של הלקוחות שמנהלים חשבון גם בבנק לאומי וגם בבנק
פועלים .*/
SELECT C.cid
FROM Customer C, Account_holders AH, Banks B
WHERE C.cid = AH.cid AND B.bid = AH.bid AND B.name IN(  SELECT B.name
														FROM Banks B
														WHERE B.name = 'hapoalim' OR B.name = 'leumi' );

/*other sulotion*/
select C.fname
FROm Branches BR, Account_holders AH, Customer C
where BR.brid = AH.brid AND (BR.brid = 1 or BR.brid = 2)
GROUP BY AH.cid
HAVING COUNT(DISTINCT BR.bid) > 1


/*#08*/
/*החזירו את מספר החשבון של כל הלקוחות בסניף 13 בבנק הבינלאומי
. ₪ שיתרת העו"ש שלהם היא בין 5000 ₪ לבין 15000*/
SELECT A.aid
FROM  Customer C, Accounts A, Account_holders AH
WHERE C.cid = AH.cid AND A.brid = '13' AND A.balance >= '5000'
UNION
SELECT A.aid
FROM  Customer C, Accounts A, Account_holders AH
WHERE C.cid = AH.cid AND A.brid = '13' AND A.balance <= '15000'

/*other solution*/
SELECT A.aid
FROM  Banks B, branches BR, accounts A 
WHERE B.bid = BR.bid AND BR.bid = A.bid AND B.name = 'benleumi' AND BR.brid = '13' AND A.balance >= '5000'
UNION
SELECT A.aid
FROM  Banks B, branches BR, accounts A
WHERE B.bid = BR.bid AND BR.bid = A.bid AND B.name = 'benleumi' AND BR.brid = '13' AND A.balance <= '15000'


/*#09*/
/*החזירו את השם ומספר ת.ז של הלקוחות שמנהלים יותר מחשבון בנק אחד*/
SELECT DISTINCT C.fname, C.cid
FROM Customer C, Account_holders AH
WHERE C.cid IN (SELECT AH.cid
				FROM Accounts A, Account_holders AH
				WHERE A.brid = AH.brid AND A.bid = AH.bid
				GROUP BY (A.aid)
				HAVING COUNT(*) > 1);

/*other sulotion*/
SELECT DISTINCT C.fname, C.cid
FROM Customer C, Account_holders AH
WHERE C.cid = AH.cid
GROUP BY (C.cid)
HAVING COUNT(AH.cid) > 1;				

/*10*/
/*החזירו את השמות של הלקוחות שיש להם יתרת עו"ש הגדולה מ 15000
. ₪ או יתרת פקדונות הגדולה מ 15000*/
SELECT C.fname
FROM Customer C, Account_holders AH, Accounts A
WHERE C.cid = AH.cid AND AH.aid = A.aid AND A.balance > '15000'
UNION
SELECT C.fname
FROM Customer C, Account_holders AH, Accounts A
WHERE C.cid = AH.cid AND AH.aid = A.aid OR A.deposits > '15000'
				
				
/*11*/
/*החזירו עבור כל סניף בכל בנק את הנתונים אודות מנהל הסניף שלו, מספר
ת.ז שם ושם משפחה .*/
SELECT BW.oid, BW.fname, BW.lname
FROM bankWoker BW,Branches B
WHERE B.oid = BW.oid


/*12*/
/*החזירו את מספר הבנק ומספר הסניף שמונה יותר מ 10000 לקוחות*/
SELECT  AH.bid, AH.brid
FROM Account_holders AH
GROUP BY (AH.bid,AH.brid)
HAVING COUNT(*) > 10000