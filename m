From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 04 Feb 2005 21:49:20 +0000
Subject: Xorg does not work on sparc32 in 2.6 (except on cg14)
Message-Id: <1107553760.3951.211.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

With a working pte_read, and VMALLOC_START set sanely, the next major
bug that Aurora users have noticed is that Xorg does not work on sparc32
hardware running 2.6, with one exception: Bob Breuer has been able to
get the cg14 to work.

My SS20 with a CG6 (TGX+) works fine in 2.4. When I attempt to run Xorg
in 2.6 (specifically, 2.6.11-rc2-bk3), the Xorg.0.log claims that it is
running, but the kernel has actually oopsed:

kernel BUG at arch/sparc/mm/srmmu.c:140!
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
Xorg(2681): Kernel bad trap [#1]
PSR: 404010c2 PC: f001d8c4 NPC: f001d8c8 Y: 00000000    Not tainted
PC: <srmmu_pte_pfn+0x24/0x30>
%G: 0000008c 404010e1  f01fd40c f0ab1e5c  f002be4c 00000008  f215e000
00000000
%O: 00000029 f01d43e8  0000008c 00000020  00000060 f00f33a0  f215fd18
f001d8bc
RPC: <srmmu_pte_pfn+0x1c/0x30>
%L: f215fd38 f3ea0d4c  f0288c00 00000000  f30fea2c f30f9b9c  00100100
00200200
%I: e2070026 00000ec0  503b0000 f002e938  00000060 f00f33a0  f215fd80
f0061974
Caller[f0061974]: copy_page_range+0x2fc/0x47c
Caller[f002e9f4]: copy_process+0x5b4/0xdd0
Caller[f002f2cc]: do_fork+0x4c/0x1d0
Caller[f0011120]: syscall_is_too_hard+0x34/0x40
Caller[501c835c]: 0x501c835c
Instruction DUMP: 901223e8  7fffd23c  9210208c <91d02005> 81c7e008
81e80000  9de3bf98  c4060000  033c0000

This is being triggered with the BUG() in this function in
arch/sparc/mm/srmmu.c:

static unsigned long srmmu_pte_pfn(pte_t pte)
{
        if (srmmu_device_memory(pte_val(pte))) {
                /* XXX Anton obviously had something in mind when he did
this.
                 * But what?
                 */
                /* return (struct page *)~0; */
                BUG();
        }
        return (pte_val(pte) & SRMMU_PTE_PMASK) >> (PAGE_SHIFT-4);
}

This is being BTFIXEDUP to pte_pfn. 

Removing the if (srmmu_device_memory(pte_val(pte))) check stops the
oops, but it doesn't make X work. The screen goes blank, but the X
session never appears.

I've got a couple of other framebuffer SBUS cards that I plan on
testing, but the only success report I have is from Bob's cg14. 

So, does anyone know whats happening here? Why would the cg14 work when
a cg6 does not? This isn't an Xorg config file error, as far as Xorg is
concerned, the X session is running, twm is in the ps tree, and an xterm
is open. The monitor is a stock Sun 15 inch, no special cabling.

Any and all help is appreciated.

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora Linux Project Leader

"If you are going through hell, keep going."
-- Sir Winston Churchill

