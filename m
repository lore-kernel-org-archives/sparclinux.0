From: David Miller <davem@davemloft.net>
Date: Mon, 11 Aug 2014 22:19:14 +0000
Subject: Re: [PATCH] Fix BREAK handling in sunsab serial driver
Message-Id: <20140811.151914.1301618786890179103.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201407271519.22272.cat.schulze@alice-dsl.net>
In-Reply-To: <201407271519.22272.cat.schulze@alice-dsl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
Date: Mon, 11 Aug 2014 19:49:48 +0200

> [  196.483877] Instruction DUMP: 953f6000  ba076001  9010000a <c2584000> 9fc04000  d477a7f7  d45fa7f7  96100008  92102000 
 ...
> and I am not able to provide any further details (e.g., disassembly of the code
> at that location).

The instruction dump is in the OOPS, as quoted above, and this disassembles
to:

   0:   95 3f 60 00     sra  %i5, 0, %o2
   4:   ba 07 60 01     inc  %i5
   8:   90 10 00 0a     mov  %o2, %o0

crash_pc:
   c:   c2 58 40 00     ldx  [ %g1 ], %g1
  10:   9f c0 40 00     call  %g1
  14:   d4 77 a7 f7     stx  %o2, [ %fp + 0x7f7 ]
  18:   d4 5f a7 f7     ldx  [ %fp + 0x7f7 ], %o2
  1c:   96 10 00 08     mov  %o0, %o3
  20:   92 10 20 00     clr  %o1

This is an indirect call, and the only indirect calls in perf_event_print_debug()
are the pcr_ops->() method invocations, that is what we are executing here, therefore
pcr_ops is NULL at this location.

It confirms my suspicions and I'll therefore work on a fix, thanks!
