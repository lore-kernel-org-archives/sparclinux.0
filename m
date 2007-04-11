From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 11 Apr 2007 02:34:29 +0000
Subject: Re: Build error : 2.6.21-rc6-mm1 on sparc64
Message-Id: <20070410193429.ffbfa33c.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20070411004838.GD15262@Krystal>
	<20070410181854.7d532c59.akpm@linux-foundation.org>
	<1176257739.19452.13.camel@sebastian.intellilink.co.jp>
In-Reply-To: <1176257739.19452.13.camel@sebastian.intellilink.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Fernando Luis =?ISO-8859-1?B?VuF6cXVleg==?= Cao <fernando@oss.ntt.co.jp>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Wed, 11 Apr 2007 11:15:39 +0900 Fernando Luis V=E1zquez Cao <fernando@os=
s.ntt.co.jp> wrote:

> The problem is that to use hard_smp_processor_id in UP kernels just
> including linux/smp.h does not suffice anymore. Now
> hard_smp_processor_id is architecture specific code and consequently
> asm/smp.h should be included explicitly.

yeah.  The fact that linux/smp.h only exposes asm/smp.h if CONFIG_SMP hits
us again and again and again.  It would be good to fix that up, I guess by
including asm/smp.h unconditionally from within linux/smp.h.

But that's a separate little project.

> Mathieu, does the (untested) patch below fix this issue?

I'll test it.
