-- DEF
CREATE PROCEDURE DiskussionGesichtet
	@ID int
AS
	-- inkrementiert AnzahlSichtungen um 1
    UPDATE Diskussionen SET AnzahlSichtungen = AnzahlSichtungen + 1
    WHERE ID = @ID
GO



-- Beispiel
EXECUTE DiskussionGesichtet 3;
GO
