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


IMPLEMENTATION MODULE CardBitOps; 
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
  target: CARDINAL;

BEGIN
  target := n;
  ASM VOLATILE ("mov %1, %%cl; shl %%cl, %0"
                : "=rm" (target)
                : "rm" (shiftFactor)
                : "cl");

  RETURN target
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
  target: CARDINAL;

BEGIN
  target := n;
  ASM VOLATILE ("mov %1, %%cl; shr %%cl, %0"
                : "=rm" (target)
                : "rm" (shiftFactor)
                : "cl");

  RETURN target
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
  target: CARDINAL;

BEGIN
  target := n;
  ASM VOLATILE ("mov %1, %%cl; sar %%cl, %0"
                : "=rm" (target)
                : "rm" (shiftFactor)
                : "cl");

  RETURN target
END ashr;


(* ---------------------------------------------------------------------------
 * procedure shlc( n, carryBits, shiftFactor )
 * ---------------------------------------------------------------------------
 * Left shifts n by bitIndex and passes the shifted out bits in carryBits.
 * ------------------------------------------------------------------------ *)

PROCEDURE shlc ( VAR n, carryBits : CARDINAL; shiftFactor : BitIndex );
VAR
  highBits: BitIndex;

BEGIN
  IF n = 0 THEN
    carryBits := 0;
  ELSIF shiftFactor = 0 THEN
    carryBits := 0;
  ELSE
    highBits := Bitwidth - shiftFactor;

    carryBits := shr(n, highBits);
    n := shl(n, shiftFactor);
  END;
END shlc;


(* ---------------------------------------------------------------------------
 * function rotl( n, shiftFactor )
 * ---------------------------------------------------------------------------
 * Returns n rotated left by shiftFactor.
 * ------------------------------------------------------------------------ *)

PROCEDURE rotl ( n : CARDINAL; shiftFactor : BitIndex ) : CARDINAL;
VAR
  target: CARDINAL;

BEGIN
  target := n;
  ASM VOLATILE ("mov %1, %%cl; rol %%cl, %0"
                : "=rm" (target)
                : "rm" (shiftFactor)
                : "cl");

  RETURN target
END rotl;


(* ---------------------------------------------------------------------------
 * function rotr( n, shiftFactor )
 * ---------------------------------------------------------------------------
 * Returns n logically rotated right by shiftFactor.
 * ------------------------------------------------------------------------ *)

PROCEDURE rotr ( n : CARDINAL; shiftFactor : BitIndex ) : CARDINAL;
VAR
  target: CARDINAL;

BEGIN
  target := n;
  ASM VOLATILE ("mov %1, %%cl; ror %%cl, %0"
                : "=rm" (target)
                : "rm" (shiftFactor)
                : "cl");

  RETURN target
END rotr;



(* ---------------------------------------------------------------------------
 * function bit( n, bitIndex )
 * ---------------------------------------------------------------------------
 * Returns TRUE if the bit at bitIndex of n is set, otherwise FALSE.
 * ------------------------------------------------------------------------ *)

PROCEDURE bit ( n : CARDINAL; bitIndex : BitIndex ) : BOOLEAN;
BEGIN
  IF bwAnd(n, shl (1, bitIndex)) # 0 THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END;
END bit;


(* ---------------------------------------------------------------------------
 * procedure SetBit( n, bitIndex )
 * ---------------------------------------------------------------------------
 * Sets the bit at bitIndex of n.
 * ------------------------------------------------------------------------ *)

PROCEDURE SetBit ( VAR n : CARDINAL; bitIndex : BitIndex );

BEGIN
  ASM VOLATILE ("mov %0, %%rax; mov %1, %%rcx; bts %%rcx, %%rax; mov %%rax, %0"
                : "=rm" (n)
                :  "rm" (bitIndex)
                : "rax", "rcx");
END SetBit;


(* ---------------------------------------------------------------------------
 * procedure ClearBit( n, bitIndex )
 * ---------------------------------------------------------------------------
 * Clears the bit at bitIndex of n.
 * ------------------------------------------------------------------------ *)

