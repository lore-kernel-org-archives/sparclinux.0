From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 29 Jun 2017 19:32:56 +0000
Subject: Re: Access to older 64-bit sparcs for developers
Message-Id: <5b2ff33f-770e-28c3-4a09-50666215d35e@ilande.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1706271559250.28262@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1706271559250.28262@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 29/06/17 16:23, David Miller wrote:

> From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Date: Thu, 29 Jun 2017 08:18:40 +0100
> 
>> Is that using drm at all?
> 
> Using DRM fully.

So I guess it must be something that bochs_drm is specifically doing?
With a bit more poking today I managed to get the stacktrace from QEMU
trying to initialise the bochs_drm device (please excuse the extra
debugging printks):


[   14.442315] boch addr: 1ff21000000  fbmap: 000001ff21000000  mmio:
000001ff22000000
[   14.443209] [drm] Found bochs VGA, ID 0xb0c5.
[   14.443808] [drm] Framebuffer size 16384 kB @ 0x1ff21000000, mmio @
0x1ff22000000.
[   14.455617] [TTM] Zone  kernel: Available graphics memory: 252816 kiB
[   14.457582] [TTM] Initializing pool allocator
[   14.594986] MCA drm_fb_helper_sys_imageblit
[   14.595148] MCA: sys_imageblit to 000001ff21000000
[   14.595938] Unable to handle kernel paging request at virtual address
000001ff21000000
[   14.596008] tsk->{mm,active_mm}->context = 0000000000000000
[   14.596070] tsk->{mm,active_mm}->pgd = fffff80000402000
[   14.596134]               \|/ ____ \|/
[   14.596134]               "@'/ .. \`@"
[   14.596134]               /_| \__/ |_\
[   14.596134]                  \__U_/
[   14.596197] swapper/0(1): Oops [#1]
[   14.597167] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0-rc7+ #42
[   14.597397] task: fffff8001c097800 task.stack: fffff8001c09c000
[   14.597490] TSTATE: 0000000080001607 TPC: 00000000006f3afc TNPC:
00000000006f3b08 Y: 00000000    Not tainted
[   14.598443] TPC: <sys_imageblit+0x1dc/0x438>
[   14.598686] g0: 0000000000000080 g1: fffff8001c38c000 g2:
0000000000000000 g3: 0000000000000007
[   14.598753] g4: fffff8001c097800 g5: fffff8001ecea000 g6:
fffff8001c09c000 g7: 000000000090dfc0
[   14.598818] o0: 0000000000000026 o1: 0000000000000001 o2:
000000000000000f o3: 000001ff21000000
[   14.598883] o4: 0000000000000007 o5: 0000000000000008 sp:
fffff8001c09e0a1 ret_pc: 0000000000000001
[   14.599337] RPC: <0x1>
[   14.599504] l0: 0000000000000020 l1: fffff8001f807728 l2:
0000000000000080 l3: 0000000000000001
[   14.599570] l4: 0000000000b93800 l5: 0000000000000080 l6:
0000000000000030 l7: 0000000000000000
[   14.599635] i0: fffff8001c346800 i1: fffff8001c38c000 i2:
0000000000000000 i3: 0000000000000000
[   14.599701] i4: 0000000000000001 i5: 000001ff21000000 i6:
fffff8001c09e151 i7: 000000000073806c
[   14.599794] I7: <drm_fb_helper_sys_imageblit+0x14/0x34>
[   14.599973] Call Trace:
[   14.600245]  [000000000073806c] drm_fb_helper_sys_imageblit+0x14/0x34
[   14.600366]  [00000000006e6b74] soft_cursor+0x174/0x19c
[   14.600408]  [00000000006e661c] bit_cursor+0x45c/0x490
[   14.600449]  [00000000006e3124] fbcon_cursor+0x16c/0x17c
[   14.600493]  [0000000000710e38] hide_cursor+0x2c/0xa8
[   14.600532]  [0000000000711fd4] redraw_screen+0xc4/0x208
[   14.600573]  [00000000006e2200] fbcon_prepare_logo+0x288/0x358
[   14.600613]  [00000000006e26a4] fbcon_init+0x3d4/0x448
[   14.600653]  [00000000007112bc] visual_init+0xa4/0x100
[   14.600694]  [0000000000712a78] do_bind_con_driver+0x1c8/0x300
[   14.600734]  [0000000000712f24] do_take_over_console+0x170/0x198
[   14.600775]  [00000000006e279c] do_fbcon_takeover+0x84/0xe8
[   14.600826]  [00000000004747dc] notifier_call_chain+0x38/0x74
[   14.600871]  [0000000000474a5c] __blocking_notifier_call_chain+0x28/0x44
[   14.600920]  [00000000006ec0ec] register_framebuffer+0x2b8/0x2ec
[   14.600961]  [0000000000739888] drm_fb_helper_initial_config+0x2d0/0x36c


Ultimately what it comes down to is that bochs_hw_init() maps the
framebuffer like this:

  bochs->fb_map = ioremap(addr, size);
  if (bochs->fb_map = NULL) {
      DRM_ERROR("Cannot map framebuffer\n");
      return -ENOMEM;
  }

And in arch/sparc/include/asm/io_64.h:

  /* On sparc64 we have the whole physical IO address space accessible
   * using physically addressed loads and stores, so this does nothing.
   */
  static inline void __iomem *ioremap(unsigned long offset, unsigned
  long size)
  {
      return (void __iomem *)offset;
  }

This physical address bubbles all the way up to sys_imageblit() which
tries to write to the pointer returned from ioremap() which of course
faults.

Having a look at the drm documentation at
https://01.org/linuxgraphics/gfx-docs/drm/driver-api/device-io.html the
recommendation is to use ioremap() although there is also mention of a
pci_iomap() function.

Unfortunately pci_iomap() also falls back to ioremap() even for PCI
memory BARs so I'm a little unsure as to exactly where the problem lies
- any pointers?


ATB,

Mark.

