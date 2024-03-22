(* Copyright (C) 2024 Alice Osako *)
(* Portions Copyright (c) 2020 Modula-2 Software Foundation. *)
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


IMPLEMENTATION MODULE CardBitOps; (* portable *)
(* Bit Operations on Type CARDINAL *)

(* ---------------------------------------------------------------------------
 * function shl( n, shiftFactor )
 * ---------------------------------------------------------------------------
 * Returns n shifted left by shiftFactor.
 *
 *             M S B                                           L S B
 *            +-----+-----+-----+           +-----+-----+-----+-----+
 *  bit index | n-1 | n-2 | n-3 |   . . .   |  3  |  2  |  1  |  0  |  before
 *            +-----+-----+-----+           +-----+-----+-----+-----+
 *                   /     /                       /     /     /
 *                  /     /                       /     /     /
 *                 /     /                       /     /     /     0
 *                /     /                       /     /     /     /
 *            +-----+-----+-----+           +-----+-----+-----+-----+
 *  bit index | n-1 | n-2 | n-3 |   . . .   |  3  |  2  |  1  |  0  |  after
 *            +-----+-----+-----+           +-----+-----+-----+-----+
 * ------------------------------------------------------------------------ *)

PROCEDURE shl ( n : CARDINAL; shiftFactor : BitIndex ) : CARDINAL;

VAR
  carryBits : CARDINAL;
  pivotalBit : BitIndex;

BEGIN
  IF n = 0 THEN
    (* NOP *)

  ELSIF shiftFactor = 0 THEN
    (* NOP *)

  (* shifting by 1 .. Bitwidth-1 *)
  ELSIF shiftFactor < Bitwidth THEN

    (* bit at position BitMax - shiftFactor is pivotal *)
    pivotalBit := BitMax - shiftFactor;

    (* compute bits that will be shifted out of n *)
    carryBits := n DIV powerOf2[pivotalBit];

    (* clear bits that will be shifted out to avoid overflow *)
    ClearMSBtoN(n, pivotalBit+1);

    (* shift safely *)
    n := n * powerOf2[shiftFactor]

  (* shifting by BitMax *)
  ELSE (* shiftFactor = BitMax *)
    n := 0
  END; (* IF *)
  
  RETURN n
END shl;


(* ---------------------------------------------------------------------------
 * function shr( n, shiftFactor )
 * ---------------------------------------------------------------------------
 * Returns n logically shifted right by shiftFactor.
 *
 *             M S B                                           L S B
 *            +-----+-----+-----+           +-----+-----+-----+-----+
 *  bit index | n-1 | n-2 | n-3 |   . . .   |  3  |  2  |  1  |  0  |  before
 *            +-----+-----+-----+           +-----+-----+-----+-----+
 *                 \     \                       \     \     \
 *                  \     \                       \     \     \
 *             0     \     \                       \     \     \
 *              \     \     \                       \     \     \
 *            +-----+-----+-----+           +-----+-----+-----+-----+
 *  bit index | n-1 | n-2 | n-3 |   . . .   |  3  |  2  |  1  |  0  |  after
 *            +-----+-----+-----+           +-----+-----+-----+-----+
 * ------------------------------------------------------------------------ *)

PROCEDURE shr ( n : CARDINAL; shiftFactor : BitIndex ) : CARDINAL;

VAR
  pivotalBit : BitIndex;

BEGIN
  IF n = 0 THEN
    (* NOP *)

  ELSIF shiftFactor = 0 THEN
    (* NOP *)

  (* shifting by 1 .. Bitwidth-1 *)
  ELSIF shiftFactor < Bitwidth THEN
    (* bit at position shiftFactor is pivotal *)
    pivotalBit := shiftFactor;

    (* shift *)
    n := n DIV powerOf2[pivotalBit]

  (* shifting by BitMax *)
  ELSE (* shiftFactor = BitMax *)
    n := 0
  END; (* IF *)

  RETURN n
END shr;


