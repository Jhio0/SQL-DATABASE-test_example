SET ECHO On;
SPOOL C:\spool\midterm.txt

DROP TABLE exam_House CASCADE CONSTRAINT;
DROP TABLE exam_Room CASCADE CONSTRAINT;
DROP TABLE exam_Furniture CASCADE CONSTRAINT;

CREATE TABLE exam_House (
    home_Number VARCHAR2 (10),
    owner_Name VARCHAR2 (10) NOT NULL,
    street VARCHAR2 (50) NOT NULL,
    city VARCHAR2 (50) NOT NULL,
    prov CHAR (2) NOT NULL,
    postal_Code CHAR (6) NOT NULL ,
    CONSTRAINT SYS_House_PK PRIMARY KEY (home_Number),
    CONSTRAINT SYS_House_Ck CHECK (prov in ('AB', 'BC', 'SK')),
    CONSTRAINT SYS_House_postal_Code_CK CHECK (postal_Code in ('[A-Z][0-9][A-Z][0-9][A-Z][0-9]'))
);

CREATE TABLE exam_Room (
    room_Name VARCHAR2 (20),
    home_Number VARCHAR2 (10) NOT NULL,
    wall_Colour CHAR (10) NOT NULL,
    CONSTRAINT SYS_Room_PK PRIMARY KEY (room_Name),
    CONSTRAINT SYS_House_Room_FK FOREIGN KEY (home_Number) REFERENCES exam_House(home_Number)
);

CREATE TABLE exam_Furniture (
    furniture_Name VARCHAR2 (20),
    room_Name VARCHAR2 (20) NOT NULL,
    price_Paid NUMBER (5,2),
    Current_value NUMBER (5,2) NOT NULL,
    Height NUMBER (1,2) NOT NUll,
    Width NUMBER (1,2) NOT NULL,
    Depth NUMBER (1,2) NOT NULL,
    CONSTRAINT SYS_Furniture_PK PRIMARY KEY (furniture_Name),
    CONSTRAINT SYS_Room_Furniture_FK FOREIGN KEY (room_Name) REFERENCES exam_Room(room_Name),
    CONSTRAINT SYS_Furniture_CK CHECK(price_Paid <= 99999.99),
    CONSTRAINT SYS_Furniture_current_Value_CK CHECK(Current_value <= 99999.99),
    CONSTRAINT SYS_Furniture_Height_CK CHECK(Height >= 0),
    CONSTRAINT SYS_Furniture_Width_CK CHECK(Width >= 0),
    CONSTRAINT SYS_Furniture_Depth_CK CHECK(Depth >= 0)
);

ALTER TABLE exam_Furniture 
ADD (purchase_Price NUMBER (7,2));

ALTER TABLE exam_Furniture
ADD CONSTRAINT SYS_Furniture_purcahse_Price_CK CHECK (purchase_Price <= 9999999.99);

ALTER TABLE exam_Furniture
ADD (date_Purchase DATE);

ALTER TABLE exam_Furniture
MODIFY price_Paid NUMBER (5,2) NOT NULL;

spool off
