From: Meelis Roos <mroos@linux.ee>
Date: Wed, 23 Mar 2005 21:17:54 +0000
Subject: Re: sunbmac panic when no card present
Message-Id: <Pine.SOC.4.61.0503232316120.10873@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0503221030220.29185@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0503221030220.29185@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Looking into it a little more now, uart_tasklet_action() in 
> drivers/serial/serial_core.c looks suspicious.  Meelis, can you add a 
> BUG_ON(state->info->tty=NULL) in the middle of uart_tasklet_action() and see 
> if it dies on that instead?

Yes, this BUG triggers and produces

sunbmac.c:v2.0 24/Nov/03 David S. Miller (davem@redhat.com)
eth1: BigMAC 100baseT Ethernet 08:00:20:72:8b:a1
kernel BUG at drivers/serial/serial_core.c:111!
               \|/ ____ \|/
               "@'/ ,. \`@"
               /_| \__/ |_\
                  \__U_/
klogd(344): Kernel bad trap [#1]
PSR: 404000c7 PC: f00f4a80 NPC: f00f4a84 Y: 00000000    Not tainted
PC: <uart_tasklet_action+0x2c/0x30>
%G: 0000006f f0195c00  f0195efc 40400fe5  f002f084 f0195c00  fbe14000 00000000
%O: 00000033 f017ea60  0000006f 00000000  00000000 501509e0  fbe15998 f00f4a78
RPC: <uart_tasklet_action+0x24/0x30>
%L: 40800fc0 f0011530  f0011534 00000001  00000000 65646861  fbe14000 50171e9c
%I: 00000000 00049000  fbe15de8 fbe15f38  50173de4 00000057  fbe15a00 f0034894
Caller[f0034894]: tasklet_action+0x6c/0xb8
Caller[f0034548]: __do_softirq+0xa0/0xc4
Caller[f00345ac]: do_softirq+0x40/0x54
Caller[f0010758]: patch_handler_irq+0x0/0x24
Caller[f01236e8]: memcpy_fromiovec+0xa8/0xc0
Caller[fe61a9bc]: unix_dgram_sendmsg+0x180/0x4ec [unix]
Caller[f011dd78]: sock_aio_write+0xe8/0x104
Caller[f006caa0]: do_sync_write+0x88/0xb4
Caller[f006cbd0]: vfs_write+0x104/0x11c
Caller[f006cc7c]: sys_write+0x30/0x64
Caller[f001122c]: syscall_is_too_hard+0x34/0x40
Caller[00012534]: 0x12534
Instruction DUMP: 9210206f  7ffc7810  90122260 <91d02005> 9de3bf98  e0062010  e2062014  c2042010  80a06000
Kernel panic - not syncing: Aiee, killing interrupt handler!


-- 
Meelis Roos (mroos@linux.ee)
