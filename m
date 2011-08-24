From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 24 Aug 2011 21:03:24 +0000
Subject: Re: bug report: Sun Blade 100 kernel panics during boot under 3.0.3
Message-Id: <20110824210324.GA19294@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
In-Reply-To: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Aug 24, 2011 at 03:50:53PM -0400, Jim Faulkner wrote:
> On Mon, Aug 22, 2011 at 05:36:02PM -0700, David Miller wrote:
> 
> > Unfortunately we need the very first crash message that happens, but
> > even your first snapshot is after other crashes have occurred.
> > 
> > You'll need to build a kernel with CONFIG_BOOT_PRINTK_DELAYED enabled
> > and then you can boot with boot_delay=xxx (where "xxx" is something
> > like 100, it's in milliseconds) to slow down the message printing so
> > that you can capture the first message cleanly.
> 
> OK, I've attached several images of the kernel panic w/ boot_delay to
> the bug:
> 
> https://bugzilla.kernel.org/show_bug.cgi?idA522

From image 3 it looks like you hit some issues with the ALI7101.

From your config I can see you have:
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m

They both mention ALI7101 in their help text.

Just to give a hint if this is the casue could you try to disable one
or both of these to see if this has any effect.

	Sam
