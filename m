From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 09 Jan 2006 22:33:41 +0000
Subject: Re: strace broken on SPARC64
Message-Id: <20060109.143341.54032448.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1136767843.9208.15.camel@duncow>
In-Reply-To: <1136767843.9208.15.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Mon, 09 Jan 2006 22:00:21 +0000

> On Mon, 2006-01-09 at 12:53 -0800, David S. Miller wrote:
> > From: "Richard Mortimer" <richm@oldelvet.org.uk>
> > Date: Mon, 9 Jan 2006 16:03:31 -0000
> 
> > Yeah, I have to certainly do the fix differently.  Thanks for
> > testing :-)
> > 
> > I'll cook up a better fix.
> 
> I tried using %l2 as suggested by Luis and that works for me.
> 
> Looking at the code I wonder if it makes sense to simplify the code
> a little bit. The following works for me but I'm not sure how to
> exercise the "NOERROR" codepath.

Why is it so hard for people to send non-corrupt patches with their
email clients? :-/

All the tabs have been turned into spaces by your email client making
the patch unusable.

I'll fix it up by hand in this case, but next time...
