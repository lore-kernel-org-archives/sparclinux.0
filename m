From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Mon, 28 Feb 2005 22:47:52 +0000
Subject: Re: oops
Message-Id: <1109630872.30346.16.camel@duncow>
List-Id: <sparclinux.vger.kernel.org>
References: <DA6197CAE190A847B662079EF7631C0656FC67@OEKAW2EXVS03.hbi.ad.harman.com>
In-Reply-To: <DA6197CAE190A847B662079EF7631C0656FC67@OEKAW2EXVS03.hbi.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I'm not sure on what is causing it but looking at the Ooops it seems
like there is some form of memory/register corruption.

Feb 28 08:17:54 oekalux08 kernel: CPU[1]: local_irq_count[0]
irqs_running[0]
Feb 28 08:17:54 oekalux08 kernel: TSTATE: 0000000011f09605 TPC:
000000000044fba8 TNPC: 000000000044fbac Y: 01800000    Tainted: P

The offending instruction is

Code;  000000000044fba8 <remove_wait_queue+8/60>
   c:   ce 6a 00 00       ldstub  [ %o0 ], %g7

and %o0 contains o0: 50535943484f2050  which looks suspiciously like
ASCII ("PSYCHO P"). So it looks like PCI and the Psycho device is
somehow implicated.

Richard


On Mon, 2005-02-28 at 09:04 +0100, Jurzitza, Dieter wrote:
> Dear listmembers,
> any ideas, comments on this? The only thing I actually did was running xosview from *userland* and I can crash my system within a very short time.
> U60@360 MHz, SMP, Kernel 2.4.29-SMP.
> Thanks for any efforts in advance,
> take care
> 
> 
> 
> 
> Dieter Jurzitza
> 
> 
-- 
Richard Mortimer <richm@oldelvet.org.uk>

