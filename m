From: Ben Collins <bcollins@debian.org>
Date: Wed, 07 Jan 2004 19:24:05 +0000
Subject: Re: [BKPATCH]: Add option to define default command line to kernel.
Message-Id: <20040107192405.GP17280@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040107182529.GK17280@phunnypharm.org>
In-Reply-To: <20040107182529.GK17280@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jan 07, 2004 at 12:03:31PM -0800, Keith M Wesolowski wrote:
> On Wed, Jan 07, 2004 at 01:25:30PM -0500, Ben Collins wrote:
> 
> > +	  Say Y here if you want to be able to pass default arguments to
> > +	  the kernel. This will be overridden by the bootloader, if you
> > +	  use one (such as SILO). This is most useful if you want to boot
> > +	  a kernel from TFTP, and want default options to be available
> > +	  with having them passed on the command line.
> > +
> > +	  NOTE: This option WILL override the PROM bootargs setting!
> 
> I don't really understand the need for this.  Why not just use the
> PROM boot arguments if you're booting from TFTP?

What if you have different kernels that require different boot args? If
you want to switch between them without messing with bootargs, this is
the easiest way.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
