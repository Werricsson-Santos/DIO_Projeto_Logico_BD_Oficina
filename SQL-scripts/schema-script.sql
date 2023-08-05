-- Criação do banco de dados para o cenário de Oficina
CREATE DATABASE oficina;
USE oficina;


CREATE TABLE customer(
	IdClient INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(80),
    MiddleInitName VARCHAR(3),
    LastName VARCHAR(80),
    CPF CHAR(11) NOT NULL UNIQUE,
    Phone CHAR(9),
    Email VARCHAR(100),
    Address VARCHAR(255)
);


CREATE TABLE vehicle(
	IdVehicle INT PRIMARY KEY AUTO_INCREMENT,
    IdClientVehicle INT,
    Model VARCHAR(150),
    LicensePlate CHAR(7) NOT NULL UNIQUE,
    InGarage BOOLEAN,
    LastRevision DATE,
    CONSTRAINT FK_CLIENT_VEHICLE FOREIGN KEY (IdClientVehicle) REFERENCES customer(IdClient)
);


CREATE TABLE mechanic(
	IdMechanic INT PRIMARY KEY AUTO_INCREMENT,
    IdManager BOOLEAN,
    FirstName VARCHAR(80),
    MiddleInitName VARCHAR(3),
    LastName VARCHAR(80),
    CPF CHAR(11) NOT NULL UNIQUE,
	Specialty VARCHAR(60),
    Salary FLOAT,
    Address VARCHAR(255),
    Phone CHAR(9)
);


CREATE TABLE spare_parts(
	IdPart INT PRIMARY KEY AUTO_INCREMENT,
    Brand VARCHAR(80),
    Model VARCHAR(80),
    Price FLOAT
);


CREATE TABLE equipment(
	IdEquipment INT PRIMARY KEY AUTO_INCREMENT,
    Model VARCHAR(80),
    Brand VARCHAR(80),
    TypeEquipment ENUM('Ferramenta leve', 'Ferramenta pesada'),
    LastRepair DATE
);


CREATE TABLE garage(
	IdGarage INT PRIMARY KEY AUTO_INCREMENT,
    Address VARCHAR(255),
    Employees INT,
    ParkingSpace INT DEFAULT 4
);

ALTER TABLE mechanic
	ADD IdGarageMech INT,
    ADD CONSTRAINT FK_GARAGE_MECH FOREIGN KEY (IdGarageMech) REFERENCES garage(IdGarage);
    

CREATE TABLE service(
	IdService INT PRIMARY KEY AUTO_INCREMENT,
    IdGarageService INT,
    IdMechService INT,
    TypeOfService ENUM('Revisão', 'Reparo') DEFAULT 'Revisão',
    Description VARCHAR(255),
    InitDate DATE,
    InitTime TIME,
    FinishDate DATE,
    FinishTime TIME,
    CONSTRAINT FK_MECH_SERVICE FOREIGN KEY (IdMechService) REFERENCES mechanic(IdMechanic),
    CONSTRAINT FK_GARAGE_SERVICE FOREIGN KEY (IdGarageService) REFERENCES garage(IdGarage)
);


CREATE TABLE storages(
	IdStorage INT PRIMARY KEY AUTO_INCREMENT,
    Quantity INT DEFAULT 0,
    Capacity INT
);

ALTER TABLE garage
	ADD IdStorageGarage INT,
    ADD CONSTRAINT FK_STORE_GARAGE FOREIGN KEY (IdStorageGarage) REFERENCES storages(IdStorage);

DELIMITER \\
CREATE TRIGGER TR_STORAGE_GARAGE
AFTER INSERT ON storages
FOR EACH ROW
BEGIN
	DECLARE IdStorage INT;
    SET IdStorage = New.IdStorage;
	
    UPDATE garage
    SET IdStorageGarage = IdStorage
    WHERE IdGarage = IdStorage;
END;
\\
DELIMITER ;


CREATE TABLE garage_equipments(
	IdGEgarage INT,
    IdGEequipment INT,
    Quantity INT DEFAULT 1,
    State ENUM('Ok', 'Aguardando reparo', 'Em reparo') DEFAULT 'Ok',
    CONSTRAINT FK_GE_GARAGE FOREIGN KEY (IdGEgarage) REFERENCES garage(IdGarage),
    CONSTRAINT FK_GE_EQUIPMENT FOREIGN KEY (IdGEequipment) REFERENCES equipment(IdEquipment)
);

 
CREATE TABLE parts_in_storage(
	IdPSstorage INT,
    IdPSpart INT,
    Quantity INT DEFAULT 0,
    Replacement BOOL DEFAULT True,
    CONSTRAINT FK_PS_STORAGE FOREIGN KEY (IdPSstorage) REFERENCES storages(IdStorage),
    CONSTRAINT FK_PS_PARTS FOREIGN KEY (IdPSpart) REFERENCES spare_parts(IdPart)
);


CREATE TABLE service_parts(
	IdSPservice INT,
    IdSPpart INT,
    Quantity INT,
    CONSTRAINT FK_SP_SERVICE FOREIGN KEY (IdSPservice) REFERENCES service(IdService),
    CONSTRAINT FK_SP_PARTS FOREIGN KEY (IdSPpart) REFERENCES spare_parts(IdPart)
);


DELIMITER \\
CREATE TRIGGER TR_SERVICE_PARTS
AFTER INSERT ON service_parts
FOR EACH ROW
BEGIN

	DECLARE used INT;
    SET used = New.Quantity;
	
    UPDATE parts_in_storage
    SET Quantity = Quantity - used
    WHERE IdPSpart = New.IdSPpart;
    
END;
\\
DELIMITER ;


CREATE TABLE service_order(
    IdSOservice INT,
    IdSOgarage INT,
    IdSOclient INT,
    ServiceStatus ENUM('Em espera','Em andamento', 'Finalizado'),
    EstimatedFinish DATETIME,
    FinishDate DATETIME,
    Price FLOAT,
    CONSTRAINT FK_SO_SERVICE FOREIGN KEY (IdSOservice) REFERENCES service(IdService),
    CONSTRAINT FK_SO_CLIENT FOREIGN KEY (IdSOclient) REFERENCES customer(IdClient),
    CONSTRAINT FK_SO_GARAGE FOREIGN KEY (IdSOgarage) REFERENCES garage(IdGarage)
);