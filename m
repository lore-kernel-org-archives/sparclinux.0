From: Ingo Molnar <mingo@elte.hu>
Date: Thu, 07 May 2009 10:11:29 +0000
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
Message-Id: <20090507101129.GB5978@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <20090228072554.CFEA6FC3DA@magilla.sf.frob.com> <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain> <904b25810905061146ged374f2se0afd24e9e3c1f06@mail.gmail.com> <20090506212913.GC4861@elte.hu> <904b25810905061446m73c42040nfff47c9b8950bcfa@mail.gmail.com> <20090506215450.GA9537@elte.hu> <904b25810905061508n6d9cb8dbg71de5b1e0332ede7@mail.gmail.com> <20090506221319.GA11493@elte.hu> <904b25810905061521v62b3ddd6l14deb614d203385a@mail.gmail.com> <1241670237.11500.7.camel@entropy>
In-Reply-To: <1241670237.11500.7.camel@entropy>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Nicholas Miell <nmiell@comcast.net>
Cc: Markus Gutschke =?utf-8?B?KOmhp+Wtn+WLpCk=?= <markus@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org


* Nicholas Miell <nmiell@comcast.net> wrote:

> On Wed, 2009-05-06 at 15:21 -0700, Markus Gutschke (顧孟勤) wrote:
> > On Wed, May 6, 2009 at 15:13, Ingo Molnar <mingo@elte.hu> wrote:
> > > doing a (per arch) bitmap of harmless syscalls and replacing the
> > > mode1_syscalls[] check with that in kernel/seccomp.c would be a
> > > pretty reasonable extension. (.config controllable perhaps, for
> > > old-style-seccomp)
> > >
> > > It would probably be faster than the current loop over
> > > mode1_syscalls[] as well.
> > 
> > This would be a great option to improve performance of our sandbox. I
> > can detect the availability of the new kernel API dynamically, and
> > then not intercept the bulk of the system calls. This would allow the
> > sandbox to work both with existing and with newer kernels.
> > 
> > We'll post a kernel patch for discussion in the next few days,
> > 
> 
> I suspect the correct thing to do would be to leave seccomp mode 1 
> alone and introduce a mode 2 with a less restricted set of system 
> calls -- the interface was designed to be extended in this way, 
> after all.

Yes, that is what i alluded to above via the '.config controllable' 
aspect.

Mode 2 could be implemented like this: extend prctl_set_seccomp() 
with a bitmap pointer, and copy it to a per task seccomp context 
structure.

a bitmap for 300 syscalls takes only about 40 bytes.

Please take care to implement nesting properly: if a seccomp context 
does a seccomp call (which mode 2 could allow), then the resulting 
bitmap should be the logical-AND of the parent and child bitmaps. 
There's no reason why seccomp couldnt be used in hiearachy of 
sandboxes, in a gradually less permissive fashion.

	Ingo
