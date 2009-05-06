From: Ingo Molnar <mingo@elte.hu>
Date: Wed, 06 May 2009 21:29:13 +0000
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
Message-Id: <20090506212913.GC4861@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com> <20090228030413.5B915FC3DA@magilla.sf.frob.com> <alpine.LFD.2.00.0902271932520.3111@localhost.localdomain> <alpine.LFD.2.00.0902271948570.3111@localhost.localdomain> <20090228072554.CFEA6FC3DA@magilla.sf.frob.com> <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain> <904b25810905061146ged374f2se0afd24e9e3c1f06@mail.gmail.com>
In-Reply-To: <904b25810905061146ged374f2se0afd24e9e3c1f06@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Markus Gutschke =?utf-8?B?KOmhp+Wtn+WLpCk=?= <markus@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org


* Markus Gutschke (顧孟勤) <markus@google.com> wrote:

> On Sat, Feb 28, 2009 at 10:23, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:

> > And I guess the seccomp interaction means that this is 
> > potentially a 2.6.29 thing. Not that I know whether anybody 
> > actually _uses_ seccomp. It does seem to be enabled in at least 
> > Fedora kernels, but it might not be used anywhere.
> 
> In the Linux version of Google Chrome, we are currently working on 
> code that will use seccomp for parts of our sandboxing solution.

That's a pretty interesting usage. What would be fallback mode you 
are using if the kernel doesnt have seccomp built in? Completely 
non-sandboxed? Or a ptrace/PTRACE_SYSCALL based sandbox?

	Ingo