PROCEDURE ClearBit ( VAR n : CARDINAL; bitIndex : BitIndex );
BEGIN
  ASM VOLATILE ("mov %0, %%rax; mov %1, %%rcx; btr %%rcx, %%rax; mov %%rax, %0"
                : "=rm" (n)
                : "rm" (bitIndex)
                : "rax", "rcx");
END ClearBit;

(* ---------------------------------------------------------------------------
 * procedure ToggleBit( n, bitIndex )
 * ---------------------------------------------------------------------------
 * Sets the bit at bitIndex of n if it is clear, otherwise clears it.
 * ------------------------------------------------------------------------ *)

PROCEDURE ToggleBit ( VAR n : CARDINAL; bitIndex : BitIndex );

BEGIN
  ASM VOLATILE ("mov %0, %%rax; mov %1, %%rcx; btc %%rcx, %%rax; mov %%rax, %0"
                : "=rm" (n)
                : "rm" (bitIndex)
                : "rcx");
END ToggleBit;


(* ---------------------------------------------------------------------------
 * procedure ClearLSBtoN( n, bitIndex )
 * ---------------------------------------------------------------------------
 * Clears the bits of n in range [0 .. bitIndex].
 * ------------------------------------------------------------------------ *)

PROCEDURE ClearLSBtoN ( VAR n : CARDINAL; bitIndex : BitIndex );

BEGIN
  

END ClearLSBtoN;


(* ---------------------------------------------------------------------------
 * procedure ClearMSBtoN( n, bitIndex )
 * ---------------------------------------------------------------------------
 * Clears the bits of n in range [bitIndex .. BitMax-1].
 * ------------------------------------------------------------------------ *)

PROCEDURE ClearMSBtoN ( VAR n : CARDINAL; bitIndex : BitIndex );

END ClearMSBtoN;


(* ---------------------------------------------------------------------------
 * procedure bwNot( n )
 * ---------------------------------------------------------------------------
 * Invert the bits of n.
 * ------------------------------------------------------------------------ *)

PROCEDURE bwNot (n: CARDINAL): CARDINAL;
VAR
  target: CARDINAL;

BEGIN
  target := n;
  ASM VOLATILE ("not %0"
                : "=rm" (target));
  RETURN target;
END bwNot;


(* ---------------------------------------------------------------------------
 * procedure bwAnd( n , m )
 * ---------------------------------------------------------------------------
 * Get the bitwise AND of n and m.
 * ------------------------------------------------------------------------ *)

PROCEDURE bwAnd (n : CARDINAL; m : CARDINAL): CARDINAL;
VAR
  target: CARDINAL;

BEGIN
  target := n;
  ASM VOLATILE ("and %1, %0"
                : "=rm" (target)
                : "rm" (m)
                : );
  RETURN target;
END bwAnd;


(* ---------------------------------------------------------------------------
 * procedure bwOr( n , m )
 * ---------------------------------------------------------------------------
 * Get the bitwise OR of n and m.
 * ------------------------------------------------------------------------ *)


PROCEDURE bwOr (n : CARDINAL; m : CARDINAL): CARDINAL;
VAR
  target: CARDINAL;

BEGIN
  target := n;
  ASM VOLATILE ("or %1, %0"
                : "=rm" (target)
                : "rm" (m)
                : );
  RETURN target;
END bwOr;


(* ---------------------------------------------------------------------------
 * procedure bwXor( n , m )
 * ---------------------------------------------------------------------------
 * Get the bitwise XOR of n and m.
 * ------------------------------------------------------------------------ *)


PROCEDURE bwXor (n : CARDINAL; m : CARDINAL): CARDINAL;
VAR
  target: CARDINAL;

BEGIN
  target := n;
  ASM VOLATILE ("xor %1, %0"
                : "=rm" (target)
                : "rm" (m));
  RETURN target;
END bwXor;


END CardBitOps.