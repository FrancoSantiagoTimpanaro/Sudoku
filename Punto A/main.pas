program tp1;
type
    matriz = array [1..9,1..9] of integer;

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
    sudoku: matriz;
    f,c, num: integer;

begin
    for f:= 1 to 9 do begin
        for c:= 1 to 9 do begin
            sudoku[f,c]:= 0;
        end;
    end;
    sudoku[1,1]:= 1;
    sudoku[1,5]:= 8;
    sudoku[1,9]:= 9;
    sudoku[2,2]:= 5;
    sudoku[2,4]:= 6;
    sudoku[2,6]:= 1;
    sudoku[2,8]:= 2;
    sudoku[3,4]:= 5;
    sudoku[3,6]:= 3;
    sudoku[4,2]:= 9;
    sudoku[4,3]:= 6;
    sudoku[4,4]:= 1;
    sudoku[4,6]:= 4;
    sudoku[4,7]:= 8;
    sudoku[4,8]:= 3;
    sudoku[5,1]:= 3;
    sudoku[5,5]:= 6;
    sudoku[5,9]:= 5;
    sudoku[6,2]:= 1;
    sudoku[6,3]:= 5;
    sudoku[6,4]:= 9;
    sudoku[6,6]:= 8;
    sudoku[6,7]:= 4;
    sudoku[6,8]:= 6;
    sudoku[7,4]:= 7;
    sudoku[7,6]:= 5;
    sudoku[8,2]:= 8;
    sudoku[8,4]:= 3;
    sudoku[8,6]:= 9;
    sudoku[8,8]:= 7;
    sudoku[9,1]:= 5;
    sudoku[9,5]:= 1;
    sudoku[9,9]:= 3;

    for f:= 1 to 9 do begin
        for c:= 1 to 9 do begin
            write(sudoku[f,c], ' ');
        end;
        writeln();
    end;
    f:= 6;
    c:= 8;
    num:= 4;
    if (esValidoCuadrante(f,c,num,sudoku)) then
        writeln('El numero es valido')
    else
        writeln('El numero no es validoo');
end.