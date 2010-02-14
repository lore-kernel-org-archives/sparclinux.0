From: David Miller <davem@davemloft.net>
Date: Sun, 14 Feb 2010 23:54:54 +0000
Subject: Re: soft lookup
Message-Id: <20100214.155454.58421488.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100213170856.GA8334@pcpool00.mathematik.uni-freiburg.de>
In-Reply-To: <20100213170856.GA8334@pcpool00.mathematik.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Bernhard R. Link" <brlink@debian.org>
Date: Sun, 14 Feb 2010 21:49:31 +0100

> As I said, my sparc assembler knowledge is almost not existing,
> so excuses in advance for messing everything up.
> 
> I'm assuming objdump -d on the unpacked vmlinuz gives me correct
> addresses. That means it is here (the sparc64_realfault_common):
> 
>   407a94:       10 6f f3 2b     b  %xcc, 404740
>   407a98:       8f 41 40 00     rd  %pc, %g7
>   407a9c:       e8 29 a0 08     stb  %l4, [ %g6 + 8 ]     <-TPC
>   407aa0:       ea 71 a0 20     stx  %l5, [ %g6 + 0x20 ]  <-TNPC
>   407aa4:       40 01 09 1e     call  449f1c              <-ret_pc
>   407aa8:       90 03 a8 bf     add  %sp, 0x8bf, %o0
>   407aac:       10 6f f4 35     b  %xcc, 404b80
>   407ab0:       01 00 00 00     nop
> 
> That seems very strange in my eyes. The odd sp value does not make my
> confusion smaller.

%g6 holds the current thread pointer.

The stack pointer is always odd on sparc64.  The value stored
in the %sp register is "biased" by 2047 bytes from the real
base of the current stack frame.  It's done this way to allow
more of the stack variables to be accessible with a 13-bit
signed offset from the frame pointer %fp since that can be
done in one load or store instruction.
