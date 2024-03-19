(* Copyright (C) 2024 Alice Osako *)
(*
Modula-2 Portable Bit Manipulation API is free software; you can
redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3, or (at your option)
any later version.

Modula-2 Portable Bit Manipulation API is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for more details.

You should have received a copy of the GNU General Public License along
with this package; see the file COPYING.  If not, write to the Free Software
Foundation, 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA. *)


MODULE BitwiseTests;

FROM STextIO IMPORT WriteString, WriteLn;
FROM SWholeIO IMPORT WriteCard;
FROM Bitwise IMPORT BIT, SETBIT, BWNOT, SHL, SHR;

VAR
   a, b, c: CARDINAL;

BEGIN
   a := 0;
   b := 6;
   c  := 0FFFFFFFFH;

   WriteString("a = ");
   WriteCard(a, 1);
   WriteString(", NOT a = ");
   WriteCard(BWNOT(a), 1);
   WriteString(", bit 3 is ");
   IF BIT(a, 3) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteString(", bit 2 is ");
   IF BIT(a, 2) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteLn;

   WriteString("b = ");
   WriteCard(b, 1);
   WriteString(", NOT b = ");
   WriteCard(BWNOT(b), 1);
   WriteString(", bit 3 is ");
   IF BIT(b, 3) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteString(", bit 2 is ");
   IF BIT(b, 2) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteLn;

   WriteString("c = ");
   WriteCard(c, 1);
   WriteString(", NOT c = ");
   WriteCard(BWNOT(c), 1);
   WriteString(", bit 3 is ");
   IF BIT(c, 3) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteString(", bit 2 is ");
   IF BIT(c, 2) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteLn;

   WriteCard(SHR(SHL(b, 1), 1), 1);
   WriteString(" shifted left by 1 is ");
   WriteCard(SHL(b, 1), 1);
   WriteLn;
   WriteCard(c, 1);
   WriteString(" shifted right by 2 is ");
   WriteCard(SHR(c, 2), 1);
   WriteLn;
END BitwiseTests.