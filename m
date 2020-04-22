From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Wed, 22 Apr 2020 15:34:23 +0000
Subject: Re: Implement close-on-fork
Message-Id: <1587569663.3485.18.camel@HansenPartnership.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200420071548.62112-1-nate.karstens@garmin.com>
         <20200422150107.GK23230@ZenIV.linux.org.uk>
         <20200422151815.GT5820@bombadil.infradead.org>
In-Reply-To: <20200422151815.GT5820@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Nate Karstens <nate.karstens@garmin.com>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Changli Gao <xiaosuo@gmail.com>

On Wed, 2020-04-22 at 08:18 -0700, Matthew Wilcox wrote:
> On Wed, Apr 22, 2020 at 04:01:07PM +0100, Al Viro wrote:
> > On Mon, Apr 20, 2020 at 02:15:44AM -0500, Nate Karstens wrote:
> > > Series of 4 patches to implement close-on-fork. Tests have been
> > > published to https://github.com/nkarstens/ltp/tree/close-on-fork.
> > > 
> > > close-on-fork addresses race conditions in system(), which
> > > (depending on the implementation) is non-atomic in that it
> > > first calls a fork() and then an exec().
> > > 
> > > This functionality was approved by the Austin Common Standards
> > > Revision Group for inclusion in the next revision of the POSIX
> > > standard (see issue 1318 in the Austin Group Defect Tracker).
> > 
> > What exactly the reasons are and why would we want to implement
> > that?
> > 
> > Pardon me, but going by the previous history, "The Austin Group
> > Says It's Good" is more of a source of concern regarding the
> > merits, general sanity and, most of all, good taste of a proposal.
> > 
> > I'm not saying that it's automatically bad, but you'll have to go
> > much deeper into the rationale of that change before your proposal
> > is taken seriously.
> 
> https://www.mail-archive.com/austin-group-l@opengroup.org/msg05324.ht
> ml
> might be useful

So the problem is an application is written in such a way that the time
window after it forks and before it execs can cause a file descriptor
based resource to be held when the application state thinks it should
have been released because of a mismatch in the expected use count?

Might it not be easier to rewrite the application for this problem
rather than the kernel?  Especially as the best justification in the
entire thread seems to be "because solaris had it".

James
