From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 22 Feb 2006 03:59:50 +0000
Subject: Re: possible spinlock/esp bug in 2.6.16-rc4
Message-Id: <20060221.195950.124866821.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060219101701.6f2ce579@enterprise.weeve.org>
In-Reply-To: <20060219101701.6f2ce579@enterprise.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jason Wever <weeve@gentoo.org>
Date: Tue, 21 Feb 2006 20:20:57 -0700

> On Sun, 19 Feb 2006 10:21:10 -0800 (PST)
> "David S. Miller" <davem@davemloft.net> wrote:
> 
> > Please do a "git bisect" from the last known working version
> > so we can find out exactly what change caused this regression.
> > 
> > The esp driver hasn't been touched in ages so it's probably
> > a sparc64 or SCSI layer generic change that caused this.
> > 
> > Please get in the habit of using git.  Using "git bisect" allows you
> > to determine quickly exactly what patch introduced a regression
> > saving developers and yourself a lot of wasted time analyzing
> > bug reports.
> 
> Thanks for the pointer.  In using this method to track down the patch,
> I started getting errors looking like this;

This is not the orignal bug you reported.  This is not how you use
"git bisect".

Use it to see where the bug you originally reported starts to show up.

Any other bug you trip over meanwhile probably is fixed in a later
changeset and is only going to distract from finding the original bug.

I hate to say this Jason, but you're really bad at bug reporting.  You
never do a thorough job and that's why your sparc64 bug reports either
take an enormously long time to resolve or never get resolved at all.

I did the Niagara port in one month because every time I had some
weird bug to figure out I got all the necessary information and did
all the necessary detective work in order to find the true cause of
each and every problem.

Whereas you always send me on wild goose chases with unrelated
problems from your original report.  This __dequeue_signal
local_bh_enable() bug message, totally unrelated to the ESP scsi crash
you originally reported, is a good example of this.

I hate to do this, pointing you out like this, but I want you to be
able to do good bug reports.  Reports which I can solve in an
afternoon, which is what is possible if you give me the right
information.
