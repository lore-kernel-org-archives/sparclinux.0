From: David Miller <davem@davemloft.net>
Date: Sat, 18 Oct 2014 17:59:07 +0000
Subject: Re: unaligned accesses in SLAB etc.
Message-Id: <20141018.135907.356113264227709132.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20141016.162001.599580415052560455.davem@redhat.com>
	<20141016.165017.1151349565275102498.davem@davemloft.net>
	<alpine.LRH.2.11.1410171410210.25429@adalberg.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1410171410210.25429@adalberg.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org, cl@linux.com, penberg@kernel.org, rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Fri, 17 Oct 2014 14:12:09 +0300 (EEST)

> However, on top of mainline HEAD 3.17.0-09670-g0429fbc it explodes with 
> scheduler BUG - just reported to LKML + sched maintainers.

task_stack_end_corrupted() cannot work properly on sparc64.

It stores the magic value at "task_thread_info(p) + 1", but on
sparc64 that's where we store the nested array of FPU register
saves.

In fact this facility could be corrupting FPU register state in
certain circumstances.

The current sparc64 design is intentional, the CPU stack grows down
toward the thread_info, and the FPU stack saving area grows up from
the end of thread_info.

I don't want to define the array size of the fpregs save area
explicitly and thereby placing an artificial limit there.
