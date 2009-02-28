From: Ingo Molnar <mingo@elte.hu>
Date: Sat, 28 Feb 2009 07:31:54 +0000
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
Message-Id: <20090228073154.GG9351@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com> <20090228030413.5B915FC3DA@magilla.sf.frob.com> <alpine.LFD.2.00.0902271932520.3111@localhost.localdomain> <alpine.LFD.2.00.0902271948570.3111@localhost.localdomain> <20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
In-Reply-To: <20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org


* Roland McGrath <roland@redhat.com> wrote:

> +#ifdef CONFIG_COMPAT
> +		if (is_compat_task())
>  			syscall = mode1_syscalls_32;
>  #endif

btw., shouldnt is_compat_task() expand to 0 in the 
!CONFIG_COMPAT case? That way we could remove this #ifdef too. 
(and move the first #ifdef inside the array initialization so 
that we always have a mode1_syscalls_32[] array.)

	Ingo
