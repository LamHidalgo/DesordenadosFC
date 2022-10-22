--CREATE DATABASE 
CREATE DATABASE DESORDENADOSFC
USE [DESORDENADOSFC]

--*****************************************************************[CLASES]

CREATE TABLE [CLASES]
(
 [id_Clase]      int IDENTITY (1, 1) NOT NULL ,
 [Descripcion]   varchar(50) NOT NULL ,
 [idCatedratico] int NOT NULL ,


 CONSTRAINT [PK_1] PRIMARY KEY CLUSTERED ([id_Clase] ASC)
);
GO

 -- ************************************** [ALUMNOS_CLASE]
CREATE TABLE [ALUMNOS_CLASE]
(
 [idAlumnoClase] int IDENTITY (1, 1) NOT NULL ,
 [id_Clase]      int NOT NULL ,
 [idalumno]      int NOT NULL ,


 CONSTRAINT [PK_2] PRIMARY KEY CLUSTERED ([idAlumnoClase] ASC),
 CONSTRAINT [FK_6] FOREIGN KEY ([id_Clase])  REFERENCES [CLASES]([id_Clase])
);



CREATE NONCLUSTERED INDEX [FK_2] ON [ALUMNOS_CLASE] 
 (
  [id_Clase] ASC
 );

 -- ************************************** [CALIFICACIONES]
CREATE TABLE [CALIFICACIONES]
(
 [id_calificacion] int IDENTITY (1, 1) NOT NULL ,
 [idAlumnoClase]   int NOT NULL ,
 [Nota]            decimal(18,0) NOT NULL ,
 [Fecha]           date NOT NULL ,


 CONSTRAINT [PK_3] PRIMARY KEY CLUSTERED ([id_calificacion] ASC),
 CONSTRAINT [FK_12] FOREIGN KEY ([idAlumnoClase])  REFERENCES [ALUMNOS_CLASE]([idAlumnoClase])
);
GO


CREATE NONCLUSTERED INDEX [FK_1] ON [CALIFICACIONES] 
 (
  [idAlumnoClase] ASC
 )

GO

 -- **************************************[CASOS]
 CREATE TABLE [CASOS]
(
 [idCasos]              int IDENTITY (1, 1) NOT NULL ,
 [id_Clase]             int NOT NULL ,
 [FechaInicio]          datetime NOT NULL ,
 [Fecha Cierre]         datetime NOT NULL ,
 [Titulo]               varchar(50) NOT NULL ,
 [Descripcion_completa] varchar(5000) NOT NULL ,


 CONSTRAINT [PK_4] PRIMARY KEY CLUSTERED ([idCasos] ASC),
 CONSTRAINT [FK_7] FOREIGN KEY ([id_Clase])  REFERENCES [CLASES]([id_Clase])
);



CREATE NONCLUSTERED INDEX [FK_2] ON [CASOS] 
 (
  [id_Clase] ASC
 );

  -- **************************************[RESULTADOS_CASOS]
 CREATE TABLE [RESULTADOS_CASOS]
(
 [idResultado]   int IDENTITY (1, 1) NOT NULL ,
 [idCasos]       int NOT NULL ,
 [idAlumnoClase] int NOT NULL ,
 [SaldoActivos]  money NOT NULL ,
 [SaldoPasivo]   money NOT NULL ,
 [SaldoPN]       money NOT NULL ,
 [Total]         money NOT NULL ,


 CONSTRAINT [PK_5] PRIMARY KEY CLUSTERED ([idResultado] ASC),
 CONSTRAINT [FK_10] FOREIGN KEY ([idCasos])  REFERENCES [CASOS]([idCasos]),
 CONSTRAINT [FK_11] FOREIGN KEY ([idAlumnoClase])  REFERENCES [ALUMNOS_CLASE]([idAlumnoClase])
);

CREATE NONCLUSTERED INDEX [FK_2] ON [RESULTADOS_CASOS] 
 (
  [idCasos] ASC
 );

CREATE NONCLUSTERED INDEX [FK_3] ON [RESULTADOS_CASOS] 
 (
  [idAlumnoClase] ASC
 );
GO

-- ************************************** [CAMPUS]
CREATE TABLE [CAMPUS]
(
 [idcampus]    int IDENTITY (1, 1) NOT NULL ,
 [Descripcion] varchar(50) NOT NULL ,
 [Ubicacion]   varchar(50) NOT NULL ,
 [IPServidor]  varchar(50) NOT NULL ,


 CONSTRAINT [PK_6] PRIMARY KEY CLUSTERED ([idcampus] ASC)
);
GO

-- ************************************** [CUENTAS_CONTABLES]
CREATE TABLE [CUENTAS_CONTABLES]
(
 [idcuenta]         int IDENTITY (1, 1) NOT NULL ,
 [Numero de Cuenta] int NOT NULL ,
 [Nombre de cuenta] varchar(50) NOT NULL ,
 [Descripcion]      nvarchar(500) NOT NULL ,
 [Tipo_cuenta]      varchar(10) NOT NULL ,
 [Clase_cuenta]     nvarchar(10) NOT NULL ,


 CONSTRAINT [PK_7] PRIMARY KEY CLUSTERED ([idcuenta] ASC, [Numero de Cuenta] ASC)
);
GO

