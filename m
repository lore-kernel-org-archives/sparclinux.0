From: Frans van Berckel <fberckel@xs4all.nl>
Date: Wed, 05 Jan 2011 08:06:04 +0000
Subject: Re: [PATCH v3 00/10] sparc: unify piggyback - and fix tftpboot.img
Message-Id: <1294214764.1554.3.camel@deblnxsrv222>
List-Id: <sparclinux.vger.kernel.org>
References: <20110104213800.GA14732@merkur.ravnborg.org>
In-Reply-To: <20110104213800.GA14732@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 2011-01-04 at 18:49 -0800, David Miller wrote:
> From: Alex Buell <alex.buell@munted.org.uk>
> Date: Tue, 04 Jan 2011 22:16:56 +0000
> 
> > On Tue, 2011-01-04 at 22:38 +0100, Sam Ravnborg wrote:
> >>         "console [tty0] enabled, bootconsole disabled"
> >> 
> >> So I did not reach the point where it try to mount 
> >> the appended image.
> >> Any hints what is wrong is appreciated!
> >> [I guess I have the wrong framebuffer driver - but I do not know which
> >> is the right one] 
> > 
> > You might need the PGX64 framebuffer driver for the 'Blade 100.
> 
> The onboard graphics chip is ATI mach64, not PGX64.

Isn't the PGX64 the same graphics chipset? Can confirm the issue.

Thanks,

Frans van Berckel

