From: Roland McGrath <roland@redhat.com>
Date: Sat, 28 Feb 2009 07:36:04 +0000
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
Message-Id: <20090228073604.84F3EFC3DA@magilla.sf.frob.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	<20090228030413.5B915FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	<alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	<20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	<20090228073154.GG9351@elte.hu>
In-Reply-To: Ingo Molnar's message of  Saturday, 28 February 2009 08:31:54 +0100 <20090228073154.GG9351@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org

> btw., shouldnt is_compat_task() expand to 0 in the 
> !CONFIG_COMPAT case? That way we could remove this #ifdef too. 
> (and move the first #ifdef inside the array initialization so 
> that we always have a mode1_syscalls_32[] array.)

I guess you mean define it in linux/compat.h then?
Go right ahead.  Whatever you want is fine by me.


Thanks,
Roland
