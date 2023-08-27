program SudokuSolver;

const
  N = 9; // Tamaño del tablero de Sudoku

type
  SudokuBoard = array[1..N, 1..N] of Integer;

var
  board: SudokuBoard;

procedure PrintBoard(const board: SudokuBoard);
var
  i, j: Integer;
begin
  for i := 1 to N do
  begin
    for j := 1 to N do
      Write(board[i, j], ' ');
    Writeln;
  end;
end;

function IsValidMove(const num, row, col: Integer; const board: SudokuBoard): Boolean;
var
  i, j, startRow, startCol: Integer;
begin
  // Verificar en la misma fila y columna
  for i := 1 to N do
    if (board[row, i] = num) or (board[i, col] = num) then
      Exit(False);

  // Verificar en el mismo bloque 3x3
  startRow := 3 * ((row - 1) div 3) + 1;
  startCol := 3 * ((col - 1) div 3) + 1;
  for i := startRow to startRow + 2 do
    for j := startCol to startCol + 2 do
      if board[i, j] = num then
        Exit(False);

  Result := True;
end;

function SolveSudoku(var board: SudokuBoard): Boolean;
var
  row, col, num: Integer;
begin
  // Buscar una celda vacía
  row := 0;
  col := 0;
  for i := 1 to N do
  begin
    for j := 1 to N do
    begin
      if board[i, j] = 0 then
      begin
        row := i;
        col := j;
        Break;
      end;
    end;
    if row <> 0 then
      Break;
  end;

  // Si no hay celdas vacías, el sudoku está resuelto
  if row = 0 then
    Exit(True);

  // Intentar colocar números del 1 al 9 en la celda vacía
  for num := 1 to 9 do
  begin
    if IsValidMove(num, row, col, board) then
    begin
      board[row, col] := num;
      if SolveSudoku(board) then
        Exit(True);
      board[row, col] := 0; // Deshacer el intento si no lleva a una solución válida
    end;
  end;

  Result := False; // No se encontró ninguna solución válida
end;

begin
  // Inicializar el tablero (0 significa celda vacía)
  FillChar(board, SizeOf(board), 0);

  // Llenar el tablero con los números del Sudoku (0 para celdas vacías)
  // Aquí debes ingresar los números iniciales del Sudoku

  // Resolver el Sudoku
  if SolveSudoku(board) then
    PrintBoard(board)
  else
    Writeln('No se encontró solución.');

  Readln;
end.
