program tp1;
type
    matriz = array[1..9,1..9] of integer;
    arreglo = array [1..81] of integer;
const
    filas = 9;
    columnas = 9;

procedure cargarTablero(tablero: matriz);
var
    i, j: integer;
begin
    for i:= 1 to filas do begin
        for j:= 1 to columnas do begin
            tablero[i,j]:= 0;
        end;
    end;
end;


procedure matrizACadena(matriz: matriz; cadena: arreglo);
var
    i,j,aux: integer;
begin
    aux:= 1;
    for i:= 1 to 9 do begin
        for j:= 1 to 9 do begin
            cadena[aux]:= matriz[i,j];
            aux:= aux + 1;
        end;
    end;
end;



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

function esPosValida(fila, columna, num: integer; tablero: matriz):boolean;
begin
    if(EsValidoFila(fila, columna, num, tablero) and EsValidoColumna(fila, columna, num, tablero) and esValidoCuadrante(fila, columna, num, tablero)) then
        esPosValida:= true
    else
    	esPosValida:= false;
end;

function resolverSudoku(tablero: matriz): boolean;
var
    fila,columna, numero: integer;
begin
    for fila:= 1 to 9 do begin
        for columna:= 1 to 9 do begin
            if(tablero[fila,columna] = 0) then begin
                for numero:= 1 to 9 do begin
                    if (esPosValida(fila, columna, numero, tablero)) then
                        tablero[fila,columna]:= numero;
                        if (resolverSudoku(tablero)) then
                            resolverSudoku:= true
                        else
                            tablero[fila,columna]:= 0;
                end;
                resolverSudoku:= false;
            end;
        end;
    resolverSudoku:= true;
    end;
end;


var
    plantilla: text;
    cadena: arreglo;
    sudoku: matriz;
    i, j, indice, aux, f, c, num: integer;

begin
    assign(plantilla, 'plantillaVacia.txt');
    Rewrite(plantilla);
    for i:= 1 to filas do begin
        for j:= 1 to columnas do begin
            sudoku[i,j]:= 0;
        end;
        writeln();
    end;
    for i:= 1 to 81 do begin
        cadena[i]:= 0;
    end;
    matrizACadena(sudoku,cadena);
    write(plantilla,cadena);
    append(plantilla);



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
    
    

    resolverSudoku(sudoku);

    for i:= 1 to filas do begin
        for j:= 1 to columnas do begin
            write(sudoku[i,j], ' ');
        end;
        writeln;
    end;
end.