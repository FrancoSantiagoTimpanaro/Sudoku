program creadorDeSudoku;
uses
    SysUtils;
type
    // matriz = array [1..9,1..9] of integer;
const
    filas = 9;
    columnas = 9;

procedure vaciarCasilleros(var tablero: matriz);
var
    fila, cant0, col0: integer;
begin
    fila:= 1;
    while (fila <> 9) do begin //evaluo la fila
        cant0:= random(5) + 1; //Asigno la cantidad de 0 que van ir a la fila
        if (cant0 <= 2) then   //Asigno la cantidad de 0 que van ir a la fila
            cant0:= cant0 + 2; //Asigno la cantidad de 0 que van ir a la fila
        while (cant0 <> 0) do begin //Evalua que no haya concluido la cantidad de 0 de la fila
            col0:= random(8) + 1;
            if (col0 >= fila) then
                if (col0 <> 0) then
                    tablero[fila,col0]:= 0
                else
                    col0:= random(8) + 1;

            cant0:= cant0 - 1;
        end;
        fila:= fila + 1;
    end;
end;



var
    plantillaResultante, sudokuResuelto: text;
    cadena, cadenaResuelta: string;
    sudoku: matriz;
    i, j, indice, aux: integer;

begin
    assign(plantillaResultante, 'plantillaResultante.txt'); //Asignamos la variable al archivo
    assign(sudokuResuelto, 'resuelto.txt');
    Reset(plantillaResultante); //Verificamos que el archivo se puede utilizar
    Reset(sudokuResuelto);
    rewrite(plantillaResultante);//Se incializa para poder escribir en un archivo de tipo txt
    readln(sudokuResuelto, cadena);
    write(plantillaResultante, cadena);
    // writeln(cadena);

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
    
    vaciarCasilleros(sudoku);
    for i:= 1 to filas do begin
        for j:= 1 to columnas do begin
            write(sudoku[i,j], ' ');
        end;
        write();
    end;

    rewrite(plantillaResultante);//Se incializa para poder escribir en un archivo de tipo txt
    cadenaResuelta:= '';
    for i := 1 to 9 do begin
        for j := 1 to 9 do begin// Convertir el elemento de la matriz a cadena y concatenarlo
            cadenaResuelta := cadenaResuelta + IntToStr(sudoku[i, j]);
        end;
    end;
    writeln(plantillaResultante, cadenaResuelta);
    close(plantillaResultante);//Cerramos el archivo
    close(sudokuResuelto);
end.