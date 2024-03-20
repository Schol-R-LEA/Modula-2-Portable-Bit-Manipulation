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
FROM CardBitOps IMPORT bit, SetBit, ClearBit,
                       shl, shr, ashr, rotl, rotr,
                       bwNot, bwAnd, bwOr, bwXor;

VAR
   a, b, c, d, e, f: CARDINAL;

BEGIN
   a := 0;
   b := 6;
   c := 0FFFFFFFFH;
   d := 170;         (* 10101010 *)
   e := 85;          (* 01010101 *)
   f := 0DEADBEEFH;


   WriteString("a = ");
   WriteCard(a, 1);
   WriteString(", NOT a = ");
   WriteCard(bwNot(a), 1);
   WriteString(", bit 3 is ");
   IF bit(a, 3) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteString(", bit 2 is ");
   IF bit(a, 2) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteLn;

   WriteString("b = ");
   WriteCard(b, 1);
   WriteString(", NOT b = ");
   WriteCard(bwNot(b), 1);
   WriteString(", bit 3 is ");
   IF bit(b, 3) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteString(", bit 2 is ");
   IF bit(b, 2) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteLn;

   WriteString("c = ");
   WriteCard(c, 1);
   WriteString(", NOT c = ");
   WriteCard(bwNot(c), 1);
   WriteString(", bit 3 is ");
   IF bit(c, 3) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteString(", bit 2 is ");
   IF bit(c, 2) THEN
      WriteString("set");
   ELSE
      WriteString("clear");
   END;
   WriteLn;

   WriteCard(b, 1);
   WriteString(" shifted left by 1 is ");
   WriteCard(Shl(b, 1), 1);
   WriteLn;
   WriteCard(b, 1);
   WriteString(" shifted right by 1 is ");
   WriteCard(Shr(b, 1), 1);
   WriteLn;
   WriteCard(c, 1);
   WriteString(" shifted right by 2 is ");
   WriteCard(Shr(c, 2), 1);
   WriteLn;

   WriteCard(d, 1);
   WriteString(" shifted right by 1 is ");
   WriteCard(Shr(d, 1), 1);
   WriteLn;

   WriteCard(e, 1);
   WriteString(" shifted left by 1 is ");
   WriteCard(Shl(e, 1), 1);
   WriteLn;

   WriteCard(f, 2);
   WriteString(" shifted left by 2 is ");
   WriteCard(Shl(f, 2), 1);
   WriteLn;

   WriteCard(f, 2);
   WriteString(" shifted right by 2 is ");
   WriteCard(Shr(f, 2), 1);
   WriteLn;

   WriteCard(d, 1);
   WriteString(" shifted left by 4 is ");
   WriteCard(Shl(d, 4), 1);
   WriteLn;
   WriteCard(e, 1);
   WriteString(" shifted left by 5 is ");
   WriteCard(Shl(e, 5), 1);
   WriteLn;

   WriteInt(n, 1);
   WriteString(" shifted right by 1 is ");
   WriteInt(ashr(n, 1), 1);
   WriteLn;

   WriteInt(m, 1);
   WriteString(" shifted right by 1 is ");
   WriteInt(ashr(m, 1), 1);
   WriteLn;


   WriteCard(ROTR(ROTL(b, 1), 1), 1);
   WriteString(" rotated left by 1 is ");
   WriteCard(ROTL(b, 1), 1);
   WriteLn;
   WriteCard(ROTR(ROTL(b, 1), 1), 1);
   WriteString(" rotated right by 1 is ");
   WriteCard(ROTR(b, 1), 1);
   WriteLn;

   WriteCard(ROTR(ROTL(c, 1), 1), 1);
   WriteString(" rotated right by 2 is ");
   WriteCard(ROTR(c, 2), 1);
   WriteLn;

   WriteCard(ROTR(ROTL(d, 1), 1), 1);
   WriteString(" rotated left by 1 is ");
   WriteCard(ROTL(d, 1), 1);
   WriteLn;
   WriteCard(ROTR(ROTL(d, 1), 1), 1);
   WriteString(" rotated right by 1 is ");
   WriteCard(ROTR(d, 1), 1);
   WriteLn;

   WriteCard(ROTR(ROTL(e, 1), 1), 1);
   WriteString(" rotated left by 1 is ");
   WriteCard(ROTL(e, 1), 1);
   WriteLn;
   WriteCard(ROTR(ROTL(e, 1), 1), 1);
   WriteString(" rotated right by 1 is ");
   WriteCard(ROTR(e, 1), 1);
   WriteLn;

   WriteCard(ROTR(ROTL(d, 1), 1), 1);
   WriteString(" rotated left by 4 is ");
   WriteCard(ROTL(d, 4), 1);
   WriteLn;
   WriteCard(ROTR(ROTL(e, 1), 1), 1);
   WriteString(" rotated left by 5 is ");
   WriteCard(ROTL(e, 5), 1);
   WriteLn;


   WriteCard(d, 1);
   WriteString(" AND ");
   WriteCard(e, 1);
   WriteString(" is ");
   WriteCard(bwAnd(d, e), 1);
   WriteLn;
   WriteCard(d, 1);
   WriteString(" OR ");
   WriteCard(e, 1);
   WriteString(" is ");
   WriteCard(bwOr(d, e), 1);
   WriteLn;
   WriteCard(d, 1);
   WriteString(" XOR ");
   WriteCard(e, 1);
   WriteString(" is ");
   WriteCard(bwXor(d, e), 1);
   WriteLn;

   WriteCard(d, 1);
   WriteString(" XOR ");
   WriteCard(e, 1);
   WriteString(" shifted left 1 is ");
   WriteCard(bwXor(d, SHL(e, 1)), 1);
   WriteLn;


END BitwiseTests.