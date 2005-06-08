From: Jurij Smakov <jurij@wooyd.org>
Date: Wed, 08 Jun 2005 03:18:56 +0000
Subject: Re: nuke string.h micro-optimizations from orbit
Message-Id: <Pine.LNX.4.61.0506072314090.3817@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <20050607031302.GA2621@holomorphy.com>
In-Reply-To: <20050607031302.GA2621@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 6 Jun 2005, William Lee Irwin III wrote:

> I got a bit heavy-handed as suggested and just blew away the whole lot
> of macro wrappers etc. I did leave around some of the asm called from
> there but am plotting to nuke them as well after making sure we aren't
> trying to BTFIXUP code that doesn't exist.
>
> Anyhow, if anyone's up for trying this (I patched vs. 2.6.12-rc5-mm2
> but can rediff against 2.6.12-rc6 in the unlikely event it rejects)
> I suspect it may help 32B alignment problems, though in principle
> we could just perform the alignment checks.

Hi William,

I have tried the patch on 2.6.12-rc6 (it applies cleanly). The initrd is 
mounted successfully then, however it oopses immediately after that. 
Here's the log:

RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 2580KiB [1 disk] into ram disk... done.
VFS: Mounted root (cramfs filesystem) readonly.
VFS: Cannot open root device "sda1" or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(0,0)
  <0>Press Stop-A (L1-A) to return to the boot prom
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 00000000
tsk->{mm,active_mm}->pgd = fc000800
               \|/ ____ \|/
               "@'/ ,. \`@"
               /_| \__/ |_\
                  \__U_/
swapper(1): Oops [#1]
PSR: 1e0010c0 PC: f00f3b94 NPC: f00f3b98 Y: 00000000    Not tainted
PC: <tty_wakeup+0x4/0x64>
%G: 00000000 f0036680  00000001 1e4010e2  f0036624 00000000  f428e000 00000001
%O: ffffffff 00000000  00000000 00002000  00000000 fffffffe  f428fa58 f00117e0
RPC: <__udelay+0x1c/0x24>
%L: 00000000 f022ca30  00000001 f022e4f8  00000009 f022c800  f022c800 f0222400
%I: 00000000 0007fc00  f428fb40 80808080  00153fc0 00000000  f428fac0 f0036680
Caller[f0036680]: tasklet_action+0x6c/0xb8
Caller[f0036334]: __do_softirq+0xa0/0xc4
Caller[f0036398]: do_softirq+0x40/0x54
Caller[f00109ec]: patch_handler_irq+0x0/0x24
Caller[f00117e0]: __udelay+0x1c/0x24
Caller[f003011c]: panic+0x14c/0x15c
Caller[f01fe364]: sun4m_init+0x210/0x328
Caller[f02014f8]: inflate_dynamic+0x660/0x71c
Caller[f0201658]: inflate_block+0xa4/0x13c
Caller[f01fe5b4]: sun4c_continue_boot+0x138/0x324
Caller[f0010190]: init+0xf8/0x104
Caller[f0014ed0]: kernel_thread+0x34/0x50
Caller[f0010024]: rest_init+0x10/0x24
Caller[f01fdf08]: _etext+0x5fac0/0x5fbb8
Caller[f01fd790]: _etext+0x5f348/0x5fbb8
Caller[00000000]: start+0xfffc000/0x10
Instruction DUMP: 81c3e008  90023fe7  9de3bf98 <c20620b8> 80886020  12800006  b2102001  b0062934  b4102001
Kernel panic - not syncing: Aiee, killing interrupt handler!
  <0>Press Stop-A (L1-A) to return to the boot prom

I haven't investigated that yet. I also plan to try a config without 
initrd, to see what happens there.

Thanks and best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
