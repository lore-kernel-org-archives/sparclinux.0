From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 15 Feb 2005 17:40:57 +0000
Subject: Re: FPU context switching fix for SMP
Message-Id: <20050215094057.04da9ef2.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <41f753cabb795@wp.pl>
In-Reply-To: <41f753cabb795@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 26 Jan 2005 09:24:42 +0100
"Krzysztof Helt" <krzysztof.h1@wp.pl> wrote:

> Here is a patch for FPU context switching in SMP.
> 
> A copy_thread() function clears PF_USEDFPU flag for a new thread,
> but it does not clear the PSR_EF bit. Thus, a first FPU exception
> called from the child thread is not handled properly. I made the
> patch after PPC and MIPS architectures - both clear a similar bit
> in copy_thread.
> This bug does not exist in the UP kernel, probably because it
> does not rely on PF_USEDFPU flag.
> 
> The patch below should be applied for both 2.4 and 2.6 branches.

I've modified your patch to only do this in the SMP case.

Here is how the two mechanisms work:

UP:
	last_task_used_math keeps trash of the last thread to
	use the FPU.  As we context switch, we clear PSR_EF in
	the %psr register.  If we take a FPU disabled trap:
	1) if this is last_task_used_math, simply re-enable FPU
	2) else, save FPU state to last_task_used_math, restore
	   FPU state of current thread, and update last_task_used_math
	   value
	When we exec() or exit() and last_task_used_math is the
	current thread, we reset it to NULL.

SMP:
	last_task_used_math is not used at all.
	Instead, a state bit assosciated with each thread keeps
	track of whether that thread used the FPU or not.
	At schedule() time, if set we clear the bit and save
	the FPU state of that task and clear PSR_EF.
	At FPU disabled trap time, we set the state bit
	and load the FPU state for the process.

The SMP case works in that each thread, when scheduled(), has
it's PSR_EF flag cleared.

This fork() bug takes away that invariant, which is why the
problems arose.

Thanks a lot Krzysztof.
