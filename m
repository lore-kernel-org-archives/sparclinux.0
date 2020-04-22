From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Wed, 22 Apr 2020 14:32:55 +0000
Subject: Re: Implement close-on-fork
Message-Id: <1587565975.3485.5.camel@HansenPartnership.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200420071548.62112-1-nate.karstens@garmin.com>
In-Reply-To: <20200420071548.62112-1-nate.karstens@garmin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nate Karstens <nate.karstens@garmin.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Changli Gao <xiaosuo@gmail.com>

On Mon, 2020-04-20 at 02:15 -0500, Nate Karstens wrote:
> Series of 4 patches to implement close-on-fork. Tests have been
> published to https://github.com/nkarstens/ltp/tree/close-on-fork.
> 
> close-on-fork addresses race conditions in system(), which
> (depending on the implementation) is non-atomic in that it
> first calls a fork() and then an exec().

Why is this a problem?  I get that there's a time between fork and exec
when you have open file descriptors, but they should still be running
in the binary context of the programme that called fork, i.e. under
your control.  The security problems don't seem to occur until you exec
some random binary, which close on exec covers.  So what problem would
close on fork fix?

> This functionality was approved by the Austin Common Standards
> Revision Group for inclusion in the next revision of the POSIX
> standard (see issue 1318 in the Austin Group Defect Tracker).

URL?  Does this standard give a reason why the functionality might be
useful.

James
