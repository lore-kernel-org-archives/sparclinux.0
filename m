From: Ingo Molnar <mingo@elte.hu>
Date: Thu, 08 Jan 2009 12:02:34 +0000
Subject: Re: [PATCH] sparc: refactor code in fault_32.c
Message-Id: <20090108120234.GC1539@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <20090106205209.GA24034@uranus.ravnborg.org>
In-Reply-To: <20090106205209.GA24034@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


* David Miller <davem@davemloft.net> wrote:

> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Tue, 6 Jan 2009 22:06:24 +0100
> 
> > So outstanding issues now are:
> > 
> > 1) How to fix "warning" in unaligned_64.c (get_user() || get_user())
> 
> I'm going to put a hack patch in, similar to your's, so people can get
> work done.  We can try to cure this situation more cleanly later.
> 
>     sparc64: Work around branch tracer warning.
>     
>     As reported by Sam Ravnborg, Gcc-3.4.5 does not handle:
>     
>     	if (get_user() || get_user())
>     
>     with the new branch tracer enabled.
>     
>     Just seperate it out into seperate statements for now
>     so people can get work done.

Can you think of any way we could improve the branch-tracer 
instrumentation define in any way to prevent such trouble?

	Ingo
