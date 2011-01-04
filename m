From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 04 Jan 2011 22:36:53 +0000
Subject: Re: [PATCH v3 00/10] sparc: unify piggyback - and fix tftpboot.img
Message-Id: <20110104223653.GA21327@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110104213800.GA14732@merkur.ravnborg.org>
In-Reply-To: <20110104213800.GA14732@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jan 04, 2011 at 10:16:56PM +0000, Alex Buell wrote:
> On Tue, 2011-01-04 at 22:38 +0100, Sam Ravnborg wrote:
> >         "console [tty0] enabled, bootconsole disabled"
> > 
> > So I did not reach the point where it try to mount 
> > the appended image.
> > Any hints what is wrong is appreciated!
> > [I guess I have the wrong framebuffer driver - but I do not know which
> > is the right one] 
> 
> You might need the PGX64 framebuffer driver for the 'Blade 100.

Just tried it - stuck at the same place :-(

Thanks for the input anyway.

EARLYFB is enabled and works - so I have something working..
It may also be a different issue - the kernel may hang
after the call to register_console().

I will try to debug tomorrow.

	Sam
