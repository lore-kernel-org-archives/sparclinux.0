From: David Dillow <dave@thedillows.org>
Date: Wed, 21 Jul 2004 05:20:03 +0000
Subject: Re: SPARCprinter
Message-Id: <1090387203.4229.14.camel@ori.thedillows.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 2004-07-20 at 22:50, David Dillow wrote:
> On Tue, 2004-07-20 at 22:05, David S. Miller wrote:
[snip]
> > David, can you send me a copy of this lpvi.c netbsd driver?
> > Thanks.
> 
> Sure, I can do that, or I could do you one better -- I'll send my Linux
> lpvi driver. :)
> 
> Since I'd like to finish cleaning up my version (almost there), here's a
> pointer to der Mouse's NetBSD driver.
> http://www.netsys.com/netbsd-port-sparc/2002/03/msg00063.html
> 
> I cannot get to ftp.netbsd.org right now to see if it is still there;
> let me know and I'll bundle up my local copy.

Just for good measure, you can get my driver (and the CUPS part as well)
at http://www.thedillows.org/lpvi/lpvi-0.10.tar.bz2

It's ALPHA software, but should be pretty stable aside from some areas I
haven't investigated yet (like is it possible to change DPI while
printing, or do I need to idle the printer). Doing AIO makes it a bit
more complex than I'd like, but it is the difference between doing 6
pages per minute and 10 pages per minute, so I think it is worth it. :)

Comments welcome, and let me know if you cannot get to the NetBSD
version.

Dave
