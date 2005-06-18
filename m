From: Raphael Assenat <raph@raphnet.net>
Date: Sat, 18 Jun 2005 02:10:30 +0000
Subject: atyfb hsync polarity on sparc64
Message-Id: <20050618021029.GJ20191@midgar.lan.raphnet.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
I have decided to switch to the 2.6 kernel series on my Sun Ultra 10
workstation. I have compiled, installed and booted 2.6.11.12, but
the framebuffer console does not work. The machine comes up correctly 
(I can ping and ssh), but the display stays blank, without sync.

When using 2.4.25, the frambuffer worked perfectly. I decided to compare
the output given by fbset on 2.4 and 2.6:

Using 2.4.25:

mode "1152x900-66"
    # D: 94.224 MHz, H: 61.665 kHz, V: 65.811 Hz
    geometry 1152 900 1152 3612 8
    timings 10613 190 58 31 2 128 4
    hsync high
    csync high
    accel true
    rgba 8/0,8/0,8/0,0/0
endmode

Using 2.6.11.12:

mode "1152x900-66"
    # D: 94.224 MHz, H: 61.665 kHz, V: 65.811 Hz
    geometry 1152 900 1152 3612 8
    timings 10613 190 58 31 2 128 4
    csync high
    accel true
    rgba 8/0,8/0,8/0,0/0
endmode

As you may have noticed, the only difference is that on 2.6, the hsync
is not high.

Next I tried issuing the fbset -hsync high, but the screen stayed blank,
and fbset still did not report the hsync as being high, as if something
somewhere was preventing it.

I looked at the source file drivers/video/aty/atyfb_base.c and
discovered that the hsync polarity parameter was indeed forced to
another value at line 923:

913		if(vdisplay < 400) {
914         h_sync_pol = 1;
915         v_sync_pol = 0;
916     } else if(vdisplay < 480) {
917         h_sync_pol = 0;
918         v_sync_pol = 1;
919     } else if(vdisplay < 768) {
920         h_sync_pol = 0;
921         v_sync_pol = 0;
922     } else {
923         h_sync_pol = 1;
924         v_sync_pol = 1;
925     }

I dont know why this code was required, but some the sync flags passed 
to the driver via the sync member of struct fb_var_screeninfo are ignored
because of it.

I commented this block of code, and now my framebuffer is fully functional :)

Do you have any suggestions about what I should do next?


In any case, here is the patch^H^H^H^H^Hhack:

--- linux-2.6.11.12/drivers/video/aty/atyfb_base.c  2005-04-29 21:29:44.000000000 -0400
+++ linux-2.6.11.12-raph/drivers/video/aty/atyfb_base.c 2005-06-17 20:48:38.000000000 -0400
@@ -909,7 +909,7 @@
    if ((par->lcd_table != 0) && (crtc->lcd_gen_cntl & LCD_ON))
        vdisplay  = par->lcd_height;
 #endif
-
+#if 0 // RAPH
    if(vdisplay < 400) {
        h_sync_pol = 1;
        v_sync_pol = 0;
@@ -923,7 +923,7 @@
        h_sync_pol = 1;
        v_sync_pol = 1;
    }
-
+#endif
    v_disp--;
    v_sync_strt--;
    v_sync_end--;
