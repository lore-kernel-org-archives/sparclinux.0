From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Wed, 03 Nov 2004 00:01:29 +0000
Subject: Re: [Linux-fbdev-devel] Help re Frame Buffer/Console Problems
Message-Id: <Pine.LNX.4.10.10411022352380.5583-100000@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <200411030719.06138.adaplas@hotpop.com>
In-Reply-To: <200411030719.06138.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org, geert@linux-m68k.org, sparclinux@vger.kernel.org, ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org, wli@holomorphy.com

I have just tested it and at the moment it does not. I suspect that
something needs to be registered in the 'panic_notifier_list' to do some
basic resets on the colour palette.

For the moment I will just ensure that colour 255 <> colour 0 by some
visible margin (Black/Dark Slate).

Mark.

On Wed, 3 Nov 2004, Antonino A. Daplas wrote:

> On Wednesday 03 November 2004 06:57, Mark Fortescue wrote:
> > Will this work for a kernel Panic ?
> >
> 
> Probably not, unless the 'Panic' tells fbcon to release the console and 
> tells promcon to take over the console again.  That in itself is problematic
> as fbcon cannot be safely unloaded yet.
> 
> Tony
> 
> 

