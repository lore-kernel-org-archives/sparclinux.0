From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 04 Jun 2012 19:43:25 +0000
Subject: Re: sparc32: some more testing
Message-Id: <20120604194325.GA28324@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
In-Reply-To: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, May 29, 2012 at 04:16:26PM -0400, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Tue, 29 May 2012 20:39:39 +0200
> 
> > I gues I have some challenging debugging hours waiting - but that
> > will wait a little...
> 
> When diagnosing these kinds of problems, the first thing you can try
> to do is make all of the TLB operations flush the entire TLB and
> failing that also making all the cache operations flush the entire
> cache.

I started playing around with this again.
I did a lot of things related to flush handling with no success.
In the end I decided to shrink my kernel-image (I use tftpboot.img).

When I finally squezed the kernel (including rootfs) to allow
me to do the initial memory allocations in the memory area
below 0xa00000 then I could boot.

So the inital mapping is limited to 10MB...
I need to find a way to extend the initial mapping without the need
to access allocated memory.
I have not looked at it yet - this is just a heads-up.

PS. I did not do any test yet on my system as I had selected the wrong
video driver (it hangs when it was supposed to shift displays).

	Sam
