From: Al Viro <viro@zeniv.linux.org.uk>
Date: Wed, 22 Apr 2020 16:13:43 +0000
Subject: Re: Implement close-on-fork
Message-Id: <20200422161343.GM23230@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20200420071548.62112-1-nate.karstens@garmin.com>
 <20200422150107.GK23230@ZenIV.linux.org.uk>
 <20200422151815.GT5820@bombadil.infradead.org>
 <20200422160032.GL23230@ZenIV.linux.org.uk>
In-Reply-To: <20200422160032.GL23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@infradead.org>
Cc: Nate Karstens <nate.karstens@garmin.com>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Changli Gao <xiaosuo@gmail.com>

On Wed, Apr 22, 2020 at 05:00:32PM +0100, Al Viro wrote:

> *snort*
> 
> Alan Coopersmith in that thread:
> || https://lwn.net/Articles/785430/ suggests AIX, BSD, & MacOS have also defined
> || it, and though it's been proposed multiple times for Linux, never adopted there.
> 
> Now, look at the article in question.  You'll see that it should've been
> "someone's posting in the end of comments thread under LWN article says that
> apparently it exists on AIX, BSD, ..."
> 
> The strength of evidence aside, that got me curious; I have checked the
> source of FreeBSD, NetBSD and OpenBSD.  No such thing exists in either of
> their kernels, so at least that part can be considered an urban legend.
> 
> As for the original problem...  what kind of exclusion is used between
> the reaction to netlink notifications (including closing every socket,
> etc.) and actual IO done on those sockets?

Not an idle question, BTW - unlike Solaris we do NOT (and will not) have
close(2) abort IO on the same descriptor from another thread.  So if one
thread sits in recvmsg(2) while another does close(2), the socket will
*NOT* actually shut down until recvmsg(2) returns.
