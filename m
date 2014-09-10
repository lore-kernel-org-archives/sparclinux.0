From: Bob Picco <bpicco@meloft.net>
Date: Wed, 10 Sep 2014 19:34:26 +0000
Subject: Re: [PATCH] sparc64: mem mmap
Message-Id: <20140910193426.GH17331@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410104925-22342-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410104925-22342-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Wed Sep 10 2014, 02:50:34PM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Wed, 10 Sep 2014 10:30:10 -0400
> 
> > In a common part for DTLB/ITLB "BAD RA" check TSTATE_PRIV. Should we not
> > be privileged raise a bus error with SIGBUS and BUS_ADRERR for the task.
> 
> The kernel could be accessing userspace via copy_from_user() or one of
> the other asm/uaccess.h accessors.
True and thanx for catching my brain slippage!
> 
> So you'll need the full context of the fault to make this decision, just
> like do_sparc64_fault() does.
Yes.
> 
> Actually, kernel TLB misses go via separate path and validate the RA
> already before trying to load the entry into the TLB.  So you will
> contextually know if we are dealing with a user mapping or not.
> 
> You could add a new thread fault code (FAULT_CODE_BAD_RA) to set in
> this situation and then vector to do_sparc64_fault() when this
> happens.
> 
> Probably do_sparc64_fault() should just immediately do a
> do_fault_siginfo().  Suggested logic is:
> 
> 	if (!down_read_trylock(&mm->mmap_sem)) {
>  ...
> 		down_read(&mm->mmap_sem);
> 	}
> 
> 	if (fault_code & FAULT_CODE_BAD_RA)
> 		goto do_sigbus;
> 
> 	vma = find_vma(mm, address);
> 
> I would not try to do anything clever like seeing if this is a
> non-faulting load or anything like that.
Okay let me look at this.

thanx again,

bob
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
