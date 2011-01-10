From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 10 Jan 2011 19:32:51 +0000
Subject: Re: [PATCH] atyfb: Fix bootup hangs on sparc64.
Message-Id: <20110110193251.GA18541@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110105.130959.260100853.davem@davemloft.net>
In-Reply-To: <20110105.130959.260100853.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jan 10, 2011 at 12:20:37AM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Fri, 7 Jan 2011 23:41:51 +0100
> 
> > I tried to change resolution like this:
> > 
> > prom> setenv output-device=screen:x1024x768x70
> > prom> reset-all
> > 
> > I then used:
> > prom> cd /pci/SUNW,m64B
> > prom> .properties
> > 
> > This showed that the new resolution had been stored.
> > 
> > But this had no effect on he output :-(
> 
> Weird, because the atyfb code in atyfb_setup_sparc() is designed to
> explicitly respect the OpenFirmware resolution and refresh settings.
> 
> Can you make sure that:
> 
> 	dp = pci_device_to_OF_node(pdev);
> 	if (dp = of_console_device) {
> 
> check does in fact trigger?  The code protected by that conditional is
> the code that implements the importing of OpenFirmware's configured
> resolution.
This check is true.

I also tried hardcoding the values for vxres/vyres/bits_per_pixel => no effect.

If I read my printk's correct the screen output are "destroyed" when I enter
this code:

(in aty_init() )

        if (par->pll_ops->init_pll)
                par->pll_ops->init_pll(info, &par->pll);
        if (par->pll_ops->resume_pll)
                par->pll_ops->resume_pll(info, &par->pll);    <<<<<===
        /*
         * Last page of 8 MB (4 MB on ISA) aperture is MMIO,
         * unless the auxiliary register aperture is used.
         */
        if (!par->aux_start &&
            (info->fix.smem_len = 0x800000 ||
             (par->bus_type = ISA && info->fix.smem_len = 0x400000)))
                info->fix.smem_len -= GUI_RESERVE;

I see the debug printk just before:
debug atyfb: BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL DSP_CONFIG DSP_ON_OFF CLOCK_CNTL
debug atyfb: 7b33a040 86010102 10251a3b e000c81 03002200 ... 7405d4 00031400
debug atyfb: PLL ad d5 40 44 f9 03 01 a3 8e 9e 65 01 80 00 00 .. f6 ac 03 40 80 24 fd 00 00 00 02 0b ac 0b ac 14 24 fd 80

Note: This is with the Hewlett Packard hp 1502 LCD monitor connected.

[Typed from a video from my camera - beware of typing bugs]

... testing ...
If I comment out the call to resume_pll() then I no longer see garbled output.

My boot hangs a bit later - but this is unrelated (I think).
Can be due to my rootfs image.

I did not get it closer this time around.

	Sam
