From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 25 May 2012 17:35:05 +0000
Subject: some testing sparc.git
Message-Id: <CA+=Fv5QPQ6_D_rrEDzx69AbPG6N69e-foS5SWgkiGdVKx0NvHg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I've pulled todays git from
git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

I'v build an smp kernel with some spin-lock and driver-dma debugging
stuff enabled. I've booted the kernel on my sparcstation-10 with dual
supersparc-II (sm71) cpu
The kernel boots and I can ssh into the system and it seems to run
fine with "normal" use. I do see frequent debug messages about "BUG:
scheduling while atomic: swapper/2/0/0x00000000".
Under more heavy load, like building a kernel with "make -j4" the
system will lock up after about 10 minutes, no error messages.

root:~# uname -a
Linux ss10 3.4.0-07645-g456d3d4-dirty #5 SMP Fri May 25 18:51:24 CEST
2012 sparc sun4m Texas Instruments, Inc. - SuperSparc-(II) GNU/Linux


regards

Magnus Lindholm
