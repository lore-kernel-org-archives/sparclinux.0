From: =?UTF-8?B?TWFya3VzIEd1dHNjaGtlICjpoaflrZ/li6Qp?=
Date: Wed, 06 May 2009 22:21:51 +0000
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
Message-Id: <904b25810905061521v62b3ddd6l14deb614d203385a@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090228030413.5B915FC3DA@magilla.sf.frob.com>
	 <alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	 <20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	 <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
	 <904b25810905061146ged374f2se0afd24e9e3c1f06@mail.gmail.com>
	 <20090506212913.GC4861@elte.hu>
	 <904b25810905061446m73c42040nfff47c9b8950bcfa@mail.gmail.com>
	 <20090506215450.GA9537@elte.hu>
	 <904b25810905061508n6d9cb8dbg71de5b1e0332ede7@mail.gmail.com>
	 <20090506221319.GA11493@elte.hu>
In-Reply-To: <20090506221319.GA11493@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org

On Wed, May 6, 2009 at 15:13, Ingo Molnar <mingo@elte.hu> wrote:
> doing a (per arch) bitmap of harmless syscalls and replacing the
> mode1_syscalls[] check with that in kernel/seccomp.c would be a
> pretty reasonable extension. (.config controllable perhaps, for
> old-style-seccomp)
>
> It would probably be faster than the current loop over
> mode1_syscalls[] as well.

This would be a great option to improve performance of our sandbox. I
can detect the availability of the new kernel API dynamically, and
then not intercept the bulk of the system calls. This would allow the
sandbox to work both with existing and with newer kernels.

We'll post a kernel patch for discussion in the next few days,


Markus
