From: Bernd Zeimetz <bernd@bzed.de>
Date: Sat, 27 Oct 2007 18:09:47 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <47237EEB.1030803@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Bernd Zeimetz wrote:
>>> For those who can reproduce it an have something like libnss-db
>>> enabled, try disabling it.
> 
> - disabled it
> - running vgdisplay killed the machine (wanted to create a new LV for a
> chroot....)... it's not accessible at all anymore, I think the kernel is
> a 2.6.23-something here, I'll build a recent one and give it a try
> again.... Will take some time as I need to build on USII...


I just wanted to write that I'm not able to reproduce this bug
anymore... but running aptitude -u often enough gave me this nice output:


titan:~# [ 2427.313946] BUG: soft lockup - CPU#3 stuck for 11s! [aptitude:13375]
[ 2427.389128] TSTATE: 0000000011009602 TPC: 000000000042f93c TNPC: 000000000042f7d0 Y: 00000000    Not tainted
[ 2427.506821] TPC: <__delay+0x1c/0x48>
[ 2427.549494] g0: 0000000000009000 g1: 000000000042f7d0 g2: 00000000aaaaaaaa g3: 0000000055555555
[ 2427.653670] g4: fffff8a00793c960 g5: fffff89fff994000 g6: fffff8a007dfc000 g7: 0000000000000000
[ 2427.757835] o0: 0000000000000020 o1: 0000000000000020 o2: 0000000000000000 o3: 0000000000000000
[ 2427.862001] o4: 000000000030a0d0 o5: 0000000000000000 sp: fffff8a007dff071 ret_pc: 000000000042f938
[ 2427.970337] RPC: <__delay+0x18/0x48>
[ 2428.013031] l0: 00000005a6cab647 l1: 0000000011009601 l2: 00000000004417a8 l3: 0000000000000400
[ 2428.117206] l4: 0000000000000000 l5: 0000000000000001 l6: 0000000000000000 l7: 0000000000000008
[ 2428.221374] i0: 0000000000000000 i1: fffff8a007dffa88 i2: 0000000000000004 i3: 0000000000000001
[ 2428.325538] i4: 00000000ffffffff i5: 0000000000000000 i6: fffff8a007dff131 i7: 00000000004417ec
[ 2428.429710] I7: <cheetah_xcall_deliver+0x1c0/0x23c>

and an unkillable, cpu-eating aptitude.


While retrieving some info using sysrq the machine froze after
echoing m into sysrq-trigger, producing this output while dieing:

[ 3680.006794] BUG: soft lockup - CPU#1 stuck for 11s! [pdflush:265]
[ 3680.078838] TSTATE: 0000000080009603 TPC: 00000000004417a8 TNPC: 00000000004417ac Y: 00000000    Not tainted
[ 3680.196551] TPC: <cheetah_xcall_deliver+0x17c/0x23c>
[ 3680.255881] g0: 0000000000000000 g1: 0000000000000000 g2: 000000000001869e g3: 0000000055555555
[ 3680.360055] g4: fffff8a0048e3260 g5: fffff89fff984000 g6: fffff8a00717c000 g7: 0000000000000000
[ 3680.464220] o0: 0000000000000020 o1: fffff8a00717f418 o2: fffff8a005a84040 o3: 0000000000000010
[ 3680.568384] o4: 0000000000000015 o5: 0000000000000000 sp: fffff8a00717eac1 ret_pc: 00000000004416e4
[ 3680.676719] RPC: <cheetah_xcall_deliver+0xb8/0x23c>
[ 3680.735042] l0: 0000000000000002 l1: 0000000000000002 l2: 0000000000000096 l3: 0000000000000000
[ 3680.839217] l4: ffffffffffffffff l5: fffff8a0048d3cd8 l6: 0000000000024098 l7: 00000000f7d31000
[ 3680.943382] i0: 000000000044d100 i1: 000000b0f60f8000 i2: 0000000000000000 i3: 0000000000000001
[ 3681.047548] i4: 0000000000000001 i5: 0000000000000001 i6: fffff8a00717eb81 i7: 0000000000442be4
[ 3681.151717] I7: <smp_flush_dcache_page_impl+0x21c/0x228>



Luckily much more output of sysrq is in the syslog, so I should be able to mail it later when the
machine is finished with rebooting (which takes some time...).


 2.6.24-rc1-git2 (SMP)
 gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)


titan:~# cat /proc/cpuinfo
cpu             : TI UltraSparc III (Cheetah)
fpu             : UltraSparc III integrated FPU
prom            : OBP 4.22.34 2007/07/23 13:01
type            : sun4u
ncpus probed    : 4
ncpus active    : 4
D$ parity tl1   : 0
I$ parity tl1   : 0
Cpu0ClkTck      : 000000002cb41780
Cpu1ClkTck      : 000000002cb41780
Cpu2ClkTck      : 000000002cb41780
Cpu3ClkTck      : 000000002cb41780
MMU Type        : Cheetah
State:
CPU0:           online
CPU1:           online
CPU2:           online
CPU3:           online



-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>

