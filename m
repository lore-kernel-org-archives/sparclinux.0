From: "Karstens, Nate" <Nate.Karstens@garmin.com>
Date: Mon, 04 May 2020 13:46:22 +0000
Subject: RE: Implement close-on-fork
Message-Id: <de6adce76b534310975e4d3c4a4facb2@garmin.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200420071548.62112-1-nate.karstens@garmin.com>
 <20200422150107.GK23230@ZenIV.linux.org.uk>
 <20200422151815.GT5820@bombadil.infradead.org>
 <20200422160032.GL23230@ZenIV.linux.org.uk>
In-Reply-To: <20200422160032.GL23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, linux-kernel@vger.

Thanks everyone for their comments, sorry for the delay in my reply.

> As for the original problem...  what kind of exclusion is used between the reaction to netlink notifications (including closing every socket,
> etc.) and actual IO done on those sockets?
> Not an idle question, BTW - unlike Solaris we do NOT (and will not) have
> close(2) abort IO on the same descriptor from another thread.  So if one thread sits in recvmsg(2) while another does close(2), the socket will
> *NOT* actually shut down until recvmsg(2) returns.

The netlink notification is received on a separate thread, but handling of that notification (closing and re-opening sockets) and the socket I/O is all done on the same thread. The call to system() happens sometime between when this thread decides to close all of its sockets and when the sockets have been closed. The child process is left with a reference to one or more sockets. The close-on-exec flag is set on the socket, so the period of time is brief, but because system() is not atomic this still leaves a window of opportunity for the failure to occur. The parent process tries to open the socket again but fails because the child process still has an open socket that controls the port.

This phenomenon can really be generalized to any resource that 1) a process needs exclusive access to and 2) the operating system automatically creates a new reference in the child when the process forks.

> Reimplementing system() is trivial.
> LD_LIBRARY_PRELOAD should take care of all system(3) calls.

Yes, that would solve the problem for our system. We identified what we believe to be a problem with the POSIX threading model and wanted to work with the community to improve this for others as well. The Austin Group agreed with the premise enough that they were willing to update the POSIX standard.

> I wonder it it has some value to add runtime checking for "multi-threaded" to such lib functions and error out if yes.
> Apart from that, system() is a PITA even on single/non-threaded apps.

That may be, but system() is convenient and there isn't much in the documentation that warns the average developer away from its use. The manpage indicates system() is thread-safe. The manpage is also somewhat contradictory in that it describes the operation as being equivalent to a fork() and an execl(), though it later points out that pthread_atfork() handlers may not be executed.

> FWIW, I'm opposed to the entire feature.  Improving the implementation will not change that.

I get it. From our perspective, changing the OS to resolve an issue seems like a drastic step. We tried hard to come up with an alternative (see https://www.mail-archive.com/austin-group-l@opengroup.org/msg05324.html and https://austingroupbugs.net/view.php?id=1317), but nothing else addresses the underlying issue: there is no way to prevent a fork() from duplicating the resource. The close-on-exec flag partially-addresses this by allowing the parent process to mark a file descriptor as exclusive to itself, but there is still a period of time the failure can occur because the auto-close only occurs during the exec(). Perhaps this would not be an issue with a different process/threading model, but that is another discussion entirely.

Best Regards,

Nate

-----Original Message-----
From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
Sent: Wednesday, April 22, 2020 11:01
To: Matthew Wilcox <willy@infradead.org>
Cc: Karstens, Nate <Nate.Karstens@garmin.com>; Jeff Layton <jlayton@kernel.org>; J. Bruce Fields <bfields@fieldses.org>; Arnd Bergmann <arnd@arndb.de>; Richard Henderson <rth@twiddle.net>; Ivan Kokshaysky <ink@jurassic.park.msu.ru>; Matt Turner <mattst88@gmail.com>; James E.J. Bottomley <James.Bottomley@hansenpartnership.com>; Helge Deller <deller@gmx.de>; David S. Miller <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; linux-fsdevel@vger.kernel.org; linux-arch@vger.kernel.org; linux-alpha@vger.kernel.org; linux-parisc@vger.kernel.org; sparclinux@vger.kernel.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Changli Gao <xiaosuo@gmail.com>
Subject: Re: Implement close-on-fork

CAUTION - EXTERNAL EMAIL: Do not click any links or open any attachments unless you trust the sender and know the content is safe.


On Wed, Apr 22, 2020 at 08:18:15AM -0700, Matthew Wilcox wrote:
> On Wed, Apr 22, 2020 at 04:01:07PM +0100, Al Viro wrote:
> > On Mon, Apr 20, 2020 at 02:15:44AM -0500, Nate Karstens wrote:
> > > Series of 4 patches to implement close-on-fork. Tests have been
> > > published to https://github.com/nkarstens/ltp/tree/close-on-fork.
> > >
> > > close-on-fork addresses race conditions in system(), which
> > > (depending on the implementation) is non-atomic in that it first
> > > calls a fork() and then an exec().
> > >
> > > This functionality was approved by the Austin Common Standards
> > > Revision Group for inclusion in the next revision of the POSIX
> > > standard (see issue 1318 in the Austin Group Defect Tracker).
> >
> > What exactly the reasons are and why would we want to implement that?
> >
> > Pardon me, but going by the previous history, "The Austin Group Says
> > It's Good" is more of a source of concern regarding the merits,
> > general sanity and, most of all, good taste of a proposal.
> >
> > I'm not saying that it's automatically bad, but you'll have to go
> > much deeper into the rationale of that change before your proposal
> > is taken seriously.
>
> https://www.mail-archive.com/austin-group-l@opengroup.org/msg05324.htm
> l
> might be useful

*snort*

Alan Coopersmith in that thread:
|| https://lwn.net/Articles/785430/ suggests AIX, BSD, & MacOS have also
|| defined it, and though it's been proposed multiple times for Linux, never adopted there.

Now, look at the article in question.  You'll see that it should've been "someone's posting in the end of comments thread under LWN article says that apparently it exists on AIX, BSD, ..."

The strength of evidence aside, that got me curious; I have checked the source of FreeBSD, NetBSD and OpenBSD.  No such thing exists in either of their kernels, so at least that part can be considered an urban legend.

As for the original problem...  what kind of exclusion is used between the reaction to netlink notifications (including closing every socket,
etc.) and actual IO done on those sockets?


________________________________

CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use of the intended recipient(s) and contain information that may be Garmin confidential and/or Garmin legally privileged. If you have received this email in error, please notify the sender by reply email and delete the message. Any disclosure, copying, distribution or use of this communication (including attachments) by someone other than the intended recipient is prohibited. Thank you.
