From: Bob Breuer <breuerr@mc.net>
Date: Wed, 23 Mar 2005 16:21:42 +0000
Subject: Re: sunbmac panic when no card present
Message-Id: <42419796.2040805@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0503221030220.29185@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0503221030220.29185@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Meelis Roos wrote:
> PSR: 400010c6 PC: f00df4d0 NPC: f00df4d4 Y: 00000000    Not tainted
> PC: <tty_wakeup+0x4/0x64>
> %G: 00000000 f0034afc  00000001 404010e0  f0034aa0 00000000  fac12000 00000001
> %O: ffffffff 00000000  00000000 00000000  00000001 fb8d68a0  fac13b00 f00116dc
> RPC: <__udelay+0x1c/0x24>
> %L: fbe00f8c fbe00f34  d034fa4d 00000008  fb341006 fbe00f34  fac12000 f0011098
> %I: 00000000 00049000  00000003 00000924  00000004 00000004  fac13b68 f0034afc
> Caller[f0034afc]: tasklet_action+0x6c/0xb8
> Caller[f00347b0]: __do_softirq+0xa0/0xc4
> Caller[f0034814]: do_softirq+0x40/0x54

Looks like some tasklet is calling tty_wakeup with a NULL tty.  I have 
seen this before when using serial console, but didn't track it down 
once I got a framebuffer console working.

Looking into it a little more now, uart_tasklet_action() in 
drivers/serial/serial_core.c looks suspicious.  Meelis, can you add a 
BUG_ON(state->info->tty=NULL) in the middle of uart_tasklet_action() 
and see if it dies on that instead?

Bob
