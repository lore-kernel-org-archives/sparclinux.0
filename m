From: David Miller <davem@davemloft.net>
Date: Fri, 20 Jun 2008 03:35:12 +0000
Subject: Re: Userspace process crashes with PREEMPT
Message-Id: <20080619.203512.123527176.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0805311050430.24707@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0805311050430.24707@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Date: Sat, 31 May 2008 11:02:38 +0200 (CEST)

> - I didn't saw any crash with no preemption or voluntary preemption (run 
> it full loaded for a week, it is stable)
> - The kernel doesn't crash, just userspace processes crash.
> - Preemptible RCU has no effect on the crashes (they happen with or 
> without it)
> - The debug options in "kernel hacking" report nothing when enabled, but 
> with the options enabled, the crashes happen more often

I'm going to start looking into this now, thanks for report.

> Presumably, there is some point where preemption corrupts userspace 
> process state, do you have any idea where it could be? You can send me any 
> patches to test. Send them directly to my email, I'm not on the list.

I think the FPU state is being corrupted by the kernel.
The FPU is used heavily by memcpy and memset in userspace
and therefore FPU corruption shows up as either strange
behavior or outright crashes in userspace.
