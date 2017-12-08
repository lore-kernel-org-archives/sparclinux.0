From: David Miller <davem@davemloft.net>
Date: Fri, 08 Dec 2017 18:13:02 +0000
Subject: Re: [PATCH] sparc64: Set possible and present masks based on nr_cpu_ids
Message-Id: <20171208.131302.1913995769989137756.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1506630439-192139-1-git-send-email-atish.patra@oracle.com>
In-Reply-To: <1506630439-192139-1-git-send-email-atish.patra@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Atish Patra <atish.patra@oracle.com>
Date: Tue, 5 Dec 2017 19:41:47 -0600

> I am looking at a spinlock bad magic issue in timer code on a legacy
> sparc machine.
> 
> 0eeda71b (timer: Replace timer base by a cpu index)
> As per my understanding, the above patch assumes there is always a cpu
> 0 and that timer to CPU0 should be assigned statically to avoid
> boot_tvec_base logic.
> DEFINE_TIMER macro seems to initialize the flags to 0 and the commit
> text also points to that.
> Please let me know if I missed something.
> 
> We observed the spinlock bad magic with legacy sun4u machines which
> have sparse numbered cpus and does not have cpu0.
> We may be wrong but our investigation pointed out that per-cpu
> timer_base structure for cpu 0 is not initialized leading invalid
> magic value. console_timer seems to be statically assigned to cpu0 in
> this case.

Yeah, you can't really assume that cpu 0 is the boot cpu let alone
even exists.  And it is clear that the timer code now has such a
dependency.

Thomas, you'll probably have to do something like have a fixup early
in the boot process which fixes up the flags field of all of the
statically defined timer objects so that it contains the cpu that
is running the early bootup process.
