From: "David S. Miller" <davem@redhat.com>
Date: Fri, 23 Jan 2004 20:58:06 +0000
Subject: Re: why "mov %0, %0" after "rd %%tick, %0"?
Message-Id: <20040123125806.215b41da.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 23 Jan 2004 15:59:13 -0500
Ed L Cashin <ecashin@uga.edu> wrote:

> One thing I don't get is why there's a mov %0, %0 instruction after
> reading the tick register.  Is this because of the delay slot?

No, there is a bug in some of the UltraSPARC processors in that if
you go:

	rd	%tick, %reg
	cmp	%reg, XXX

the compare will get an incorrect result.  If we force the %tick result
into a simple move instruction this prevents the sequence that leads up
to the bug.

