program Dec6;
uses
  SysUtils;
procedure Part1;
var
    inputFile: TextFile;
    line: string;
    numstr: string;
    delimiterPos: integer;
    times: array[1..4] of Int64;
    distances: array[1..4] of Int64;
    raceCnt: integer = 1;
    i: integer;
    product: Int64 = 1;
    time, dist, wins, holdTime, sailTime, distance: Int64;
begin
    Assign(inputFile, '../inputs/dec6.input');
    Reset(inputFile);

    // Read times
    Readln(inputFile, line);
    line := Trim(Copy(line, 10, Length(Line)));
    while Pos(' ', line) > 0 do begin
        delimiterPos := Pos(' ', line);
        numstr := Copy(line, 1, delimiterPos - 1);
        line := Trim(Copy(line, delimiterPos + 1, Length(Line)));
        times[raceCnt] := StrToInt64(numstr);
        Inc(raceCnt);
    end;
    times[raceCnt] := StrToInt64(line);

    // Read distances
    Readln(inputFile, line);
    line := Trim(Copy(line, 10, Length(Line)));
    for i := 1 to raceCnt-1 do begin
        delimiterPos := Pos(' ', line);
        numstr := Copy(line, 1, delimiterPos - 1);
        line := Trim(Copy(line, delimiterPos + 1, Length(Line)));
        distances[i] := StrToInt64(numstr);
    end;
    distances[raceCnt] := StrToInt64(line);

    // Calculate product
    for i := 1 to raceCnt do begin
        time := times[i];
        dist := distances[i];
        wins := 0;
        for holdTime := 1 to time do begin
            sailTime := time - holdTime;
            distance := sailTime * holdTime;
            if distance > dist then
                wins := wins + 1
        end;

        if wins > 0 then
            product := product * wins
    end;

    writeln('Part 1: ', product);
end;

procedure Part2;
var
    inputFile: TextFile;
    line: string;
    numstr: string = '';
    temp: string = '';
    delimiterPos: integer;
    time, dist, wins, holdTime, sailTime, distance: Int64;
begin
    Assign(inputFile, '../inputs/dec6.input');
    Reset(inputFile);

    // Read times
    Readln(inputFile, line);
    line := Trim(Copy(line, 10, Length(Line)));
    while Pos(' ', line) > 0 do begin
        delimiterPos := Pos(' ', line);
        temp := Copy(line, 1, delimiterPos - 1);
        line := Trim(Copy(line, delimiterPos + 1, Length(Line)));
        numstr := numstr + temp;
    end;
    numstr := numstr + line;
    time := StrToInt64(numstr);

    // Read distances
    Readln(inputFile, line);
    line := Trim(Copy(line, 10, Length(Line)));
    numstr := '';
    while Pos(' ', line) > 0 do begin
        delimiterPos := Pos(' ', line);
        temp := Copy(line, 1, delimiterPos - 1);
        line := Trim(Copy(line, delimiterPos + 1, Length(Line)));
        numstr := numstr + temp;
    end;
    numstr := numstr + line;
    dist := StrToInt64(numstr);

    // Calculate wins
    wins := 0;
    for holdTime := 1 to time do begin
        sailTime := time - holdTime;
        distance := sailTime * holdTime;
        if distance > dist then
            wins := wins + 1
    end;

    writeln('Part 2: ', wins);
end;

begin
    Part1;
    Part2;
end.