program Dec5;
uses
  SysUtils;
const
    MaxSeeds = 25;

    MaxRawSeeds = 25;
    Phases = 7;
    MaxIntervals = 150;
procedure Part1;
var
    inputFile: TextFile;
    line: string;
    numstr: string;
    delimiterPos: integer;
    i, j, k: Int64;
    seeds: array[1..MaxSeeds] of Int64;
    seedCnt: integer;

    intervals: array[1..Phases] of array[1..MaxIntervals] of Int64;
    intervalCounts: array[1..Phases] of Int64;

    temp: Int64;
    destination: Int64;
    source: Int64;
    len: Int64;
    offset: Int64;
    min: Int64;
begin
    Assign(inputFile, '../inputs/dec5.input');
    Reset(inputFile);

    Readln(inputFile, line);
    line := Copy(line, 8, Length(Line));

    seedCnt := 1;

    j := 1;
    while Pos(' ', line) > 0 do begin
        delimiterPos := Pos(' ', line);
        numstr := Copy(line, 1, delimiterPos - 1);
        Inc(seedCnt);
        line := Copy(line, delimiterPos + 1, Length(Line));
        seeds[j] := StrToInt64(numstr);
        Inc(j);
    end;
    seeds[j] := StrToInt64(line);
    
    // Add intervals
    Readln(inputFile, line);
    for j := 1 to Phases do begin
        intervalCounts[j] := 0;
        Readln(inputFile, line);
        k := 1;
        while true do begin
            Readln(inputFile, line);
            if line = '' then break;
            delimiterPos := Pos(' ', line);
            numstr := Copy(line, 1, delimiterPos - 1);
            Inc(intervalCounts[j]);
            line := Copy(line, delimiterPos + 1, Length(Line));
            intervals[j][k] := StrToInt64(numstr);
            Inc(k);

            delimiterPos := Pos(' ', line);
            numstr := Copy(line, 1, delimiterPos - 1);
            Inc(intervalCounts[j]);
            line := Copy(line, delimiterPos + 1, Length(Line));
            intervals[j][k] := StrToInt64(numstr);
            Inc(k);

            Inc(intervalCounts[j]);
            intervals[j][k] := StrToInt64(line);
            Inc(k);
        end;
    end;

    // Calculate min
    destination := 0;
    source := 0;
    len := 0;
    offset := 0;
    min := High(Int64);
    for k := 1 to seedCnt do begin
        temp := seeds[k];
        for i := 1 to 7 do begin
            for j := 1 to intervalCounts[i] do begin
                destination := intervals[i][j];
                source := intervals[i][j+1];
                len := intervals[i][j+2];
                offset := destination - source;
                
                if ((temp >= source) and (temp < source + len)) then begin
                    temp := temp + offset;
                    break;
                end;

                // Hack to step by 3
                inc(PInteger(@j)^);
                inc(PInteger(@j)^);
            end;
        end;
        if temp < min then
            min := temp;
    end;

    writeln('Part 1: ', min);
end;

procedure Part2;
var
    inputFile: TextFile;
    line: string;
    numstr: string;
    delimiterPos: integer;
    i, j, k: Int64;
    rawSeeds: array[1..MaxRawSeeds] of Int64;
    seeds: array of Int64;
    seedCnt: Int64;
    rawSeedCnt: Int64;

    intervals: array[1..Phases] of array[1..MaxIntervals] of Int64;
    intervalCounts: array[1..Phases] of Int64;

    temp: Int64;
    destination: Int64;
    source: Int64;
    len: Int64;
    offset: Int64;
    min: Int64;
begin
    Assign(inputFile, '../inputs/dec5.input');
    Reset(inputFile);

    Readln(inputFile, line);
    line := Copy(line, 8, Length(Line));

    rawSeedCnt := 1;

    j := 1;
    while Pos(' ', line) > 0 do begin
        delimiterPos := Pos(' ', line);
        numstr := Copy(line, 1, delimiterPos - 1);
        Inc(rawSeedCnt);
        line := Copy(line, delimiterPos + 1, Length(Line));
        rawSeeds[j] := StrToInt64(numstr);
        Inc(j);
    end;
    rawSeeds[j] := StrToInt64(line);

    // Expand seed ranges
    SetLength(seeds, 1250000000);
    //SetLength(seeds, 1250);
    seedCnt := 1; // Init to 1 for indexing
    j := 1;
    while j < rawSeedCnt do begin
        for i := 0 to rawSeeds[j+1] do begin
            seeds[seedCnt] := rawSeeds[j] + i;
            Inc(seedCnt);
            //writeln(seedCnt);
        end;
        j := j + 2;
    end;
    Dec(seedCnt);

    writeln('Expanded');
    
    // Add intervals
    Readln(inputFile, line);
    for j := 1 to Phases do begin
        intervalCounts[j] := 0;
        Readln(inputFile, line);
        k := 1;
        while true do begin
            Readln(inputFile, line);
            if line = '' then break;
            delimiterPos := Pos(' ', line);
            numstr := Copy(line, 1, delimiterPos - 1);
            Inc(intervalCounts[j]);
            line := Copy(line, delimiterPos + 1, Length(Line));
            intervals[j][k] := StrToInt64(numstr);
            Inc(k);

            delimiterPos := Pos(' ', line);
            numstr := Copy(line, 1, delimiterPos - 1);
            Inc(intervalCounts[j]);
            line := Copy(line, delimiterPos + 1, Length(Line));
            intervals[j][k] := StrToInt64(numstr);
            Inc(k);

            Inc(intervalCounts[j]);
            intervals[j][k] := StrToInt64(line);
            Inc(k);
        end;
    end;

    // Calculate min
    destination := 0;
    source := 0;
    len := 0;
    offset := 0;
    min := High(Int64);
    for k := 1 to seedCnt do begin
        temp := seeds[k];
        for i := 1 to 7 do begin
            for j := 1 to intervalCounts[i] do begin
                destination := intervals[i][j];
                source := intervals[i][j+1];
                len := intervals[i][j+2];
                offset := destination - source;
                
                if ((temp >= source) and (temp < source + len)) then begin
                    temp := temp + offset;
                    break;
                end;

                // Hack to step by 3
                inc(PInteger(@j)^);
                inc(PInteger(@j)^);
            end;
        end;
        if temp < min then
            min := temp;
    end;

    writeln('Part 2: ', min);
end;

begin
    Part1;
    Part2;
end.//1246