From: David Miller <davem@davemloft.net>
Date: Thu, 26 Jul 2012 23:55:16 +0000
Subject: Re: [PATCH 0/18] sparc32 mm/ cleanups v2
Message-Id: <20120726.165516.937157911301277301.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120726205846.GA3838@merkur.ravnborg.org>
In-Reply-To: <20120726205846.GA3838@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 26 Jul 2012 22:58:46 +0200

> This is version two of a patch-set to clean-up
> various bits in arch/sparc/mm/ (mainly).
> v1 was dropped on my request as I had an idea
> to improve one of the patches. In the end the idea
> was bogus.
> 
> But looking a bit more on the relevant files
> the patch-set grew a bit larger and now counts 18
> patches.
> 
> They are all fairly trivial as most just moved code
> around or delete unused code.
> The removal of fixmap counts as the largest patch.
> 
> I could do much more trivial cleanup but resisted for now.
> 
> The patches are based and a one day old pull from
> upstream.
> (On top of bdc0077af574800d24318b6945cf2344e8dbb050
> "Merge tag 'scsi-misc' ...")
> 
> We are in the middle of the merge window and this
> is late in that game. On the other hand this is
> trivial stuff so it should be OK to merge now I hope.
> 
> This was delayed a bit as I have spent some time
> in nl and cz during my holidays.
> But soon work is calling again :-(

All applied, thanks Sam.

I do wonder though about the cleanup that changed over to using void
pointers, it might still have readability but we seem to have lost
some typing protection.

But it's not a big deal to me.
