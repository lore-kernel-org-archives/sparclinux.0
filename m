From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Wed, 31 Mar 2004 16:10:06 +0000
Subject: Re: 2.6.5rc2 panics on ss5/110
Message-Id: <20040331161006.GA13251@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1080616798.16068.37.camel@zorak>
In-Reply-To: <1080616798.16068.37.camel@zorak>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Mar 29, 2004 at 09:19:59PM -0600, Tom 'spot' Callaway wrote:

> PC: <vsnprintf+0x4f0/0x604>
...
> Instruction DUMP: 9210001b  40000ea0  9007bff0 <d41a0000> 1080002b
> b606e008  12800008  8219605a  c206c000

This works out to:

   0:   92 10 00 1b     mov  %i3, %o1
   4:   40 00 0e a0     call  0x3a84
   8:   90 07 bf f0     add  %fp, -16, %o0
   c:   d4 1a 00 00     ldd  [ %o0 ], %o2 	<<<=  10:   10 80 00 2b     b  0xbc
  14:   b6 06 e0 08     add  %i3, 8, %i3
  18:   12 80 00 08     bne  0x38
  1c:   82 19 60 5a     xor  %g5, 0x5a, %g1
  20:   c2 06 c0 00     ld  [ %i3 ], %g1

So it's sane (o0 is NULL).  However, I can't reproduce this with your
config and stock gcc 3.3.3, nor does my vsnprintf contain any code
sequence that looks anything like this.

Please send me your kernel off-list, and indicate here exactly what
compiler you're using.  The call from scsi is a little odd in that a
64-bit value is split between o5 and the stack; I'm having some
compiler doubts.

-- 
Keith M Wesolowski
