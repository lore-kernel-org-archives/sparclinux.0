From: Ron Murray <murrayr@dor.state.ma.us>
Date: Fri, 15 Oct 2004 15:13:12 +0000
Subject: Re: E250 console on kernel 2.6.8.1
Message-Id: <416FE908.8010808@dor.state.ma.us>
List-Id: <sparclinux.vger.kernel.org>
References: <416D3441.5090702@dor.state.ma.us>
In-Reply-To: <416D3441.5090702@dor.state.ma.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

RChan wrote:
> I used to have this working even with home-made kernels before my E250 
> died.
> Can I suggest you try the Aurora kernels from www.auroralinux.org - they 
> are around
> 2.6.8 by now. If that works then you might wish to compare .config to see
> if something is missing in yours.

    Thank you. I tried that, but they don't seem to have included the 
pm2fb driver. And I've searched the net, and haven't found anyone else 
using it on a 2.6 kernel either.

    I've come to the conclusion that the permedia2 FB driver is broken 
in 2.6(.8?), at least when it comes to the Raptor GFX board in an E250. 
The system will boot, but nothing gets displayed on the screen (the 
monitor doesn't see any signal at this point). I did get the thing to 
boot with the PROM console, and can log in that way (after I figured out 
how to disable console keymaps). But the glint X driver doesn't work 
under these conditions (it segfaults), and neither does the X 
framebuffer driver (it segfaults too). Both work under a 2.4 kernel 
(although glint has real problems).

    So I'm going back to 2.4 kernels for now. At least they work.

    One thing I found while working on this is that I had to enable 
SERIAL_SUNSU and SERIAL_SUNSU_CONSOLE before I got a functioning 
keyboard and mouse (never noticed till I got the prom console going). 
Surprisingly, the default config under arch/sparc64 didn't see fit to 
include them.


**********************************************************************
This email and any files transmitted with it are confidential and 
intended solely for the use of the individual or entity to whom they   
are addressed. If you have received this email in error please notify 
the system manager at postmaster at dor.state.ma.us.
**********************************************************************

