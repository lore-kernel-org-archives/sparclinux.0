From: Ludovic =?iso-8859-1?Q?Court=E8s?= <ludo@chbouib.org>
Date: Sat, 08 Apr 2006 14:24:28 +0000
Subject: Re: Building a small sparc32 kernel
Message-Id: <20060408142423.GA2630@cassis>
List-Id: <sparclinux.vger.kernel.org>
References: <20060404151927.GC2358@cassis>
In-Reply-To: <20060404151927.GC2358@cassis>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

2 days, 21 hours, 9 minutes, 50 seconds ago, 
Bob Breuer wrote:
> 2.6.11?  You shouldn't need to go back that far.  The patch in the
> message you referenced was for 2.6.14, and also works for 2.6.15.  As
> long as you don't enable spinlock debugging, you will never get the lock
> errors.

Right.  I really meant 2.6.14.

> It's nearly a requirement for the kernel to be stripped before silo will
> load it.  Try using "strip arch/sparc/boot/image -o /boot/vmlinux" to
> copy and strip the kernel in one step.

Oh yes, I had skipped this step.

So, I now have a 2.6.14 SMP kernel I can boot from.  On my SS20, it
doesn't even get to the point of spawning `init'.  I get a number of the
following messages at boot time:

  esp0: Resetting scsi bus
  esp0: SCSI bus reset interrupt
  esp0: DMA error a4400302

And finally, I get spinlock debugging messages followed by a stack trace
telling that something went wrong ("BUG: spinlock lockup on CPU#2",
etc.), and nothing more.  I guess I'm going to have to capture the
console output via a serial line in order to provide you with meaningful
data.

The machine has two SuperSPARC 390Z50.  In your original message you
mentioned that support for SuperSPARC II was relatively stable, so maybe
this just means that support for this older SuperSPARC flavor is not yet
in such a good shape?  ;-)

Let me know how I can help with this.

Thanks,
Ludovic.

