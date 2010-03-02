From: Frans van Berckel <fberckel@xs4all.nl>
Date: Tue, 02 Mar 2010 08:20:39 +0000
Subject: Re: XVR-500 additional pci ids
Message-Id: <1267518039.1750.16.camel@deblnxsrv254.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <201002251955.23519.dennis@ausil.us>
In-Reply-To: <201002251955.23519.dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sorry, i did link the wrong BSD sources. I wasn't looking for Xorg
support yet. But I wanne get my XVR-1200 supported by the kernel.

For what I found out this BSD kernel driver does. Because they did
extend the acceleration code to handle XVR-600 and XVR-1200. It's based
on the driver you created. The sources are available here.

http://www.openbsd.org/cgi-bin/cvsweb/src/sys/arch/sparc64/dev/ifb.c

Now I know you are very busy these day's, so leave it on for now. Or if
someone els wanna look into it?

Thanks,


Frans van Berckel

On Sat, 2010-02-27 at 01:59 -0800, David Miller wrote:
> From: Frans van Berckel <fberckel@xs4all.nl>
> Date: Sat, 27 Feb 2010 10:05:26 +0100
> 
> > Reading the Sparc64 OpenSolaris xwindow forum list last year about
> > closed drivers pointed up a open BSD driver for Wildcat fb cards.
> > 
> > http://www.openbsd.org/cgi-bin/cvsweb/xenocara/driver/xf86-video-wildcatfb/
> > 
> > Did you know this BSD sources are available? Are you able to port it
> > into the kernel?
> 
> You should be able to use the plain ole' 'fbdev' driver under X.
> 
> It can drive any card that has a drivers/video driver under Linux.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


