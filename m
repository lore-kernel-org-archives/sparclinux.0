From: "Blue Swirl" <blueswir1@hotmail.com>
Date: Thu, 11 Nov 2004 20:15:16 +0000
Subject: Re: Patch to Proll to run in ROM, Qemu support
Message-Id: <BAY12-F33aKtKufVma00005f144@hotmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20041111114549.6696c40a.davem@davemloft.net>
In-Reply-To: <20041111114549.6696c40a.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>It certainly could be.  It could decrease the reboot debugging
>cycle, if anything.

Well, how about this:
time ./sparc-softmmu/qemu-system-sparc -L .. -kernel vmlinux-2.6.8.1.elf 
 >/dev/null
warning: could not open /dev/net/tun: no virtual network emulation
Segmentation fault

real    0m1.440s
user    0m0.330s
sys     0m0.100s

Qemu startup, Proll boot, Linux start and crash in 1.4 seconds. The crash 
happens at srmmu_allocate_ptable_skeleton. Unfortunately attaching a native 
remote GDB debugger to emulated kernel target is not working completely yet, 
but debugging host Qemu is OK.

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.com/

