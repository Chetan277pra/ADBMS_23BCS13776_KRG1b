CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100)
);

CREATE TABLE Vendors (
    VendorID INT PRIMARY KEY,
    VendorName VARCHAR(100)
);

CREATE TABLE Supplies (
    SupplyID INT PRIMARY KEY,
    ProductID INT,
    VendorID INT,
    Quantity INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (VendorID) REFERENCES Vendors(VendorID)
);

INSERT INTO Products (ProductID, ProductName) VALUES (1, 'GRAPHIC TABLET');
INSERT INTO Vendors (VendorID, VendorName) VALUES (1, 'TECHSTORE LTD');

BEGIN TRANSACTION;

INSERT INTO Supplies (SupplyID, ProductID, VendorID, Quantity) VALUES (1001, 1, 1, 50);

SAVE TRANSACTION valid_supply;

BEGIN TRY
    INSERT INTO Supplies (SupplyID, ProductID, VendorID, Quantity) VALUES (1002, 99, 1, 30);
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION valid_supply;
END CATCH;

COMMIT;

SELECT 
    P.ProductName,
    V.VendorName,
    S.Quantity
FROM 
    Supplies S
JOIN 
    Products P ON S.ProductID = P.ProductID
JOIN 
    Vendors V ON S.VendorID = V.VendorID;
