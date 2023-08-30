program tp1;
type
    matriz = array[1..9,1..9] of integer;
const
    filas = 9;
    columnas = 9;
function esValidoFila (fila,columna,num: integer; tablero: matriz ):boolean; 
begin
    EsValidoFila:=true;
    for columna:=1 to 9 do begin
		if (tablero[fila, columna] = num) then
    		EsValidoFila:=false;
	end;
end;

Function esValidoColumna(fila, columna, num: integer; tablero: matriz): boolean;
begin
    EsValidoColumna:=true;
    for fila:=1 to 9 do begin
        if (tablero[fila,columna]=num) then
    	    EsvalidoColumna:=false;
    end;
end;

function esValidoCuadrante(fila, columna, num: integer; tablero: matriz): boolean;
var
    posFila, posColumna, i, j: integer;
begin
    esValidoCuadrante:= true;
    posFila:= 3 * ((fila -1) div 3) + 1; //Esta parte calcula en qué grupo de tres filas se encuentra la fila dada. Multiplicamos el grupo de tres filas por 3 para obtener la primera fila de la subcuadrícula en la que se encuentra la celda. 
    posColumna:= 3 * ((Columna -1) div 3) + 1;
    for i:=posFila to posFila+2 do begin
        for j:=posColumna to posColumna+2 do begin
            if(tablero[i,j]= num) then
                esValidoCuadrante:= false;
        end;
    end;
    writeln('Se evalua la fila', posFila, ' y la columna', posColumna);
end;

procedure esValidoFC(fila, columna, num: integer; tablero: matriz);
begin
    if(EsValidoFila(fila, columna, num, tablero) and EsValidoColumna(fila, columna, num, tablero)) then
        writeln('El numero es valido')
    else
    	writeln('El numero no es valido');
end;

var
    plantilla: text;
    cadena: string;
    sudoku: matriz;
    i, j, indice, aux, f, c, num: integer;

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
            write(sudoku[i,j], ' ');
        end;
        writeln;
    end;

    f:= 6;
    c:= 8;
    num:= 4;

    if (esValidoCuadrante(f,c,num,sudoku)) then
        writeln('El numero es valido')
    else
        writeln('El numero no es validoo');
end.