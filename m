From: "Antonino A. Daplas" <adaplas@hotpop.com>
Date: Mon, 14 Feb 2005 23:40:58 +0000
Subject: Re: [atyfb] No display on Sparc Ultra 10 with kernel 2.6.10-rc2 or later
Message-Id: <200502150741.01702.adaplas@hotpop.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200502140251.00645.aragorn@tiscali.nl> <200502150059.12789.adaplas@hotpop.com> <200502141855.29202.aragorn@tiscali.nl>
In-Reply-To: <200502141855.29202.aragorn@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Frans Pop <aragorn@tiscali.nl>, adaplas@pol.net
Cc: debian-sparc@lists.debian.org, sparclinux@vger.kernel.org, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tuesday 15 February 2005 01:55, Frans Pop wrote:
> Hello Tony,
>
> Thanks for your reaction.
>
> On Monday 14 February 2005 17:59, Antonino A. Daplas wrote:
> > The above timings are screwed.  This is 1024x768 at 85Hz INTERLACED.
> > The fb_find_mode() function picked up this mode when you specified
> > 1024x768@75, since there is no such mode in the mode database.
> > And the atyfb driver accepted the mode without differentiating between
> > interlaced and non-interlaced.
>
> Right. I tried with 1024x768@70 and that gives some improvement.
> For a very, very short time I see the Linux logo and some boot messages
> flash on the display, but then the monitor still goes into suspend.
>
> It really is just a flash, but I think I see some of the atyfb debug
> messages. That would indicate that the suspend is activated somewhere near
> the end of console initialization (maybe at the "switching to colour frame
> buffer device 128x48"?). But again, this is based on an impression.
>
> So it seems there are two bugs:
> - missing/incorrect default mode settings for sparc in the driver;
> - incorrect activation of suspend.

Try editing drivers/video/console/fbcon.c, look for the function
fbcon_startup(). After the line 'ops->currcon = -1;', insert this line:

ops->blank_state = -1;

Also, try changing the graphics state such as doing an
fbset -depth 16 or the like.

What happens if you switch consoles?

You can also try commenting out .fb_blank = atyfb_blank from
static struct fb_ops atyfb_ops and disable CONFIG_PM from your kernel
config.

>
> > PS:  There was also a massive atyfb update between 2.6.10-rc1 and rc2.
> > Here's the changelog:
>
> How best to proceed? Can you help?

I'll CC fbdev-devel list.

>
> Cheers,
> Frans Pop

Tony

>
>
> For comparison, here are the relevant lines from kern.log when
> booting with a Debian 2.6.8 kernel:
> atyfb: 3D RAGE (GT) [0x4754 rev 0x9a] 2M SGRAM, 14.31818 MHz XTAL, 200 MHz
> PLL, 67 Mhz MCLK fb0: ATY Mach64 frame buffer device on PCI
> Console: switching to mono PROM 80x34
> Console: switching to colour frame buffer device 144x56
>
> And here the lines from 2.6.10-rc2 with video=atyfb:1024x768@70:
> atyfb: 3D RAGE (Mach64 GT) [0x4754 rev 0x02]
> atyfb: 2M SGRAM (1:1), 14.31818 MHz XTAL, 200 MHz PLL, 67 Mhz MCLK, 67 MHz
> XCLK atyfb: setting up CRTC
> atyfb: set primary CRT to 1024x768 NN composite N
> atyfb: CRTC_H_TOTAL_DISP: 7f00a5
> atyfb: CRTC_H_SYNC_STRT_WID: 310082
> atyfb: CRTC_V_TOTAL_DISP: 2ff0325
> atyfb: CRTC_V_SYNC_STRT_WID: 260302
> atyfb: CRTC_OFF_PITCH: 20000000
> atyfb: CRTC_VLINE_CRNT_VLINE: 0
> atyfb: CRTC_GEN_CNTL: b000200
> atyfb: atyfb_set_par
> atyfb:  Set Visible Mode to 1024x768-8
> atyfb:  Virtual resolution 1024x2016, pixclock_in_ps 13373 (calculated
> 13373) atyfb:  Dot clock:           74 MHz
> atyfb:  Horizontal sync:     56 kHz
> atyfb:  Vertical refresh:    69 Hz
> atyfb:  x  style: 74.10398 1024 1048 1184 1328   768 771 777 806
> atyfb:  fb style: 13373  144 1024 24 136 29 768 3 6
> debug atyfb: Mach64 non-shadow register values:
> debug atyfb: 0x2000:  007F00A5 00310082 02FF0325 00260302
> debug atyfb: 0x2010:  01AA0000 20000000 08000020 0B000200
> debug atyfb: 0x2020:  00380727 0120051B 00000000 00000000
> debug atyfb: 0x2030:  00000000 00000031 00000000 00000000
> debug atyfb: 0x2040:  00000000 00000000 00000000 00000000
> debug atyfb: 0x2050:  00000000 00000000 00000000 00000000
> debug atyfb: 0x2060:  00000000 AAAAAA0F 00000000 00000000
> debug atyfb: 0x2070:  00000000 00000000 00003020 00000000
> debug atyfb: 0x2080:  00000000 00000000 00000000 00000000
> debug atyfb: 0x2090:  00A63000 00000000 00000000 00000000
> debug atyfb: 0x20A0:  7B23A040 00000000 00000000 05000001
> debug atyfb: 0x20B0:  004210B3 00010000 00010000 00000000
> debug atyfb: 0x20C0:  00FF0000 86010182 00000000 00000000
> debug atyfb: 0x20D0:  00000100 00000000 00000000 00003842
> debug atyfb: 0x20E0:  9A004754 0000001D 00000000 00000000
> debug atyfb: 0x20F0:  00000000 00008E0D E17FFCF8 00000000
>
> debug atyfb: Mach64 PLL register values:
> debug atyfb: 0x00:  CDD52414 A80341BC 8E82E701 A61B0000
> debug atyfb: 0x10:  CDD52414 A80341BC 8E82E701 A61B0000
> debug atyfb: 0x20:  CDD52414 A80341BC 8E82E701 A61B0000
> debug atyfb: 0x30:  CDD52414 A80341BC 8E82E701 A61B0000
>
> Console: switching to colour frame buffer device 128x48
> atyfb: fb0: ATY Mach64 frame buffer device on PCI



