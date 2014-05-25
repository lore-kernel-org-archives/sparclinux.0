From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 25 May 2014 20:44:34 +0000
Subject: Re: [PATCH v2 00/34] sparc sparse fixes + diverse cleanup
Message-Id: <20140525204434.GA27452@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20140516212259.GA17389@ravnborg.org>
In-Reply-To: <20140516212259.GA17389@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, May 24, 2014 at 11:41:50PM -0400, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Mon, 19 May 2014 18:55:33 +0200
> 
> > On Sun, May 18, 2014 at 10:06:49PM -0400, David Miller wrote:
> >> 
> >> Ok I reviewed all of this, it all looks good.
> >> 
> >> Thanks a lot for doing this, all applied to sparc-next.
> > Good. And I am glad you spotted the bug in the first
> > version so we did not have that applied.
> > 
> > If you find time and have any hints how to fix
> > the remaining sparse warnings in arch/sparc/
> > please let me know.
> 
> Sorry Sam I've lost context.
> 
> Is there a specific list you posted or should I run an sparse build
> of my own and check it out?
I posted a list of remaining sparse issues in the original cover mail.
But I think we should let them wait and maybe address then in next
round. arch/sparc already have lots of stuff pending for next
merge window.
On top of this I have a few other things that has higher priority.

I will re-post a list of open issues when I plan to look at them again.

	Sam

