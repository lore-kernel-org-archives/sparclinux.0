From: Frans van Berckel <fberckel@xs4all.nl>
Date: Sat, 27 Feb 2010 09:05:26 +0000
Subject: Re: XVR-500 additional pci ids
Message-Id: <1267261526.1781.13.camel@deblnxsrv254.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <201002251955.23519.dennis@ausil.us>
In-Reply-To: <201002251955.23519.dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Reading the Sparc64 OpenSolaris xwindow forum list last year about
closed drivers pointed up a open BSD driver for Wildcat fb cards.

http://www.openbsd.org/cgi-bin/cvsweb/xenocara/driver/xf86-video-wildcatfb/

Did you know this BSD sources are available? Are you able to port it
into the kernel?

Thanks,


Frans van Berckel

On Thu, 2010-02-25 at 21:58 -0800, David Miller wrote:
> From: Dennis Gilmore <dennis@ausil.us>
> Date: Thu, 25 Feb 2010 19:55:15 -0600
> 
> > While testing Fedora 12 install media I noticed that the video card in my 
> > SB2000 wasnt working.  after doing a serial console install i decided to dig 
> > into why.  It seems that the pci id for it is missing.  there was a propossed 
> > patch back in 2008 http://marc.info/?l=linux-sparc&m2816564110952&w=2  Im 
> > doing a test build now  but was wondering if there was some reson that the 
> > patch is not accepted.
> 
> I'll take care of this, it just slipped through the cracks, that's
> all.

