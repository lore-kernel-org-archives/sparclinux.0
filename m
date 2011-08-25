From: Jim Faulkner <jfaulkne@ccs.neu.edu>
Date: Thu, 25 Aug 2011 17:32:13 +0000
Subject: Re: bug report: Sun Blade 100 kernel panics during boot under 3.0.3
Message-Id: <20110825173213.GA12155@alumni-linux.ccs.neu.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
In-Reply-To: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Aug 24, 2011 at 11:03:24PM +0200, Sam Ravnborg wrote:
> From image 3 it looks like you hit some issues with the ALI7101.
> 
> From your config I can see you have:
> CONFIG_I2C_ALI1535=m
> CONFIG_I2C_ALI1563=m
> 
> They both mention ALI7101 in their help text.
> 
> Just to give a hint if this is the casue could you try to disable one
> or both of these to see if this has any effect.

OK, I've disabled both options and attached my updated .config to
bugzilla.

Unfortunately I'm seeing the same results when booting.  The kernel
panics look exactly the same (referencing the ali7101), so I didn't
bother taking more photos.

I'm not really surprised by this result, since ALI1535 and ALI1563 were
configured as modules, and I'm getting the kernel panic before any
modules can be loaded (I'm not using an initrd).