(* ---------------------------------------------------------------------------
 * function ashr( n, shiftFactor )
 * ---------------------------------------------------------------------------
 * Returns n arithmetically shifted right by shiftFactor.
 *
 *             M S B                                           L S B
 *            +-----+-----+-----+           +-----+-----+-----+-----+
 *  bit index | n-1 | n-2 | n-3 |   . . .   |  3  |  2  |  1  |  0  |  before
 *            +-----+-----+-----+           +-----+-----+-----+-----+
 *               | \     \                       \     \     \
 *               |  \     \                       \     \     \
 *               |   \     \                       \     \     \
 *               |    \     \                       \     \     \
 *            +-----+-----+-----+           +-----+-----+-----+-----+
 *  bit index | n-1 | n-2 | n-3 |   . . .   |  3  |  2  |  1  |  0  |  after
 *            +-----+-----+-----+           +-----+-----+-----+-----+
 * ------------------------------------------------------------------------ *)

PROCEDURE ashr ( n : CARDINAL; shiftFactor : BitIndex ) : CARDINAL;

VAR
  pivotalBit : BitIndex;
  mask : CARDINAL;

BEGIN
  IF n = 0 THEN
    (* NOP *)

  ELSIF shiftFactor = 0 THEN
    (* NOP *)

  ELSIF n = MAX(CARDINAL) THEN
    (* NOP *)

  (* shifting by 1 .. BitMax-1 *)
  ELSIF shiftFactor < BitMax THEN
    (* bit at position shiftFactor is pivotal *)
    pivotalBit := Bitwidth - shiftFactor;

    IF NOT bit(n, BitMax) THEN
      (* shift *)
      n := n DIV powerOf2[shiftFactor]

    ELSE (* high bit set *)

      (* shift *)
      n := n DIV powerOf2[shiftFactor];

      (* compute mask to set high bits *)
      mask := MAX(CARDINAL) DIV powerOf2[pivotalBit];
      mask := mask * powerOf2[pivotalBit];

      (* add mask to n, thereby setting high bits *)
      n := n + mask
    END (* IF *)

  (* shifting by BitMax *)
  ELSE (* shiftFactor = BitMax *)
    IF bit(n, BitMax) THEN
      n := MAX(CARDINAL)
    ELSE
      n := 0
    END;
  END; (* IF *)
  
  RETURN n
END ashr;


(* ---------------------------------------------------------------------------
 * procedure shlc( n, carryBits, shiftFactor )
 * ---------------------------------------------------------------------------
 * Left shifts n by bitIndex and passes the shifted out bits in carryBits.
 * ------------------------------------------------------------------------ *)

PROCEDURE shlc ( VAR n, carryBits : CARDINAL; shiftFactor : BitIndex );

VAR
  pivotalBit : BitIndex;

BEGIN
  (* shifting by 0 *)
  IF shiftFactor = 0 THEN
    carryBits := 0
    
  (* shifting by 1 .. BitMax-1 *)
  ELSIF shiftFactor < BitMax THEN
    (* bit at position BitMax - shiftFactor is pivotal *)
    pivotalBit := BitMax - shiftFactor;
    
    (* compute bits that will be shifted out of n *)
    carryBits := n DIV powerOf2[pivotalBit];

    (* clear bits that will be shifted out to avoid overflow *)
    ClearMSBtoN(n, pivotalBit);
    
    (* shift safely *)
    n := n * powerOf2[shiftFactor]
    
  (* shifting by BitMax *)
  ELSE (* shiftFactor = BitMax *)
    carryBits := n; n := 0
  END (* IF *)
END shlc;


(* ---------------------------------------------------------------------------
 * function rotl( n, shiftFactor )
 * ---------------------------------------------------------------------------
 * Returns n rotated left by shiftFactor.
 * ------------------------------------------------------------------------ *)

PROCEDURE rotl ( n : CARDINAL; shiftFactor : BitIndex ) : CARDINAL;

VAR
  upper, lower: CARDINAL;

BEGIN
  upper := shl(n, shiftFactor);
  lower := shr(n, Bitwidth - shiftFactor);
  RETURN upper + lower;
END rotl;


