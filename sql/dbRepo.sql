-- LSST Data Management System
-- Copyright 2014-2015 AURA/LSST.
--
-- This product includes software developed by the
-- LSST Project (http://www.lsst.org/).
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the LSST License Statement and
-- the GNU General Public License along with this program.  If not,
-- see <https://www.lsstcorp.org/LegalNotices/>.
--
-- @brief LSST Database Schema for Metadata Store, database-repository related.
--
-- @author Jacek Becla, SLAC


CREATE TABLE DbMeta
    -- <descr>Information about one database. One row per database.
    -- There is one:one mapping between repo and database.</descr>
(
    dbMetaId INT,
        -- <descr>Unique identifier. Matches corresponding repoId from the Repo
        -- table.</descr>
        -- <ucd>meta.id</ucd>
    dbName VARCHAR(64),
        -- <descr>The name of the database. Note that a name must be unique
        -- across all levels (e.g. if we have "testX" db in "DR1", we can't
        -- have any other "testX" db in DR2 or L3 etc.)</descr>
    connHost VARCHAR(64),
        -- <descr>Connection information: host.</descr>
    connPort INT,
        -- <descr>Connection information: port.</descr>
    PRIMARY KEY DbMeta_dbMetaId(dbMetaId),
    UNIQUE IDX_DbMeta_dbName(dbName)
) ENGINE=InnoDB;


CREATE TABLE DbMetaAnnotations
    -- <descr>Annotations for entries in DbMeta, in key-value form.-- </descr>
(
    dbMetaId INT NOT NULL,
        -- <descr>References entry in DbMeta table.</descr>
    userId INT NOT NULL,
        -- <descr>User who entered given annotation. References entry in
        -- User table.</descr>
    theKey VARCHAR(64) NOT NULL,
    theValue TEXT NOT NULL,
    INDEX IDX_DbMetaAnnotations_dbMetaId(dbMetaId),
    INDEX IDX_DbMetaAnnotations_userId(userId)
) ENGINE = InnoDB;


CREATE TABLE DDT_Table
    -- <descr>A Data Definition Table. Augments standard MySQL-managed metadata.
    -- This is for table-level metadata.</descr>
(
    tableId INT NOT NULL AUTO_INCREMENT,
        -- <descr>Unique identifier.</descr>
        -- <ucd>meta.id</ucd>
    dbMetaId INT NOT NULL,
        -- <descr>References entry in DbMeta - database where this table
        -- belongs.</descr>
    tableName VARCHAR(64),
        -- <descr>The name of the table.</descr>
    descr TEXT,
        -- <descr>Table description.</descr>
    PRIMARY KEY DDT_Table(tableId)
) ENGINE=InnoDB;


CREATE TABLE DDT_Column
    -- <descr>A Data Definition Table. Augments standard MySQL-managed metadata.
    -- This is for column-level metadata.</descr>
(
    columnId INT NOT NULL AUTO_INCREMENT,
        -- <descr>Unique identifier.</descr>
        -- <ucd>meta.id</ucd>
    columnName VARCHAR(64),
        -- <descr>The name of the column.</descr>
    tableId INT NOT NULL,
        -- <descr>References entry in DDT_Table - table where this column
        -- belongs.</descr>
    descr TEXT,
        -- <descr>Column description.</descr>
    ucd VARCHAR(1024),
        -- <descr> UCD definitions for a given column. Based on:
        -- http://www.ivoa.net/Documents/cover/UCDlist-20070402.html.</descr>
    units VARCHAR(64),
        -- <descr>Description of units for a given column.</descr>
    SUI_displayPrec INT,
        -- <descr>Display precision, for SUI.</descr>
    SUI_displayCol BOOL DEFAULT True,
        -- <descr>A flag whether to display this column or not by default.</descr>
    PRIMARY KEY DDT_Column(columnId)
) ENGINE=InnoDB;
