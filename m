From: Mikael Pettersson <mikpe@it.uu.se>
Date: Tue, 03 Jun 2008 07:35:52 +0000
Subject: [BUG] 2.6.26-rc1 broke X on SPARC Ultra5
Message-Id: <18500.62552.958244.633204@harpo.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

While investigating a report in linux.debian.ports.sparc
saying that X doesn't work with the 2.6.24 kernel, I noticed
that while X works for me with 2.6.25, 2.6.24, and Aurora's
2.6.23 kernels, it doesn't work with any 2.6.26-rcN (1<=N<=4)
kernel; with those it always fails with a

Fatal server error:
xf86MapPciMem: Could not mmap PCI memory [base=0xe2000000,hostbase=0xe2000000,size 00] (No such file or directory)

I'll start digging through 2.6.25->2.6.26-rc1 later today,
meanwhile I've put Xorg.0.log, Xorg strace, dmesg, and .config
files for 2.6.25 (working) and 2.6.26-rc4 (failing) in
<http://user.it.uu.se/~mikpe/linux/sparc64-2.6.26-rcN-xorg-bug/>.

/Mikael
