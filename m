From: George Spelvin <lkml@sdf.org>
Date: Thu, 28 Mar 2019 17:33:06 +0000
Subject: Re: [PATCH] SPARC: Better fls64(), fls() and __fls() on SPARCv9
Message-Id: <201903281733.x2SHX6lt029174@sdf.org>
List-Id: <sparclinux.vger.kernel.org>
References: <201903281052.x2SAqaoH015770@sdf.org>
In-Reply-To: <201903281052.x2SAqaoH015770@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> You can't use popc in the default implementations, most sparc64
> chips do not implement popc in hardware and it must be emulated.

Mea culpa!  I was reading the various architecture manuals
(mostly about umulxhi support) and noticed that popc was in the
oldest original SPARCv9 architecture manuals, so I assumed
it had universal hardware support.

Damn manuals not mentioning a Really Important Detail like that!
(They *do* document the lack of hardware support for quad floating point,
but no such warning appears in the 2011 or 2015 architecture manuals.)
With your prompting, I found mention of this in a Java feature request:
https://bugs.java.com/bugdatabase/view_bug.do?bug_idc78821

And of course, T4 has lzcnt and doesn't care.

Sorry for wasting your time.  (And mine.)

P.S. I do think *some* earlier processors have hardware
popc support; e.g. the T3 manual documents the instruction
latency, which implies hardware support.  But dealing
with a feature flag is not nearly so simple a patch.


P.P.S. __NG4fls cn be simplified to
ENTRY(__NG4fls)
	LZCNT_O0_G2	!lzcnt  %o0, %g2
	retl
	 xor	%g2, 63, %o0
ENDPROC(__NG4fls)
