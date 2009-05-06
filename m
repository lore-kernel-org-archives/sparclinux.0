From: =?UTF-8?B?TWFya3VzIEd1dHNjaGtlICjpoaflrZ/li6Qp?=
Date: Wed, 06 May 2009 21:46:02 +0000
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
Message-Id: <904b25810905061446m73c42040nfff47c9b8950bcfa@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	 <20090228030413.5B915FC3DA@magilla.sf.frob.com>
	 <alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	 <alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	 <20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	 <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
	 <904b25810905061146ged374f2se0afd24e9e3c1f06@mail.gmail.com>
	 <20090506212913.GC4861@elte.hu>
In-Reply-To: <20090506212913.GC4861@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org

On Wed, May 6, 2009 at 14:29, Ingo Molnar <mingo@elte.hu> wrote:
> That's a pretty interesting usage. What would be fallback mode you
> are using if the kernel doesnt have seccomp built in? Completely
> non-sandboxed? Or a ptrace/PTRACE_SYSCALL based sandbox?

Ptrace has performance and/or reliability problems when used to
sandbox threaded applications due to potential race conditions when
inspecting system call arguments. We hope that we can avoid this
problem with seccomp. It is very attractive that kernel automatically
terminates any application that violates the very well-defined
constraints of the sandbox.

In general, we are currently exploring different options based on
general availability, functionality, and complexity of implementation.
Seccomp is a good middle ground that we expect to be able to use in
the medium term to provide an acceptable solution for a large segment
of Linux users. Although the restriction to just four unfiltered
system calls is painful.

We are still discussing what fallback options we have, and they are
likely on different schedules.

For instance, on platforms that have AppArmor or SELinux, we might be
able to use them as part of our sandboxing solution. Although we are
still investigating whether they meet all of our needs.


Markus
