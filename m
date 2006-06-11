From: Ludovic =?iso-8859-1?Q?Court=E8s?= <ludo@chbouib.org>
Date: Sun, 11 Jun 2006 20:12:51 +0000
Subject: Re: [PATCH 0/4] sparc32: smp fixes
Message-Id: <20060611201233.GA2339@cassis>
List-Id: <sparclinux.vger.kernel.org>
References: <448BB4E4.4060408@mc.net>
In-Reply-To: <448BB4E4.4060408@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Today, 12 hours, 39 minutes, 42 seconds ago, Bob Breuer wrote:
> Here's a set of patches to get sparc32 caught back up to the moving SMP
> target:
>  1 - add topology_init
>  2 - setup cpu_possible_map
>  3 - add missing rw can_lock macros
>  4 - mark smp init functions as cpuinit
> 
> I have tested these successfully with 2.6.17-rc5.

Your patches apply correctly to rc6 as well.

However, when trying to compile natively rc6 with your patches, with
either GCC 4.1.1 or 4.0.4 (from Debian unstable), I get an ICE:

  CC      kernel/sched.o
  kernel/sched.c: In function 'effective_prio':
  kernel/sched.c:659: internal compiler error: in choose_multiplier, at expmed.c:3269

What compiler and what platform do you use to compile the kernel?
Has anyone experienced similar problems?

Thanks,
Ludovic.