(* ---------------------------------------------------------------------------
 * function rotr( n, shiftFactor )
 * ---------------------------------------------------------------------------
 * Returns n logically rotated right by shiftFactor.
 * ------------------------------------------------------------------------ *)

PROCEDURE rotr ( n : CARDINAL; shiftFactor : BitIndex ) : CARDINAL;

VAR
  upper, lower: CARDINAL;

BEGIN
  upper := shr(n, shiftFactor);
  lower := shl(n, Bitwidth - shiftFactor);
  RETURN upper + lower;
END rotr;



(* ---------------------------------------------------------------------------
 * function bit( n, bitIndex )
 * ---------------------------------------------------------------------------
 * Returns TRUE if the bit at bitIndex of n is set, otherwise FALSE.
 * ------------------------------------------------------------------------ *)

PROCEDURE bit ( n : CARDINAL; bitIndex : BitIndex ) : BOOLEAN;

BEGIN
  RETURN ODD(n DIV powerOf2[bitIndex])
END bit;


(* ---------------------------------------------------------------------------
 * procedure SetBit( n, bitIndex )
 * ---------------------------------------------------------------------------
 * Sets the bit at bitIndex of n.
 * ------------------------------------------------------------------------ *)

PROCEDURE SetBit ( VAR n : CARDINAL; bitIndex : BitIndex );

BEGIN
  IF NOT bit(n, bitIndex) THEN
    n := n + powerOf2[bitIndex]
  END (* IF *)
END SetBit;


(* ---------------------------------------------------------------------------
 * procedure ClearBit( n, bitIndex )
 * ---------------------------------------------------------------------------
 * Clears the bit at bitIndex of n.
 * ------------------------------------------------------------------------ *)

PROCEDURE ClearBit ( VAR n : CARDINAL; bitIndex : BitIndex );

BEGIN
  IF bit(n, bitIndex) THEN
    n := n - powerOf2[bitIndex]
  END (* IF *)
END ClearBit;

(* ---------------------------------------------------------------------------
 * procedure ToggleBit( n, bitIndex )
 * ---------------------------------------------------------------------------
 * Sets the bit at bitIndex of n if it is clear, otherwise clears it.
 * ------------------------------------------------------------------------ *)
(*
PROCEDURE ToggleBit ( VAR n : CARDINAL; bitIndex : BitIndex );

BEGIN
  IF bit(n, bitIndex) THEN
    n := n - powerOf2[bitIndex]
  ELSE
    n := n + powerOf2[bitIndex]
  END
END ToggleBit;
*)

(* ---------------------------------------------------------------------------
 * procedure ClearLSBtoN( n, bitIndex )
 * ---------------------------------------------------------------------------
 * Clears the bits of n in range [0 .. bitIndex].
 * ------------------------------------------------------------------------ *)

PROCEDURE ClearLSBtoN ( VAR n : CARDINAL; bitIndex : BitIndex );

BEGIN
  (* clearing to MSB produces all zeroes *)
  IF bitIndex = BitMax-1 THEN
    n := 0;
    RETURN
  END; (* IF *)

  (* shift right and back to clear the low bits *)
  n := n DIV powerOf2[bitIndex+1];
  n := n * powerOf2[bitIndex+1]
END ClearLSBtoN;


(* ---------------------------------------------------------------------------
 * procedure ClearMSBtoN( n, bitIndex )
 * ---------------------------------------------------------------------------
 * Clears the bits of n in range [bitIndex .. BitMax-1].
 * ------------------------------------------------------------------------ *)

PROCEDURE ClearMSBtoN ( VAR n : CARDINAL; bitIndex : BitIndex );

VAR
  mask : CARDINAL;

BEGIN
  (* clearing from bit 0 produces all zeroes *)
  IF bitIndex = 0 THEN
    n := 0;
    RETURN
  END; (* IF *)

  (* shift lower bits out to the right *)
  mask := n DIV powerOf2[bitIndex];

  (* shift them back, thereby clearing the low bits, obtaining a mask *)
  mask := mask * powerOf2[bitIndex];

  (* subtract the mask, thereby clearing the high bits *)
  n := n - mask
