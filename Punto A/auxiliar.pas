program auxiliar;
const
    filas = 9;
    columnas = 9;
var
    plantilla: text;
    cadena: string;
    sudoku: array [1..9,1..9] of integer;
    i, j, indice, aux: integer;
begin
    assign(plantilla, 'sudoku.txt');
    Reset(plantilla);
    readln(plantilla, cadena);
    close(plantilla);

    // Verificar si el string tiene la cantidad de caracteres esperados
    if Length(cadena) <> filas * columnas then
    begin
        Writeln('El string no tiene la longitud requerida para un sudoku');
        Exit;
    end;
    indice:= 1;
    for i:= 1 to filas do begin
        for j:= 1 to columnas do begin
            aux:=Ord(cadena[indice]); //Convierte el char a codigo Ascii
            sudoku[i,j]:= aux - 48; //-48 porque los num en codigo Ascii empiezan en 48
            indice:= indice + 1;
        end;
    end;

    for i:= 1 to filas do begin
        for j:= 1 to columnas do begin
            write(sudoku[i,j]);
        end;
        writeln;
    end;


end.