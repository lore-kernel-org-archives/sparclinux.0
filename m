From: David Miller <davem@davemloft.net>
Date: Sat, 27 Feb 2010 09:59:23 +0000
Subject: Re: XVR-500 additional pci ids
Message-Id: <20100227.015923.104078678.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201002251955.23519.dennis@ausil.us>
In-Reply-To: <201002251955.23519.dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans van Berckel <fberckel@xs4all.nl>
Date: Sat, 27 Feb 2010 10:05:26 +0100

> Reading the Sparc64 OpenSolaris xwindow forum list last year about
> closed drivers pointed up a open BSD driver for Wildcat fb cards.
> 
> http://www.openbsd.org/cgi-bin/cvsweb/xenocara/driver/xf86-video-wildcatfb/
> 
> Did you know this BSD sources are available? Are you able to port it
> into the kernel?

You should be able to use the plain ole' 'fbdev' driver under X.

It can drive any card that has a drivers/video driver under Linux.

