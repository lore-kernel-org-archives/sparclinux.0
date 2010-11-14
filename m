From: Alex Buell <alex.buell@munted.org.uk>
Date: Sun, 14 Nov 2010 13:27:30 +0000
Subject: Re: XVR-500
Message-Id: <1289741250.10953.5.camel@lithium>
List-Id: <sparclinux.vger.kernel.org>
References: <1289604206.26034.53.camel@lithium>
In-Reply-To: <1289604206.26034.53.camel@lithium>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

[Added sparclinux@vger.kernel.org]

On Fri, 2010-11-12 at 15:27 -0800, David Miller wrote:
> From: Alex Buell <alex.buell@munted.org.uk>
> Date: Fri, 12 Nov 2010 23:15:09 +0000
> 
> > On Fri, 2010-11-12 at 12:56 -0800, David Miller wrote:
> > 
> >> That's why we need to override ->imageblit(), ->fillrect(), and
> >> ->copyarea() driver operations and can't just use the normal cfb* ones
> >> directly.
> >> 
> >> Therefore the X11 fbdev driver is never going to work properly, no
> >> matter what BPP or resolution you bring up the screen.
> > 
> > That's what I'm trying to understand - the console looks and works just
> > fine yet when the fbdev driver is loaded it doesn't get things right? I
> > thought it just run on top of the console driver? 
> 
> Nope, fbdev mmap()'s the framebuffer and writes directly to it.
> It doesn't use the console driver for anything other than mapping
> the framebuffer into the X server process's address space.

Since the console driver seems to work just fine, perhaps a new X11
driver might need to be written, using the wcfb driver from [Open|
Net]BSD as a reference. 

I will need to install OpenBSD on a spare disk and see how it works.
-- 
Tactical Nuclear Kittens
