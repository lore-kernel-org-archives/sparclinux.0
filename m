From: Joe Perches <joe@perches.com>
Date: Mon, 26 Mar 2012 16:32:09 +0000
Subject: Re: [PATCH 19/20 v3] sparc/mm/fault_32.c: Port OOM changes to do_sparc_fault
Message-Id: <1332779529.6160.96.camel@joe2Laptop>
List-Id: <sparclinux.vger.kernel.org>
References: <1332775946-2162-1-git-send-email-consul.kautuk@gmail.com>
	 <1332778595.6160.84.camel@joe2Laptop>
	 <CAFPAmTSyYJkATAD32WqHZY_PdWGjitEq4vgqCZeqjo+V24dh3Q@mail.gmail.com>
In-Reply-To: <CAFPAmTSyYJkATAD32WqHZY_PdWGjitEq4vgqCZeqjo+V24dh3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kautuk Consul <consul.kautuk@gmail.com>
Cc: davem@davemloft.net, Paul Gortmaker <paul.gortmaker@windriver.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2012-03-26 at 12:20 -0400, Kautuk Consul wrote:
> > David meant that the indentation should be aligned
> > immediately after the open parenthesis:
> >
> > +       unsigned int flags = (FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE |
> > +                             (write ? FAULT_FLAG_WRITE : 0));
> >
> > though perhaps this is clearer as:
> >
> >        unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
> >
> >        if (write)
> >                flags |= FAULT_FLAG_WRITE;
> >
> > or even separate sets.
> >
> >        if (write)
> >                flags = foo;
> >        else
> >                flags = bar;
> 
> This is how it is in the patch file(immediately after the paramthesis).
> I have now attached both sparc patches to this email.
> 
> you must be having the same problem in viewing the patch file
> as me due to the email client itself inserting invalid spaces here and there.

Nope.  That's not it.

> by the way, what tab-spaces are you using when you open it in vim ?

I use vim as an editor as infrequently as possible.

Your original patch used 6 tabs and 2 spaces.
Tab size in kernel style is always 8.

Again, make sure your tab indentation is set to 8.

