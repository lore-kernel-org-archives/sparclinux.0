From: Ingo Molnar <mingo@elte.hu>
Date: Wed, 06 May 2009 22:13:19 +0000
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
Message-Id: <20090506221319.GA11493@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <20090228030413.5B915FC3DA@magilla.sf.frob.com> <alpine.LFD.2.00.0902271932520.3111@localhost.localdomain> <alpine.LFD.2.00.0902271948570.3111@localhost.localdomain> <20090228072554.CFEA6FC3DA@magilla.sf.frob.com> <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain> <904b25810905061146ged374f2se0afd24e9e3c1f06@mail.gmail.com> <20090506212913.GC4861@elte.hu> <904b25810905061446m73c42040nfff47c9b8950bcfa@mail.gmail.com> <20090506215450.GA9537@elte.hu> <904b25810905061508n6d9cb8dbg71de5b1e0332ede7@mail.gmail.com>
In-Reply-To: <904b25810905061508n6d9cb8dbg71de5b1e0332ede7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Markus Gutschke =?utf-8?B?KOmhp+Wtn+WLpCk=?= <markus@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org


* Markus Gutschke (顧孟勤) <markus@google.com> wrote:

> On Wed, May 6, 2009 at 14:54, Ingo Molnar <mingo@elte.hu> wrote:
> > Which other system calls would you like to use? Futexes might be
> > one, for fast synchronization primitives?
> 
> There are a large number of system calls that "normal" C/C++ code 
> uses quite frequently, and that are not security sensitive. A 
> typical example would be gettimeofday(). But there are other 
> system calls, where the sandbox would not really need to inspect 
> arguments as the call does not expose any exploitable interface.
> 
> It is currently awkward that in order to use seccomp we have to 
> intercept all system calls and provide alternative implementations 
> for them; whereas we really only care about a comparatively small 
> number of security critical operations that we need to restrict.
> 
> Also, any redirected system call ends up incurring at least two 
> context switches, which is needlessly expensive for the large 
> number of trivial system calls. We are quite happy that read() and 
> write(), which are quite important to us, do not incur this 
> penalty.

doing a (per arch) bitmap of harmless syscalls and replacing the 
mode1_syscalls[] check with that in kernel/seccomp.c would be a 
pretty reasonable extension. (.config controllable perhaps, for 
old-style-seccomp)

It would probably be faster than the current loop over 
mode1_syscalls[] as well.

	Ingo
