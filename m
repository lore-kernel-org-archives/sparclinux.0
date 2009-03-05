From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Thu, 05 Mar 2009 15:39:18 +0000
Subject: Re: Sunfire V880 and 480R 2.6.27.x startup hangs
Message-Id: <20090305153918.GC16069@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Mar 05, 2009 at 12:04:17AM -0800, David Miller wrote:
> 
> So kernel_thread() is where it hangs...
> 
> The only big thing changing in sparc64 between 2.6.26.5 (which works)
> and 2.6.27 are IRQ stacks.
> 
> Here is a test patch which reverts sparc64 IRQ stacks.  If this makes
> your machine work it will be a big clue.

Applied your patch to 2.6.27.19 - hangs at the same point. Output
is on the web.

> (BTW, why do you get "OpenBoot Diagnostics failed" from the firmware
>  on reset/poweron?)

One disk fails diagnostics (see below), but works later without a problem.
From time to time I check the same on the 480R with has error at 
the OBP diagnostic, so that does to matter IMHO. The 480R is the
one with the cassini driver crashing the machine, so tests are a little
bit more clumsy. 

Btw.: I upgraded the 480R to debian lenny and compiled a 2.6.27.x kernel
- hangs the same point.

Thanks for looking again,

  Hermann 

------------------------------------
Testing /pci@8,600000/SUNW,qlc@2

   ERROR   : Disk 0  is not spinning.
   DEVICE  : /pci@8,600000/SUNW,qlc@2
   SUBTEST : selftest:loop-tests:inquiry-test:disk-test
   CALLERS : disk-test
   MACHINE : Sun Fire 880
   SERIAL# : 50911524
   DATE    : 03/05/2009 15:17:50  GMT
   CONTR0LS: diag-level=max test-args
-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
