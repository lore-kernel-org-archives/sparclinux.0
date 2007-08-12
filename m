From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Sun, 12 Aug 2007 19:27:24 +0000
Subject: Re: Sun4c interrupt controller - Sun4d relevance
Message-Id: <1186946844.4243.56.camel@new-host-2>
List-Id: <sparclinux.vger.kernel.org>
References: <46BF2A25.9090900@netunix.com>
In-Reply-To: <46BF2A25.9090900@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Sun, 2007-08-12 at 20:23 +0100, Chris Newport wrote:

> Last Solaris support for sun4d was Solaris 2.8 so all of the code will 
> be there in 2.6 somewhere. Maybe it is just a special case within sun4m 
> with a few extra drivers, or maybe the code has not been released.
> The SS1000 is frustratingly similar to the SS20, most of the devices are 
> common.
> 
> ISTR that Sun4d was a joint venture with Cray, so some code might
> be encumbered. I have not seen code so I can only guess.

I hate to be a bother here, but aren't there some legal concerns with
looking at Solaris source code, then implementing code in Linux?

Even on OpenSolaris, there is a grey area as to whether one can legally
view CDDL licensed code, then reimplement it as GPL (CDDL is
GPL-Incompatible) for Linux... but on old Solaris, that code should be
proprietary, unless Sun opened it when I wasn't looking.

Mark, can you legally be doing this? 

~spot

