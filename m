From: "Art Haas" <ahaas@airmail.net>
Date: Mon, 05 Apr 2004 19:10:29 +0000
Subject: Re: CG6 Framebuffer questions
Message-Id: <20040405191029.GB5004@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040402013009.GB23279@artsapartment.org>
In-Reply-To: <20040402013009.GB23279@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Apr 01, 2004 at 07:30:09PM -0600, Art Haas wrote:
> Hi.
> 
> [ ... snip screenbuffer problems using CG6 driver ... ]
> 

Hi.

I'm still digging into the failure of the screen to blank, and after
adding a few printk() statements I'm more puzzled. What appears to be
happening is the screen blanks then immediately unblanks. Below is
some edited output from my printk() addition. The 'do_blank_screen()'
call is in 'drivers/char/vt.c', which calls 'fbcon_blank()' in
'drivers/video/console/fbcon.c', which then calls 'fb_blank()' in
'drivers/video/fbmem.c', and finally calls 'cg6_blank()' in
'drivers/video/cg6.c'. When 'blank' is 1, the screen blanks itself, and
when blank is 0, the screen unblanks. Unblanking starts with
'do_unblank_screen()' in 'drivers/char/vt.c', from there on the code
path is the same. Here's the output:

13:04:51 kernel: do_blank_scrren(): entering_gfx = 0
13:04:51 kernel: calling sw->con_blank() ...
13:04:51 kernel: in fbcon_blank(): blank = 1, mode_switch = 0
13:04:51 kernel: has fb_blank() ...
13:04:51 kernel: in fb_blank() => blank: 1
13:04:51 kernel: cg6_blank(): blank: 1
13:04:51 kernel: sw->con_blank returned 0
13:04:51 kernel: vesa_blank_mode: 0
13:04:51 kernel: unblank_screen() ...
13:04:51 kernel: do_unblank_screen(): leaving_gfx = 0
13:04:51 kernel: blankinterval: 180000
13:04:51 kernel: calling sw->con_blank() ...
13:04:51 kernel: in fbcon_blank(): blank = 0, mode_switch = 0
13:04:51 kernel: has fb_blank() ...
13:04:51 kernel: in fb_blank() => blank: 0
13:04:51 kernel: cg6_blank(): blank: 0

I'm adding more printk() statements, and am looking at how the
automatic blanking is supposed to work with console_work/console_callback
stuff in 'drivers/char/vt.c' looking like the code to examime, but I'm
so far baffled as to why unblanking is called immediately after
blanking. Anyone on the list have knowledge of framebuffer code workings
that they could pass on?

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
