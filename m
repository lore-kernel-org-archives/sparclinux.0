From: Ben Collins <bcollins@debian.org>
Date: Tue, 24 Feb 2004 18:29:58 +0000
Subject: Re: oops in sched_init() on E3000
Message-Id: <20040224182958.GK468@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040222043448.GG703@holomorphy.com>
In-Reply-To: <20040222043448.GG703@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Feb 23, 2004 at 02:02:42AM -0800, William Lee Irwin III wrote:
> On Sun, 22 Feb 2004 14:10:41 -0800 William Lee Irwin III <wli@holomorphy.com> wrote:
> >> I get the same tftpbooting your vmlinux run through elftoaout, this
> >> time with -p. Does elftoaout look like the culprit?
> 
> On Sun, Feb 22, 2004 at 03:17:39PM -0800, David S. Miller wrote:
> > It very well might be, let me tool around with this and study your
> > logs over the next day or so, I have some other things I really want
> > to finish first.
> > Meanwhile you can pick one of your 10 disks to install on :)
> > Thanks Will.

Well, I started trying to get back to looking at this, and my current
setup on my e3000 doesn't even get to the same point anymore (esp
timeouts). Now I'm getting this:

data_access_exception: SFSR[0000000000801009] SFAR[000002903ffdd378], going.
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(1): Dax [#1]
TSTATE: 0000004480009605 TPC: 00000000004452bc TNPC: 00000000004452c0 Y: 00000000    Not tainted
TPC: <copy_process+0x95c/0xaa0>
g0: 00000000005f1c00 g1: 00000000005e3e60 g2: 0000000000000001 g3: 0000000000000012
g4: fffff8003ffd1700 g5: 0000000000000003 g6: fffff8003ff94000 g7: 0000000000000003
o0: 0000000000000004 o1: fffff8003ffe28e8 o2: 0000000000000007 o3: 0000000000000000
o4: 0000000000000020 o5: 00ff00ff00ff00ff sp: fffff8003ff96e01 ret_pc: 00000000004452a8
RPC: <copy_process+0x948/0xaa0>
l0: fffff8003ffe2898 l1: 0000000000800100 l2: 004452903ffdd378 l3: 00000000005e3e40
l4: fffff8003ffc7848 l5: 000000000066c000 l6: 00000000005e3e48 l7: 000000000000232e
i0: fffff8003ffc7720 i1: fffff8003ff97211 i2: fffff8003ff97970 i3: 0000000000000000
i4: fffff8003ffc4850 i5: fffff8003ff979e0 i6: fffff8003ff96ef1 i7: 0000000000445424
I7: <do_fork+0x24/0x200>
Caller[0000000000445424]: do_fork+0x24/0x200
Caller[0000000000416fc4]: sparc_do_fork+0x44/0x60
Caller[0000000000410cb4]: linux_sparc_syscall+0x34/0x44
Caller[000000000045aaec]: kthread_create+0xec/0x120
Caller[000000000063d570]: smp_boot_one_cpu+0x10/0x160
Caller[000000000063dbac]: __cpu_up+0xc/0xc0
Caller[000000000063fff0]: cpu_up+0x90/0x120
Caller[0000000000638674]: smp_init+0x154/0x180
Caller[0000000000414144]: init+0x44/0x1e0
Caller[00000000004171d0]: kernel_thread+0x30/0x60
Caller[0000000000414030]: rest_init+0x10/0x60
Instruction DUMP: e45ce030  02c48009  e0772048 <c2048000> 80a06000  02400043  110016fa  90102001  4002b25

I'm not sure if this is because I now have 6gigs of ram as opposed to
when I only had 4gigs, but I tried doing mem24M and that didn't help.
I'm going to pull two boards and see if booting with 2gigs of phys ram
and only 2 cpu's will help any.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
