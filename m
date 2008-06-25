From: David Miller <davem@davemloft.net>
Date: Wed, 25 Jun 2008 22:23:34 +0000
Subject: Re: [3/10 PATCH] inline wake_up_bit
Message-Id: <20080625.152334.32728378.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200806251617.40871.vda.linux@googlemail.com>
	<Pine.LNX.4.64.0806251031330.7542@engineering.redhat.com>
	<200806251724.57689.vda.linux@googlemail.com>
In-Reply-To: <200806251724.57689.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vda.linux@googlemail.com
Cc: mpatocka@redhat.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Denys Vlasenko <vda.linux@googlemail.com>
Date: Wed, 25 Jun 2008 17:24:57 +0200

> talk to gcc people to remedy insane call convention sounds as a more
> workable solution.

It's not a tenable solution to this problem.  We have to make this
work properly with compiler tools currently available to users, rather
than versions of gcc that don't even exist yet.

And what's more, the amount we can get back from the current stack
size allocation is, at best, 16 bytes.  The problem isn't going away
no matter what we do to the compiler.

> BTW, i386 uses regparm call convention, is similar trick
> possible for sparc64?

sparc64 already passes arguments in registers.

The stack frame is (predominantly, size wise) to accomodate the save
area for the cpu's register windows in non-leaf functions, and that
isn't going anywhere.

Back to the patch set, several of these non-inlined cases really
are extremely suboptimal.  If it's just moving args around, it
should be inline.  This would help even x86.

Also, suggesting that IRQSTACKS are mandatory for correct operation is
a pretty unreasonable thing to say.  It's currently still optional on
the platforms where it is implemented, so I wonder if this means that
correct operation is optional on these platforms? :-)

I have a sparc64 IRQSTACKS implementation that I'm working on, but
it's not something I can stick into 2.6.26 by any stretch of the
imagination.
