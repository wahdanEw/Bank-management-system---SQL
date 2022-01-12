/*טבלת בנקים*/
CREATE  TABLE  Banks  ( bid  INTEGER  NOT NULL,
                        name  CHAR( 20 ),
                        PRIMARY KEY(bid));
						
/*טבלת סניפים*/
CREATE  TABLE  Branches	( bid INTEGER NOT NULL,
						  brid INTEGER NOT NULL,
						  name CHAR( 20 ),
						  adress CHAR( 20 ),
						  oid INTEGER,
						  PRIMARY KEY( brid ),
						  FOREIGN KEY(bid) REFERENCES  Banks(bid) ON DELETE CASCADE);

/*טבלת חשבונות*/
CREATE  TABLE  Accounts	( bid INTEGER NOT NULL,
						  brid  INTEGER NOT NULL ,
						  aid INTEGER NOT NULL,
						  atype CHAR( 20 ),
						  balance REAL,
						  deposits REAL, /*פיקדונות וחסכונות,*/
						  vfsportfolio REAL, /*שווי תיק ניירות ערך,*/
						  loans REAL, /*הלוואות*/
						  PRIMARY KEY( aid ),
						  FOREIGN KEY(bid) REFERENCES Branches(bid) ON DELETE CASCADE,
						  FOREIGN KEY(brid) REFERENCES Branches(brid) ON DELETE CASCADE);

/*טבלת עובדי בנק*/
CREATE  TABLE  bankWoker	( oid INTEGER NOT NULL,
							  fname CHAR( 20 ),
							  lname CHAR( 20 ),
							  birthday DATE,
							  seniority CHAR( 10 ),
							  salary REAL,
							  PRIMARY KEY (oid) );

/*טבלת לקוחות*/
CREATE  TABLE  Customer		( cid INTEGER  NOT NULL,
							  fname  CHAR( 20 ),
							  lname CHAR( 20 ),
							  birthday  DATE,
							  PRIMARY KEY(cid));
							  
/*טבלת בעלי חשבונות*/
CREATE  TABLE  Account_holders	(   bid INTEGER  NOT NULL,
									brid  INTEGER  NOT NULL,
									aid  INTEGER  NOT NULL,
									cid INTEGER  NOT NULL,
									PRIMARY KEY( bid, brid, aid, cid ),
									FOREIGN KEY(bid) REFERENCES  Accounts(bid) ON DELETE CASCADE,
									FOREIGN KEY(brid) REFERENCES  Accounts(brid) ON DELETE CASCADE,
									FOREIGN KEY(aid) REFERENCES  Accounts(aid) ON DELETE CASCADE,
									FOREIGN KEY(cid) REFERENCES  Customer(cid) ON DELETE CASCADE);


/*Create Values Into Bank table*/
INSERT INTO Banks (bid, name)
VALUES	('1', 'hapoalim'),
		('2', 'yahav'),
		('3', 'discuont'),
		('4', 'leumi'),
		('5', 'benleumi');
		
INSERT INTO Branches (bid, brid, name, adress, oid)
VALUES	('1', '11', 'koko', 'hifa', '123123444'),
		('2', '22', 'marko', 'karmiel', '123123555'),
		('3', '52', 'jad', 'eilat', '123123666'),
		('4', '44', 'master', 'krayot', '123123777'),
		('5', '13', 'mako', 'akko', '123123888');		
		
		
INSERT INTO Accounts (bid, brid, aid, atype, balance, deposits, vfsportfolio, loans)
VALUES	('1', '11', '123', 'premuim', '8000', '25000', '200', '100000'),
		('2', '22', '1234', 'privacy', '8500', '98000', '100', '200000'),
		('3', '52', '12345', 'privacy', '11000', '16000', '300', '120000'),
		('4', '44', '123456', 'privacy', '-12000', '32000', '700', '500000'),
		('5', '13', '1234567', 'premuim', '5000', '31000', '500', '170000'),
		('3', '52', '12345678', 'premuim', '4000', '20000', '800', '190000'),
		('4', '44', '12345679', 'privacy', '-14000', '3000', '200', '10000');


INSERt INTO bankWoker (oid, fname, lname, birthday, seniority, salary)
VALUES	('123123444', 'mark', 'smith', '1990-05-20', '4', '10000'),
		('123123555', 'johny', 'json', '1980-04-11', '14', '14000'),
		('123123666', 'sony', 'flask', '1995-08-16', '2', '8500'),
		('123123777', 'jenkiz', 'sele', '1982-05-20', '8', '10000'),
		('123123888', 'jojo', 'sminta', '1992-07-30', '5', '9000');


INSERT INTO Customer (cid, fname, lname, birthday)
VALUES	('123456789', 'wahdan', 'ew', '1940-01-1'),
		('123456780', 'mygrandfa', 'ew', '1993-04-10'),
		('123456781', 'john', 'sam', '2021-04-15'),
		('123456782', 'jakob', 'samson', '2010-04-15'),
		('123456783', 'jasmine', 'glask', '1995-07-14'),
		('123456784', 'welly', 'skott', '2021-04-15'),
		('123456785', 'sam', 'cent', '2005-03-10');
		
		
INSERT INTO Account_holders(bid, brid, aid, cid)
VALUES	('1', '11', '123', '123456789'),
		('2', '22', '1234', '123456780'),
		('3', '52', '12345', '123456781'),
		('4', '44', '123456', '123456782'),
		('5', '13', '1234567', '123456783'),
		('3', '52', '12345678', '123456784'),
		('4', '44', '12345679', '123456785');

