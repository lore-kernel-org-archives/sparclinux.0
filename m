From: Meelis Roos <mroos@linux.ee>
Date: Wed, 23 Mar 2005 14:55:53 +0000
Subject: Re: sunbmac panic when no card present
Message-Id: <Pine.SOC.4.61.0503231646160.5000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0503221030220.29185@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0503221030220.29185@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

> There are three such prom_getintdefault() calls in bigmac_ether_init(),
> Meelis can you try commenting them out one by one to see which one trigge=
rs
> the crash?  Perhaps that bp->qec_sdev or bp->bigmac_sdev pointers are
> corrupt or point to structures which don't have their prom_node values
> setup properly.  A comparison of the prom_node values with /usr/sbin/prtc=
onf -pv
> output would determine this.

I commented all of them out and replaced with assingment of default=20
values and printk of the parameters. It still oopses but now in another=20
place (tty_wakeup as all my oopsen).

If I removed only first two occurences, the oops moved to the third one=20
(offset changed).

This is an excerpt from prtconf output for comparision.

             Node 0xffd767d0
                 #channels:  00000001
                 ranges:  00000000.00000000.00000001.00030000.00004000.0000=
0010.00000000.00000001.00010000.00008000.00000020.00000000.00000001.0001800=
0.00008000
                 reg:  00000001.00020000.00010000.00000001.00040000.00020000
                 model: 'SUNW,270-2450'
                 name: 'qec'

                 Node 0xffd77960
                     board-version:  00000001
                     reg:  00000000.00000000.00004000.00000010.00000000.000=
08000.00000020.00000000.00008000
                     device_type: 'network'
                     intr:  00000037.00000000
                     interrupts:  00000004
                     address-bits:  00000030
                     max-frame-size:  00004000
                     channel#:  00000000
                     name: 'be'

ffd767d0 seems to be a correct prom_node for qec and
ffd77960 seems to be a correct prom_node for be.
ffd5c0e0 is the prom node for 'sbus' (so qec_sdev->bus->prom_node is=20
also OK). So nothing suspicious here?

sunbmac.c:v2.0 24/Nov/03 David S. Miller (davem@redhat.com)
qec_sdev->prom_node=FFd767d0
qec_sdev->bus=F085e200
qec_sdev->bus->prom_node=FFd5c0e0
bigmac_sdev =3D f0a54800
bigmac_sdev->prom_node =3D ffd77960
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context =3D 0000092f
tsk->{mm,active_mm}->pgd =3D fc09b400
               \|/ ____ \|/
               "@'/ ,. \`@"
               /_| \__/ |_\
                  \__U_/
khelper(1395): Oops [#1]
PSR: 400010c6 PC: f00df4d0 NPC: f00df4d4 Y: 00000000    Not tainted
PC: <tty_wakeup+0x4/0x64>
%G: 00000000 f0034afc  00000001 404010e0  f0034aa0 00000000  fac12000 00000=
001
%O: ffffffff 00000000  00000000 00000000  00000001 fb8d68a0  fac13b00 f0011=
6dc
RPC: <__udelay+0x1c/0x24>
%L: fbe00f8c fbe00f34  d034fa4d 00000008  fb341006 fbe00f34  fac12000 f0011=
098
%I: 00000000 00049000  00000003 00000924  00000004 00000004  fac13b68 f0034=
afc
Caller[f0034afc]: tasklet_action+0x6c/0xb8
Caller[f00347b0]: __do_softirq+0xa0/0xc4
Caller[f0034814]: do_softirq+0x40/0x54
Caller[f00108e8]: patch_handler_irq+0x0/0x24
Caller[f00774e0]: count+0x68/0x84
Caller[f00787c0]: do_execve+0xa0/0x1d8
Caller[f0014c9c]: sparc_execve+0x44/0x84
Caller[f00113bc]: syscall_is_too_hard+0x34/0x40
Caller[f003fba8]: ____call_usermodehelper+0x30/0xa4
Caller[f0014d10]: kernel_thread+0x34/0x50
Caller[f003fcd0]: __call_usermodehelper+0x34/0x74
Caller[f00400f8]: worker_thread+0x19c/0x258
Caller[f0044988]: kthread+0x9c/0xb4
Caller[f0014d10]: kernel_thread+0x34/0x50
Caller[f00449b0]: keventd_create_kthread+0x10/0x50
Caller[00000004]: 0x4
Instruction DUMP: 81c3e008  90023fe7  9de3bf98 <c20620b8> 80886020  1280000=
6  b
Kernel panic - not syncing: Aiee, killing interrupt handler!
  <0>Press L1-A to return to the boot prom


--=20
Meelis Roos (mroos@linux.ee)
