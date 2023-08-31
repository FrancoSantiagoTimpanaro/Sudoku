program GeneradorSudoku;

const
    maxSize = 9; //Tamaño del tablero de Sudoku
    casilleroVacio = 0;

var
    sudoku: array[1..maxSize, 1..maxSize] of Integer;

procedure inicializarTablero;
var
    i, j: Integer;
begin
    for i := 1 to maxSize do
    for j := 1 to maxSize do
        sudoku[i, j] := casilleroVacio;
end;

procedure imprimirTablero;
var
    i, j: Integer;
begin
    for i := 1 to maxSize do
    begin
        for j := 1 to maxSize do
        begin
            if sudoku[i, j] = casilleroVacio then
            Write('. ')
        else
            Write(sudoku[i, j], ' ');
    end;
    Writeln;
    end;
end;

function esNumValido(row, col, num: Integer): Boolean;
var
    i, j: Integer;
begin
  // Verificar en la fila y columna
    for i := 1 to maxSize do
    if (sudoku[row, i] = num) or (sudoku[i, col] = num) then
        Exit(False);

  // Verificar en el cuadrante 3x3
  for i := (row - 1) div 3 * 3 + 1 to (row - 1) div 3 * 3 + 3 do
    for j := (col - 1) div 3 * 3 + 1 to (col - 1) div 3 * 3 + 3 do
        if sudoku[i, j] = num then
        Exit(False);

    esNumValido:= True;
end;

procedure cargarTableroResuelto(row, col: Integer);
var
    num: Integer;
begin
    if row > maxSize then
    begin
    imprimirTablero;
    Halt; // Terminar el programa después de imprimir el tablero
    end
    else if sudoku[row, col] = casilleroVacio then
    begin
    for num := 1 to maxSize do
    begin
        if esNumValido(row, col, num) then
        begin
        sudoku[row, col] := num;
        if col < maxSize then
            cargarTableroResuelto(row, col + 1)
        else
            cargarTableroResuelto(row + 1, 1);
        sudoku[row, col] := casilleroVacio; // Backtracking
        end;
    end;
    end
    else
    begin
    if col < maxSize then
        cargarTableroResuelto(row, col + 1)
    else
        cargarTableroResuelto(row + 1, 1);
    end;
end;

var
    plantilla: text;
    cadena: string;
begin
    assign(plantilla, 'plantillaVacia.txt');
    Rewrite(plantilla);
    inicializarTablero;
    cargarTableroResuelto(1,1);
end.