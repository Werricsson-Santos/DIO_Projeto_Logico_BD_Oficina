-- Populando o banco de dados.

INSERT INTO customer (FirstName, MiddleInitName, LastName, CPF, Phone, Email, Address) VALUES
('João', 'S.', 'Silva', '12345678901', '912345678', 'joao.silva@email.com', 'Rua A, 123'),
('Maria', 'C.', 'Santos', '98765432109', '998765432', 'maria.santos@email.com', 'Av. B, 456'),
('Carlos', 'R.', 'Ferreira', '11122233344', '999999999', 'carlos.ferreira@email.com', 'Rua G, 987'),
('Ana', 'L.', 'Ribeiro', '55566677788', '888888888', 'ana.ribeiro@email.com', 'Av. H, 654');


INSERT INTO vehicle (IdClientVehicle, Model, LicensePlate, InGarage, LastRevision) VALUES
(1, 'Fiat Uno', 'ABC1234', true, '2023-07-15'),
(2, 'Volkswagen Gol', 'XYZ9876', false, '2023-06-20'),
(3, 'Chevrolet Onix', 'DEF5678', true, '2023-07-10'),
(4, 'Ford Ka', 'GHI9012', false, '2023-06-25');


INSERT INTO spare_parts (Brand, Model, Price) VALUES
('Bosch', 'Filtro de óleo', 25.00),
('MTE-Thomson', 'Vela de ignição', 15.00),
('Cofap', 'Amortecedor', 150.00),
('Fram', 'Filtro de ar', 20.00),
('Bosh', 'Correia dentada', 40.00),
('Mobil', 'Óleo de motor', 30.00);


INSERT INTO equipment (Model, Brand, TypeEquipment, LastRepair) VALUES
('Chave de fenda', 'Tramontina', 'Ferramenta leve', '2023-07-05'),
('Macaco hidráulico', 'Ferrari', 'Ferramenta pesada', '2023-06-10'),
('Carro de Ferramentas em Aço Cromo Vanádio', 'Bumafer', 'Ferramenta leve', '2023-07-20'),
('Elevador Trifásico Automotivo 2500Kg', 'MAQUINAS RIBEIRO', 'Ferramenta pesada', '2023-06-15');


INSERT INTO garage (Address, Employees, ParkingSpace) VALUES
('Rua E, 1234', 5, 6),
('Av. F, 567', 8, 10);


INSERT INTO mechanic (IsManager, IdGarageMech, FirstName, MiddleInitName, LastName, CPF, Specialty, Salary, Address, Phone) VALUES
(true, 1, 'Pedro', 'A.', 'Santos', '87654321098', 'Motor', 3500.00, 'Rua C, 789', '912345678'),
(false, 1, 'Ana', 'M.', 'Silva', '65432109876', 'Suspensão', 2500.00, 'Av. D, 987', '998765432'),
(true, 2, 'Mariana', 'T.', 'Costa', '33344455566', 'Freios', 2800.00, 'Rua I, 543', '777777777'),
(false, 2, 'Gustavo', 'P.', 'Oliveira', '99988877766', 'Ar condicionado', 2600.00, 'Av. J, 321', '555555555');


INSERT INTO service (IdGarageService, IdMechService, TypeOfService, Description, InitDate, InitTime, FinishDate, FinishTime) VALUES
(1, 1, 'Revisão', 'Troca de óleo e filtro', '2023-08-01', '08:00:00', '2023-08-01', '10:00:00'),
(1, 2, 'Reparo', 'Substituição da suspensão', '2023-08-02', '09:30:00', NULL, NULL),
(2, 3, 'Revisão', 'Troca de filtro de ar e correia dentada', '2023-08-02', '09:00:00', '2023-08-02', '11:00:00'),
(2, 4, 'Reparo', 'Reparo no sistema de ar condicionado', '2023-08-03', '10:30:00', NULL, NULL);


INSERT INTO storages (Quantity, Capacity) VALUES
(100, 200),
(50, 100);


INSERT INTO garage_equipments (IdGEgarage, IdGEequipment, Quantity, State) VALUES
(1, 1, 5, 'Ok'),
(2, 1, 5, 'Ok'),
(2, 2, 2, 'Em reparo'),
(1, 2, 2, 'Ok'),
(1, 3, 2, 'Ok'),
(2, 3, 2, 'Ok'),
(1, 4, 1, 'Em reparo'),
(2, 4, 1, 'Ok');


INSERT INTO parts_in_storage (IdPSstorage, IdPSpart, Quantity, Replacement) VALUES
(1, 1, 50, false),
(2, 2, 25, false),
(1, 3, 20, false),
(2, 5, 40, false),
(1, 4, 80, false),
(2, 6, 100, false);


INSERT INTO service_parts (IdSPservice, IdSPpart, Quantity) VALUES
(1, 1, 2),   -- Revisão com ID 1: 2 peças do filtro de óleo com ID 1
(1, 2, 4),   -- Revisão com ID 1: 4 peças de vela de ignição com ID 2
(2, 1, 1),   -- Reparo com ID 2: 1 peça de filtro de óleo com ID 1
(2, 2, 2),   -- Reparo com ID 2: 2 peças de vela de ignição com ID 2
(3, 3, 1),   -- Revisão com ID 3: 1 peça de amortecedor com ID 3
(4, 6, 4);   -- Reparo com ID 4: 4 peças de óleo de motor com ID 6


INSERT INTO service_order (IdSOservice, IdSOgarage, IdSOclient, ServiceStatus, EstimatedFinish, FinishDate, Price) VALUES
(1, 1, 1, 'Em andamento', '2023-08-01 10:00:00', NULL, 100.00),
(2, 2, 2, 'Em espera', NULL, NULL, 250.00),
(3, 1, 3, 'Em espera', NULL, NULL, 150.00),
(4, 2, 4, 'Finalizado', '2023-08-02 11:00:00', '2023-08-02 11:30:00', 80.00);