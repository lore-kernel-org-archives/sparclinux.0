From: David Miller <davem@davemloft.net>
Date: Wed, 24 Jan 2007 05:25:03 +0000
Subject: Re: kernel BUG at arch/sparc64/mm/fault.c:413!
Message-Id: <20070123.212503.55506485.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0701181328230.8124@pianoman.cluster.toy>
In-Reply-To: <Pine.LNX.4.64.0701181328230.8124@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Vince Weaver <vince@deater.net>
Date: Thu, 18 Jan 2007 13:33:15 -0500 (EST)

> 
> I am running Linux 2.6.20-rc5 on an UltraSparc T1 (Niagara) with 24 
> threads.
> 
> When trying to compile gcc-4.2-20070117 gcc snapshot from scratch, the 
> following BUG() happens:

What distribution and version are you running?  I tried to dump
the code at address 0x1a368 of the /bin/sh binary running on
Ubuntu Dapper and it didn't show a code location which could
trigger this code path.

> The relevant code is:
> 
> 409        /* If we took a ITLB miss on a non-executable page, catch
> 410         * that here.
> 411         */
> 412        if ((fault_code & FAULT_CODE_ITLB) && !(vma->vm_flags & VM_EXEC)) {
> 413                BUG_ON(address != regs->tpc);
> 414                BUG_ON(regs->tstate & TSTATE_PRIV);
> 415                goto bad_area;
> 416        }
> 
> What's the next step in tracking down what's going on?

Try to print out the "fault_code", "address", and regs->tpc value
when this triggers.

I think the thread struct is being corrupted by some parallel access
and this corrupts the fault state, in particular "fault_code" is
garbage.

But I can only confirm that theory with the information I've
requested above.

