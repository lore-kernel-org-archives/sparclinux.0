From: Chris Newport <crn@netunix.com>
Date: Sun, 12 Aug 2007 15:41:25 +0000
Subject: Re: Sun4c interrupt controller - Sun4d relevance
Message-Id: <46BF2A25.9090900@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Mark Fortescue wrote:

>
> There is source code for Solaris 2.6 on the web. This is the best 
> source code reference you will get for sun4c as the low level code has 
> not been changed significantly from that of the architecture reference 
> kernel (SunOS 4.1 - see Sparc SCD 1.1).

This is VERY interesting as it should be possible to fix Sun4d by finding
the differences between sun4d and sun4m in Solaris and covering those 
points.

This would almost certainly be easier than trying to fix the current 
mess. Unfortunately I am no longer able to do this but maybe someone 
will be interested enough to try. It might even be possible to fix 
pluto/fc but maybe that is too much to ask.



