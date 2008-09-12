From: Josip Rodin <joy@entuzijast.net>
Date: Fri, 12 Sep 2008 00:40:14 +0000
Subject: Re: 16550 serial support
Message-Id: <20080912004014.GA11331@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Sep 11, 2008 at 04:46:12PM -0700, David Miller wrote:
> No... I think I see the problem.  Your suspicion about sunsu
> appears to be correct.
> 
> Both drivers want to register devices using major number TTY_MAJOR
> and minor number(s) 64, 65, etc.
> 
> So whichever driver gets it first succeeds, and then the other
> gets -EBUSY.
> 
> Here is a quick patch that might make it work.

OK, I did a clean rebuild and reboot, but no dice:

Serial: 8250/16550 driver4 ports, IRQ sharing disabled
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 00000000000001e1
tsk->{mm,active_mm}->pgd = fffff8103d624000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
modprobe(782): Oops [#1]
TSTATE: 0000000011009606 TPC: 0000000000580e8c TNPC: 0000000000580e90 Y: 00000000    Not tainted
TPC: <sunserial_register_minors+0x5c/0x68>
g0: 0000000000000b40 g1: 0000000000000002 g2: 0000000000000000 g3: 0000000000000000
g4: fffff8103d7169e0 g5: fffff8103f57c000 g6: fffff8103c878000 g7: 0000000000000000
o0: 0000000010059288 o1: 0000000000781922 o2: 0000000000000001 o3: 000000000072f250
o4: 000000000072f250 o5: 0000000000002000 sp: fffff8103c87b2a1 ret_pc: 0000000000455594
RPC: <printk+0x24/0x38>
l0: fffff8103c93e028 l1: 000000010000c000 l2: 000000010000c000 l3: 000000010000c000
l4: fffff8103f002800 l5: fffff8103f373eb4 l6: 0000000000000001 l7: 0000000000000000
i0: 0000000010059288 i1: 0000000000000004 i2: 0000000010057290 i3: 0000000000400000
i4: fffff8000000a040 i5: 0000000000000008 i6: fffff8103c87b361 i7: 000000001005e180
I7: <serial8250_init+0x88/0x158 [8250]>
Caller[000000001005e180]: serial8250_init+0x88/0x158 [8250]
Caller[0000000000426a78]: do_one_initcall+0x38/0x140
Caller[0000000000475d34]: sys_init_module+0x17f8/0x1954
Caller[0000000000406214]: linux_sparc_syscall32+0x34/0x40
Caller[00000000000133b4]: 0x133b4
Instruction DUMP: c206201c  c45e2038  82007fc0 <c220a088> 81cfe008  9138e000  81c3e008  90102001  81c3e008 

-- 
     2. That which causes joy or happiness.
