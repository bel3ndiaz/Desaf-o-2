-- =====================================================================
-- crear_bd.sql
-- Biblioteca Digital de Instrucciones de Trabajo - Impresos Múltiples
-- Desafío 2: MySQL (XAMPP + phpMyAdmin)
--
-- Cómo usarlo: en phpMyAdmin → pestaña "Importar" → elegir este archivo → Continuar.
-- Si la base ya existe, borra y vuelve a crear las dos tablas (los datos se reinician).
-- =====================================================================

CREATE DATABASE IF NOT EXISTS biblioteca_impresos
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE biblioteca_impresos;

-- Se borra primero la tabla relacionada (la que tiene la llave foránea)
DROP TABLE IF EXISTS historial_versiones;
DROP TABLE IF EXISTS instrucciones;

-- ---------------------------------------------------------------------
-- Tabla principal: instrucciones de trabajo
-- ---------------------------------------------------------------------
CREATE TABLE instrucciones (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    codigo              VARCHAR(20)  NOT NULL UNIQUE,
    titulo              VARCHAR(100) NOT NULL,
    area                VARCHAR(50)  NOT NULL,
    version             INT          NOT NULL,   -- versión del documento cargado
    version_vigente     INT          NOT NULL,   -- última versión oficial aprobada
    enlace_video        VARCHAR(255) NULL,
    fecha_actualizacion DATE         NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Tabla relacionada: versiones de cada instrucción
-- instruccion_id es la LLAVE FORÁNEA: apunta a instrucciones.id
-- ON DELETE CASCADE: al borrar una instrucción se borran sus versiones
-- ---------------------------------------------------------------------
CREATE TABLE historial_versiones (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    instruccion_id INT  NOT NULL,
    version        INT  NOT NULL,
    fecha          DATE NOT NULL,
    CONSTRAINT fk_historial_instruccion
        FOREIGN KEY (instruccion_id) REFERENCES instrucciones (id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Datos de ejemplo: 8 instrucciones
-- ---------------------------------------------------------------------
INSERT INTO instrucciones (id, codigo, titulo, area, version, version_vigente, enlace_video, fecha_actualizacion) VALUES
    (1, 'IM-OFF-001', 'Preparación de máquina offset', 'Impresión Offset', 3, 3, 'https://intranet.ejemplo.com/videos/offset-preparacion', '2026-09-02'),
    (2, 'IM-OFF-002', 'Cambio de planchas', 'Impresión Offset', 2, 3, 'https://intranet.ejemplo.com/videos/cambio-planchas', '2026-07-15'),
    (3, 'IM-TIN-001', 'Preparación de tinta Pantone', 'Preparación de Tintas', 4, 4, NULL, '2026-09-10'),
    (4, 'IM-TRO-001', 'Ajuste de troquel', 'Troquelado', 1, 2, 'https://intranet.ejemplo.com/videos/ajuste-troquel', '2026-05-20'),
    (5, 'IM-ACA-001', 'Laminado brillante', 'Acabados', 2, 2, NULL, '2026-08-01'),
    (6, 'IM-ENC-001', 'Encuadernado hot melt', 'Encuadernación', 1, 3, 'https://intranet.ejemplo.com/videos/hot-melt', '2026-04-11'),
    (7, 'IM-MAN-001', 'Calibración de cortadora', 'Mantenimiento', 5, 5, NULL, '2026-09-25'),
    (8, 'IM-CAL-001', 'Inspección de calidad de impresión', 'Control de Calidad', 2, 2, 'https://intranet.ejemplo.com/videos/inspeccion-calidad', '2026-08-18');

-- ---------------------------------------------------------------------
-- Datos de ejemplo: 20 versiones (una fila por cada versión que ha tenido
-- cada instrucción; las fechas de versiones antiguas son de relleno)
-- ---------------------------------------------------------------------
INSERT INTO historial_versiones (instruccion_id, version, fecha) VALUES
    (1, 1, '2026-01-01'),
    (1, 2, '2026-02-01'),
    (1, 3, '2026-09-02'),
    (2, 1, '2026-01-01'),
    (2, 2, '2026-07-15'),
    (3, 1, '2026-01-01'),
    (3, 2, '2026-02-01'),
    (3, 3, '2026-03-01'),
    (3, 4, '2026-09-10'),
    (4, 1, '2026-05-20'),
    (5, 1, '2026-01-01'),
    (5, 2, '2026-08-01'),
    (6, 1, '2026-04-11'),
    (7, 1, '2026-01-01'),
    (7, 2, '2026-02-01'),
    (7, 3, '2026-03-01'),
    (7, 4, '2026-04-01'),
    (7, 5, '2026-09-25'),
    (8, 1, '2026-01-01'),
    (8, 2, '2026-08-18');
