From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 24 Nov 2016 22:04:57 +0000
Subject: Re: SILO Issues on an E4900
Message-Id: <c2bf1974-0c77-fbb9-3a94-d2e48cccecd5@ilande.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <62477e32a682342782e652fcfdbf9fb5@triadic.us>
In-Reply-To: <62477e32a682342782e652fcfdbf9fb5@triadic.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 24/11/16 21:26, vincent@cojot.name wrote:

> A while back I stumbled onto an old post talking about the 'Illegal
> instruction' issue with SILO on serengeti machines:
> 
> http://helenos-blog.pavel-rimsky.cz/?p=3
> 
> Any thoughts?
> 
> Note that I have not personally verified that it works or not (I sold my
> US-IIICu sb2k some time ago already...)
> 
> My 2c,
> 
> Vincent

FWIW we have a similar hack in OpenBIOS for a.out binaries which rears
its head when trying to boot NextSTEP in QEMU:
https://github.com/openbios/openbios/blob/master/libopenbios/aout_load.c.
For a.out binaries we relocate the binary back down over its header
after load so we can execute directly at 0x4000 (load-base).

This was modelled after observing similar code in the official Sun
OpenBOOT implementation of init-program which can be found here:
https://github.com/openbios/openboot/blob/master/obp/arch/sun4u/go.fth.

Probably the first thing to check is that the a.out magic is being
generated correctly in SILO to match the above code in order to trigger
the relocation, which in itself is likely a hold-over from the very
early days of OpenBOOT.


ATB,

Mark.

