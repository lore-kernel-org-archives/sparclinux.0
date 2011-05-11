From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 11 May 2011 12:53:40 +0000
Subject: Re: [PATCH]SPARC32: Fixed unaligned memory copying in function __csum_partial_copy_sparc_generic
Message-Id: <4DCA86D4.7020506@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1304845558.9492.14.camel@big>
In-Reply-To: <1304845558.9492.14.camel@big>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Tkhai Kirill wrote:

>When we are in the label cc_dword_align, registers %o0 and %o1 have the same last 2 bits,
>but it's not guaranteed one of they is zero. So we can get unaligned memory access
>in label ccte. Example of parameters which lead to this:
>%o0=0x7ff183e9, %o1=0x8e709e7d, %g1=3
>  
>
I just wanted to add that I also got unaligned accesses in the checksum 
calculation on the SPARC32/LEON. Bad alignment is bad for performance of 
course, in my case the MNA-trap handler was erroneous storing 
incorrectly and that was the reason for me to notice it. I did not look 
at the reason for the unaligned access in the first place though.

Daniel


commit 2492218c63dca0fb4f041bdc366d243ae3426b40
Author: Daniel Hellstrom <daniel@gaisler.com>
Date:   Tue Feb 1 12:39:59 2011 -0800

    sparc32: unaligned memory access (MNA) trap handler bug

    Since commit f0e98c387e61de00646be31fab4c2fa0224e1efb ("[SPARC]: Fix
    link errors with gcc-4.3") the MNA trap handler does not emulate
    stores to unaligned addresses correctly. MNA operation from both
    kernel and user space are affected.

    A typical effect of this bug is nr_frags in skbs are overwritten
    during buffer copying/checksum-calculation, or maximally 6 bytes
    of data in the network buffer will be overwitten with garbage.

    Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

