From: Meelis Roos <mroos@linux.ee>
Date: Wed, 23 Mar 2005 13:53:26 +0000
Subject: sparc32: module with unresolved symbol causes oops in 2.6.12-rc1
Message-Id: <Pine.SOC.4.61.0503231549330.5000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

floppy module in 2.6.12-rc1 has an unresolved symbol floppy_hardint. I 
forgot that and did "modprobe floppy" nonetheless on my Sparcstation 20.
The result is an oops and panic. This tty_wakeup oops seems similar to 
the oops from "modprobe sg".

floppy: Unknown symbol floppy_hardint
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 00000546
tsk->{mm,active_mm}->pgd = fc0aa000
               \|/ ____ \|/
               "@'/ ,. \`@"
               /_| \__/ |_\
                  \__U_/
modprobe(905): Oops [#1]
PSR: 400000c0 PC: f00df4d0 NPC: f00df4d4 Y: 00000000    Not tainted
PC: <tty_wakeup+0x4/0x64>
%G: fb50fb10 f0034afc  00000001 404000e2  f0034aa0 00000000  fb50e000 00000001
%O: ffffffff 00000000  00000002 00000008  00000000 ffffc7d2  fb50fb20 f00116dc
RPC: <__udelay+0x1c/0x24>
%L: 409000c1 f003926c  f00347b8 00000008  00000010 00000000  f01f0400 50028660
%I: 00000000 00049000  ffffc7d3 00000100  00001000 f01a1624  fb50fb88 f0034afc
Caller[f0034afc]: tasklet_action+0x6c/0xb8
Caller[f00347b0]: __do_softirq+0xa0/0xc4
Caller[f0034814]: do_softirq+0x40/0x54
Caller[f00108e8]: patch_handler_irq+0x0/0x24
Caller[f0049714]: resolve_symbol+0x74/0x84
Caller[f0049b5c]: simplify_symbols+0xb8/0x12c
Caller[f004a914]: load_module+0x5a0/0xa58
Caller[f004ae58]: sys_init_module+0x64/0x23c
Caller[f00113bc]: syscall_is_too_hard+0x34/0x40
Caller[00012758]: 0x12758
Instruction DUMP: 81c3e008  90023fe7  9de3bf98 <c20620b8> 80886020  12800006  b
Kernel panic - not syncing: Aiee, killing interrupt handler!


-- 
Meelis Roos (mroos@linux.ee)