END ClearMSBtoN;


(* ---------------------------------------------------------------------------
 * procedure bwNot( n )
 * ---------------------------------------------------------------------------
 * Invert the bits of n.
 * ------------------------------------------------------------------------ *)

PROCEDURE bwNot (n: CARDINAL): CARDINAL;
VAR
  i, target: CARDINAL;

BEGIN
  IF n = 0 THEN
    RETURN n;
  ELSE
    FOR i := 0 TO BitMax-1 DO
      IF bit(n, i) THEN
        ClearBit(target, i);
      ELSE
        SetBit(target, i);
      END;
    END;
    RETURN target;
  END;
END bwNot;


(* ---------------------------------------------------------------------------
 * procedure bwAnd( n , m )
 * ---------------------------------------------------------------------------
 * Get the bitwise AND of n and m.
 * ------------------------------------------------------------------------ *)

PROCEDURE bwAnd (n : CARDINAL; m : CARDINAL): CARDINAL;
VAR
  i, target: CARDINAL;

BEGIN
  IF (n = 0) OR (m = 0) THEN
    RETURN 0;
  ELSE
    FOR i := 0 TO BitMax-1 DO
      IF bit(n, i) AND bit(m, i) THEN
        SetBit(target, i);
      ELSE
        ClearBit(target, i);
      END;
    END;
    RETURN target;
  END;
END bwAnd;


(* ---------------------------------------------------------------------------
 * procedure bwOr( n , m )
 * ---------------------------------------------------------------------------
 * Get the bitwise OR of n and m.
 * ------------------------------------------------------------------------ *)


PROCEDURE bwOr (n : CARDINAL; m : CARDINAL): CARDINAL;
VAR
  i, target: CARDINAL;

BEGIN
  IF (n = 0) AND (m = 0) THEN
    RETURN 0;
  ELSIF n = 0 THEN
    RETURN m;
  ELSIF m = 0 THEN
    RETURN n;
  ELSE
    FOR i := 0 TO BitMax-1 DO
      IF bit(n, i) OR bit(m, i) THEN
        SetBit(target, i);
      ELSE
        ClearBit(target, i);
      END;
    END;
    RETURN target;
  END;
END bwOr;


(* ---------------------------------------------------------------------------
 * procedure bwXor( n , m )
 * ---------------------------------------------------------------------------
 * Get the bitwise XOR of n and m.
 * ------------------------------------------------------------------------ *)


PROCEDURE bwXor (n : CARDINAL; m : CARDINAL): CARDINAL;
VAR
  i, target: CARDINAL;

BEGIN
  IF ((n = 0) AND (m = 0)) OR (n = m) THEN
    RETURN 0;
  ELSIF n = 0 THEN
    RETURN m;
  ELSIF m = 0 THEN
    RETURN n;
  ELSE
    FOR i := 0 TO BitMax-1 DO
      IF (bit(n, i) OR bit(m, i)) AND NOT (bit(n, i) AND bit(m, i)) THEN
        SetBit(target, i);
      ELSE
        ClearBit(target, i);
      END;
    END;
    RETURN target;
  END;
END bwXor;




(* ---------------------------------------------------------------------------
 * Powers of 2 table
 * ------------------------------------------------------------------------ *)

VAR
  powerOf2 : ARRAY [0..MAX(BitIndex)] OF CARDINAL;

(* ---------------------------------------------------------------------------
 * private procedure InitPow2Table
 * ---------------------------------------------------------------------------
 * Initialises the powers of 2 table
 * ------------------------------------------------------------------------ *)

PROCEDURE InitPow2Table;

VAR
  index : BitIndex;

BEGIN
  powerOf2[0] := 1;

  FOR index := 1 TO MAX(BitIndex) DO
    powerOf2[index] := powerOf2[index-1] * 2;
  END; (* FOR *)
END InitPow2Table;


(* ---------------------------------------------------------------------------
 * Module Initialisation
 * ------------------------------------------------------------------------ *)

BEGIN (* CardBitOps *)
  InitPow2Table
END CardBitOps.