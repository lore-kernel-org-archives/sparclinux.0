From: Alex Buell <alex.buell@munted.org.uk>
Date: Fri, 12 Nov 2010 20:47:22 +0000
Subject: [Fwd: Re: PING: David Miller - SPARC64]
Message-Id: <1289594842.26034.28.camel@lithium>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Originally posted on linux-kernel, now forwarded to sparc-linux. 

-------- Forwarded Message --------
> From: Alex Buell <alex.buell@munted.org.uk>
> Reply-to: alex.buell@munted.org.uk
> To: David Miller <davem@davemloft.net>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: PING: David Miller - SPARC64
> Date: Fri, 12 Nov 2010 17:53:12 +0000
> 

[ snip ]

> I have a Sun Blade 2000 here with dual 1.2GHz processors, 2 x 73GB FC-AL
> disks, 4GB of RAM and a XVR-500 graphic adapter. I am quite happy with
> the machine, but for one very small problem. 
> 
> It seems that the XVR-500 console driver has a few problems. If I use
> the X11 fbdev 0.4.2 driver with xorg-server 1.7.7, in 8 bit colour
> depth, the X11 display looks quite corrupted. I have checked and the X11
> server is definitely running in 8 bit depth, same as the console. I am
> using the machine in 1600 x 1280 @ 76 video mode, set from PROM. After
> exiting from X11, console gets restored normally, everything works, I
> just get a severely corrupted display - but I can move the mouse and use
> the keyboard to log in as normal. Any ideas why what might be wrong? 
> 
> As a temporary workaround I just log onto the Blade via GDM from my
> laptop and everything looks OK in 24bit @ 1600x1200. 
> 
> I cannot even get the X11 fbdev driver to start in 24 bit as the X11
> fbdev driver fails with errors. Is it even possible to force the PROM to
> start in 24 bit depth? 
> 
> Perhaps I could do a nouveau and find how how the XVR-500 graphic
> adapter works? Just thinking things out here
-- 
Tactical Nuclear Kittens
