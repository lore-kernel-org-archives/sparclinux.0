From: Bob Picco <bpicco@meloft.net>
Date: Wed, 01 Oct 2014 11:51:08 +0000
Subject: Re: [PATCH v2 0/8] sparc64: MM/IRQ patch queue.
Message-Id: <20141001115108.GC22365@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20140927.142812.2031647355756795530.davem@davemloft.net>
In-Reply-To: <20140927.142812.2031647355756795530.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
David Miller wrote:	[Tue Sep 30 2014, 10:29:00PM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Tue, 30 Sep 2014 18:28:41 -0400
> 
> > Okay, I lied partially. Let me examine this in the morning. You can
> > go first :)
> 
> Thanks :)  The boot mostly looks successful no?
You're welcome. Yes it does.
> 
> There are a couple blips, let's take a look:
> 
> > Performance events: No support for PMU type 'niagara5'
> 
> Hmmm, this was patched into an older tree I guess, as supported_pmu()
> accepts 'niagara5' as far as I can tell.  Oh I see, you patched
> against vanilla 3.17-rc7 instead of my 'sparc' GIT tree.
Yes.
> 
> > SELinux:  Registering netfilter hooks
> > Kernel unaligned access at TPC[675f74] sha256_transform+0x14/0x2840
> > Kernel unaligned access at TPC[675f88] sha256_transform+0x28/0x2840
> > Kernel unaligned access at TPC[675f88] sha256_transform+0x28/0x2840
> > Kernel unaligned access at TPC[675f88] sha256_transform+0x28/0x2840
> > Kernel unaligned access at TPC[675f88] sha256_transform+0x28/0x2840
> > alg: No test for stdrng (krng)
> 
> Interesting.  sha256_transform() depends upon the input data being
> at least 32-bit aligned.  Let's get a stack backtrace to see how
> this happens:
> 
> ==========
> diff --git a/arch/sparc/kernel/unaligned_64.c b/arch/sparc/kernel/unaligned_64.c
> index 62098a8..59ea98a 100644
> --- a/arch/sparc/kernel/unaligned_64.c
> +++ b/arch/sparc/kernel/unaligned_64.c
> @@ -299,6 +299,7 @@ static void log_unaligned(struct pt_regs *regs)
>  	if (__ratelimit(&ratelimit)) {
>  		printk("Kernel unaligned access at TPC[%lx] %pS\n",
>  		       regs->tpc, (void *) regs->tpc);
> +		dump_stack();
>  	}
>  }
>  
> ==========
> 
> > f0290d30: ttyS0 at I/O 0x0 (irq = 1, base_baud = 115200) is a SUN4V HCONS
> > NMI watchdog: BUG: soft lockup - CPU#527 stuck for 22s! [swapper/0:1]
> > Modules linked in:
> 
> I think this is triggered because in console_unlock() all buffered console
> output is emitted all at once.  And with all of those vmemmap log messages
> it gets huge.
Agree.
> 
> I guess this is another reason to trim down those messages, so I'll work
> on that now. :)
Thanx.
> 
> > aes_sparc64: Using sparc64 aes opcodes optimized AES implementation
> > alg: skcipher-ddst: Test 5 failed on encryption for ctr-aes-sparc64
> > 00000000: da 4e 3f bc e8 b6 3a a2 d5 4d 84 4a a9 0c e1 a5
> 
> Hmmm, interesting.  I just noticed that I haven't enabled the
> sparc64 crypto drivers in my current test .config, but I
> turned them on and I don't get this test failure.
> 
> I'll try to reproduce with the 'tcrypt' module or similar.
okay.
> 
> > sd 5:0:2:0: attempting task abort! scmd(fff8183f401d97a0)
> > sd 5:0:2:0: [sde] CDB: 
> > Read(10): 28 20 0a 20 2b 23 00 00 08 00
> > scsi target5:0:2: handle(0x000b), sas_address(0x5000cca016322f71), phy(2)
> > scsi target5:0:2: enclosure_logical_id(0x508002000159c0d1), slot(2)
> > sd 5:0:2:0: task abort: SUCCESS scmd(fff8183f401d97a0)
> 
> I get these every once in a while, the block I/O always recovers.
Me too. One exception being local T5-2 because of management dinosaur
deception.
> 
> I assume this booted all the way to a login prompt or similar?
Yes. I just cloned sparc.git during VPN and proxy quiet period.
I'll attempt to hang on to T5-8 until we conclude :)
> 
> Thanks!
you're welcome and thanx!
> 
