From: Frans van Berckel <fberckel@xs4all.nl>
Date: Sat, 13 Mar 2010 10:29:18 +0000
Subject: Re: XVR-500 additional pci ids
Message-Id: <1268476158.1775.25.camel@deblnxsrv254.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <201002251955.23519.dennis@ausil.us>
In-Reply-To: <201002251955.23519.dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 2010-03-12 at 00:08 -0800, David Miller wrote:
> From: Frans van Berckel <fberckel@xs4all.nl>
> Date: Fri, 12 Mar 2010 08:54:39 +0100
> 
> >> sparc64: Add very basic XVR-1000 framebuffer driver.
> > 
> > Oh that sound rely nice, wanne say thank you! Gonna test this XVR 1000
> > patch later on and will report the results.
> 
> I look forward to it :-)

Getting a compile error ...

> Arch sparc is not supported with CONFIG_FTRACE_MCOUNT_RECORD at /usr/src/linux-source-2.6-next-git/scripts/recordmcount.pl line 356.
> make[5]: *** [drivers/char/tty_ioctl.o] Error 2
> make[4]: *** [drivers/char] Error 2
> make[3]: *** [drivers] Error 2

On line #280
} elsif ($arch eq "sparc64") {

Does it got to be instead?
} elsif ($arch eq "sparc") {