-- ************************************** [DETALLE_CASOS]
CREATE TABLE [DETALLE_CASOS]
(
 [idDetalleCasos] int NOT NULL ,
 [idcaso]         int NOT NULL ,
 [idcuenta]       int NOT NULL ,
 [Saldo]          int NOT NULL ,


 CONSTRAINT [PK_8] PRIMARY KEY CLUSTERED ([idDetalleCasos] ASC),
 CONSTRAINT [FK_8] FOREIGN KEY ([idcaso])  REFERENCES [CASOS]([idCasos]),
 CONSTRAINT [FK_9] FOREIGN KEY ([idcuenta], [Saldo])  REFERENCES [CUENTAS_CONTABLES]([idcuenta], [Numero de Cuenta])
);
GO


CREATE NONCLUSTERED INDEX [FK_2] ON [DETALLE_CASOS] 
 (
  [idcaso] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FK_3] ON [DETALLE_CASOS] 
 (
  [idcuenta] ASC, 
  [Saldo] ASC
 )
GO

-- ************************************** [MODULOS]
CREATE TABLE [MODULOS]
(
 [idmodulo]    int IDENTITY (1, 1) NOT NULL ,
 [Descripcion] varchar(50) NOT NULL ,


 CONSTRAINT [PK_9] PRIMARY KEY CLUSTERED ([idmodulo] ASC)
);
GO

-- ************************************** [LOGS]
CREATE TABLE [LOGS]
(
 [idlog]       int NOT NULL ,
 [Descripcion] varchar(50) NOT NULL ,
 [idmodulo]    int NOT NULL ,
 [fecha]       datetime NOT NULL ,


 CONSTRAINT [PK_10] PRIMARY KEY CLUSTERED ([idlog] ASC),
 CONSTRAINT [FK_13] FOREIGN KEY ([idmodulo])  REFERENCES [MODULOS]([idmodulo])
);
GO


CREATE NONCLUSTERED INDEX [FK_2] ON [LOGS] 
 (
  [idmodulo] ASC
 )

GO

-- ************************************** [OPERACIONES]
CREATE TABLE [OPERACIONES]
(
 [id_operacion] int IDENTITY (1, 1) NOT NULL ,
 [Descripcion]  varchar(50) NOT NULL ,
 [idmodulo]     int NOT NULL ,


 CONSTRAINT [PK_11] PRIMARY KEY CLUSTERED ([id_operacion] ASC),
 CONSTRAINT [FK_4] FOREIGN KEY ([idmodulo])  REFERENCES [MODULOS]([idmodulo])
);
GO

CREATE NONCLUSTERED INDEX [FK_2] ON [OPERACIONES] 
 (
  [idmodulo] ASC
 )

GO

-- ************************************** [ROLES]
CREATE TABLE [ROLES]
(
 [idrol]       int IDENTITY (1, 1) NOT NULL ,
 [Descripcion] varchar(50) NOT NULL ,


 CONSTRAINT [PK_12] PRIMARY KEY CLUSTERED ([idrol] ASC)
);
GO

-- ************************************** [ROL_OPERACION]
CREATE TABLE [ROL_OPERACION]
(
 [id_Roloperacion] int IDENTITY (1, 1) NOT NULL ,
 [id_operacion]    int NOT NULL ,
 [idrol]           int NOT NULL ,


 CONSTRAINT [PK_13] PRIMARY KEY CLUSTERED ([id_Roloperacion] ASC),
 CONSTRAINT [FK_2] FOREIGN KEY ([id_operacion])  REFERENCES [OPERACIONES]([id_operacion]),
 CONSTRAINT [FK_5] FOREIGN KEY ([idrol])  REFERENCES [ROLES]([idrol])
);
GO


CREATE NONCLUSTERED INDEX [FK_2] ON [ROL_OPERACION] 
 (
  [id_operacion] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FK_4] ON [ROL_OPERACION] 
 (
  [idrol] ASC
 )

GO

-- ************************************** [USUARIOS]
CREATE TABLE [USUARIOS]
(
 [DNI]          int NOT NULL ,
 [Nombre]       varchar(50) NOT NULL ,
 [idcampus]     int NOT NULL ,
 [idrol]        int NOT NULL ,
 [email]        varchar(50) NOT NULL ,
 [password]     varchar(50) NOT NULL ,
 [fechaingreso] date NOT NULL ,


 CONSTRAINT [PK_14] PRIMARY KEY CLUSTERED ([DNI] ASC),
 CONSTRAINT [FK_1] FOREIGN KEY ([idrol])  REFERENCES [ROLES]([idrol]),
 CONSTRAINT [FK_5_1] FOREIGN KEY ([idcampus])  REFERENCES [CAMPUS]([idcampus])
);
GO


CREATE NONCLUSTERED INDEX [FK_2] ON [USUARIOS] 
 (
  [idrol] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FK_3] ON [USUARIOS] 
 (
  [idcampus] ASC
 )

GO