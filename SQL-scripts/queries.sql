-- Queries:
USE oficina;

-- Quantos mecânicos a rede de oficinas possui?
SELECT COUNT(*) AS Qtde_Mecânicos FROM mechanic;


-- Quantidade de mecânicos por oficina:
SELECT a.Address, COUNT(*) AS Qtde_Mecânicos FROM garage a
	INNER JOIN mechanic ON IdGarageMech = IdGarage
    GROUP BY IdGarage;
    
    
 -- Faturamento da rede de oficinas:
SELECT SUM(Price) AS Faturamento FROM service_order;


-- Faturamento por oficina:
SELECT a.Address, SUM(Price) AS Faturamento FROM garage a
	INNER JOIN service_order ON IdSOgarage = IdGarage
    GROUP BY IdGarage;
    

-- Quais são os gerentes de cada oficina?
desc mechanic;
SELECT CONCAT(FirstName, ' ', MiddleInitName, ' ', LastName) AS Gerentes, Specialty, Salary, a.Address AS Oficina
	FROM mechanic
	INNER JOIN garage a ON IdGarage = IdGarageMech
    WHERE IsManager = True;
    
    
    
-- Quantos equipamentos e peças de reposição cada oficina possui?
SELECT a.Address, SUM(e.Quantity) AS Equipamentos, SUM(p.Quantity) AS Pecas_Reposicao FROM garage a
	INNER JOIN garage_equipments e ON IdGEgarage = IdGarage
    INNER JOIN parts_in_storage p ON IdPSstorage = IdGarage
    GROUP BY IdGarage;