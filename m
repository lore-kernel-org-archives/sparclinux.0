From: Eric Brower <ebrower@gmail.com>
Date: Wed, 23 Mar 2005 02:42:10 +0000
Subject: Re: sunbmac panic when no card present
Message-Id: <ec7cefb050322184239166189@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0503221030220.29185@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0503221030220.29185@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I'm assuming your "qe/be" card is actually installed in this system, correct?

E


On Tue, 22 Mar 2005 10:32:48 +0200 (EET), Meelis Roos <mroos@linux.ee> wrote:
> Hi, this is 2.6.12-rc1 on Sparcstation 20 with no Sun BigMac card. I
> tried to load the sunbmac module anyway and this resulted in kernel
> panic:
> 
> sunbmac.c:v2.0 24/Nov/03 David S. Miller (davem@redhat.com)
> Unable to handle kernel NULL pointer dereference
> tsk->{mm,active_mm}->context = 000005ca
> tsk->{mm,active_mm}->pgd = fc0a4400
>                \|/ ____ \|/
>                "@'/ ,. \`@"
>                /_| \__/ |_\
>                   \__U_/
> modprobe(980): Oops [#1]
> PSR: 400000c3 PC: f00df4d0 NPC: f00df4d4 Y: 00000000    Not tainted
> PC: <tty_wakeup+0x4/0x64>
> %G: 00000008 f0034afc  00000001 404000e5  f0034aa0 00000000  fb864000 00000001
> %O: ffffffff 00000000  fff0f000 fff0f000  f01e8c00 f01f8400  fb865a28 f00116dc
> RPC: <__udelay+0x1c/0x24>
> %L: 40800fc4 f00116c0  f00116c4 00000010  00000000 00000000  fb864000 fe62dfff
> %I: 00000000 00049000  00000001 00000000  fe637ed4 fe637ed4  fb865a90 f0034afc
> Caller[f0034afc]: tasklet_action+0x6c/0xb8
> Caller[f00347b0]: __do_softirq+0xa0/0xc4
> Caller[f0034814]: do_softirq+0x40/0x54
> Caller[f00108e8]: patch_handler_irq+0x0/0x24
> Caller[f00cc61c]: prom_getproplen+0x4c/0x5c
> Caller[f00cc634]: prom_getproperty+0x8/0x80
> Caller[f00cc6c4]: prom_getint+0x18/0x34
> Caller[f00cc6ec]: prom_getintdefault+0xc/0x28
> Caller[fe61c2f0]: bigmac_ether_init+0x2f0/0x46c [sunbmac]
> Caller[fe61c554]: bigmac_probe+0x98/0xb4 [sunbmac]
> Caller[f004af98]: sys_init_module+0x1a4/0x23c
> Caller[f00113bc]: syscall_is_too_hard+0x34/0x40
> Caller[00012758]: 0x12758
> Instruction DUMP: 81c3e008  90023fe7  9de3bf98 <c20620b8> 80886020  12800006  b
> 
> (no more instruction dump fit into minicom window)
> 
> --
> Meelis Roos (mroos@linux.ee)
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
E
