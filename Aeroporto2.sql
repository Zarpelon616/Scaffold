CREATE DATABASE AEROPORTO;
GO
USE AEROPORTO;
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'Cidade')
BEGIN
	CREATE TABLE [dbo].[Cidade](
		[IdCidade] INT IDENTITY(1,1),
		[Cidade] VARCHAR(80),
		[Estado] VARCHAR(80),
		[Pais] VARCHAR(45),
		[Sigla] VARCHAR(2)
		CONSTRAINT [PK_dbo.Cidade] PRIMARY KEY CLUSTERED ([IdCidade] ASC),
	);
END
GO


IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'Aeroporto')
BEGIN
	CREATE TABLE [dbo].[Aeroporto](
		[IdAeroporto] INT IDENTITY(1,1),
		[Nome] VARCHAR(80),
		[Cidade] INT,
		[CNPJ] CHAR(14),
		[Sigla] VARCHAR(3),
		CONSTRAINT [PK_dbo.Aeroporto] PRIMARY KEY CLUSTERED ([IdAeroporto] ASC),
		FOREIGN KEY (Cidade) REFERENCES Cidade(IdCidade)
	);
END
GO


IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'ModeloAeronave')
BEGIN
	CREATE TABLE [dbo].[ModeloAeronave](
    [IdModelo] INT IDENTITY(1,1),
    [NomeModelo] VARCHAR(80),
    [AnoModelo] INT,
    [CapacidadePoltronas] INT,
    [CapacidadeCombustivel] INT
	CONSTRAINT [PK_dbo.ModeloAeronave] PRIMARY KEY CLUSTERED ([IdModelo] ASC),
	);
END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'Pilotos')
BEGIN
	CREATE TABLE [dbo].[Pilotos](
    [IdPiloto] INT IDENTITY(1,1),
    [NomePiloto] VARCHAR(80),
    [CPF] CHAR(11), 
    [Nascimento] DATE,
    [NumCertificacao] INT,
	CONSTRAINT [PK_dbo.Pilotos] PRIMARY KEY CLUSTERED ([IdPiloto] ASC),
	);
END
GO


IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'Aeronave')
BEGIN
	CREATE TABLE [dbo].[Aeronave](
    [IdAeronave] INT IDENTITY(1,1),
    [NomeAeronave] VARCHAR(120),
    [Ativo] BIT,
    [ModeloAeronave] INT,
    [Piloto] INT,
	CONSTRAINT [PK_dbo.Aeronave] PRIMARY KEY CLUSTERED ([IdAeronave] ASC),
    FOREIGN KEY (ModeloAeronave) REFERENCES ModeloAeronave(IdModelo),
    FOREIGN KEY (Piloto) REFERENCES Pilotos(IdPiloto)
	);
END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'Cliente')
BEGIN
	CREATE TABLE [dbo].[Cliente](
    [IdCliente] INT IDENTITY(1,1),
    [NomeCliente] VARCHAR(80),
    [DataNascimento] DATE,
    [Passagem] VARCHAR(45),
    [Sexo] CHAR(1),
    [CPF] VARCHAR(11),
	CONSTRAINT [PK_dbo.Cliente] PRIMARY KEY CLUSTERED ([IdCliente] ASC),
	);
END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'Poltrona')
BEGIN
	CREATE TABLE [dbo].[Poltrona](
    [IdPoltrona] INT IDENTITY(1,1),
    [NumPoltrona] VARCHAR(4),
    [Ocupado] BIT
	CONSTRAINT [PK_dbo.Poltrona] PRIMARY KEY CLUSTERED ([IdPoltrona] ASC),
	);
END
GO


IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'Voo')
BEGIN
	CREATE TABLE [dbo].[Voo](
    [IdVoo] INT IDENTITY(1,1),
    [Partida] INT,
    [Destino] INT,
    [PrevistoDecolagem] DATETIME,
    [PrevistoPouso] DATETIME,
    [TempoDecolagem] DATETIME,
    [TempoPouso] DATETIME,
    [Aeronave] INT,
	CONSTRAINT [PK_dbo.IdVoo] PRIMARY KEY CLUSTERED ([IdVoo] ASC),
    FOREIGN KEY (Partida) REFERENCES Aeroporto(IdAeroporto),
    FOREIGN KEY (Destino) REFERENCES Aeroporto(IdAeroporto),
    FOREIGN KEY (Aeronave) REFERENCES Aeronave(IdAeronave)
	);
END
GO


IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'Passagem')
BEGIN
	CREATE TABLE [dbo].[Passagem](
    [IdPassagem] INT IDENTITY(1,1),
    [NumeroPassagem] INT,
    [ClientePassagem] INT,
    [VooNum] INT,
    [Poltrona] INT,
    [AeroportoDecolagem] INT,
    [AeroportoPouso] INT,
	CONSTRAINT [PK_dbo.Passagem] PRIMARY KEY CLUSTERED ([IdPassagem] ASC),
    FOREIGN KEY (ClientePassagem) REFERENCES Cliente(IdCliente),
    FOREIGN KEY (VooNum) REFERENCES Voo(IdVoo),
    FOREIGN KEY (Poltrona) REFERENCES Poltrona(IdPoltrona),
    FOREIGN KEY (AeroportoDecolagem) REFERENCES Aeroporto(IdAeroporto),
    FOREIGN KEY (AeroportoPouso) REFERENCES Aeroporto(IdAeroporto)
	);
END
GO
