From: Kyle Moffett <mrmacman_g4@mac.com>
Date: Mon, 14 Mar 2005 00:21:09 +0000
Subject: [BUG?] Signedness of __kernel_nlink_t on Sparc?
Message-Id: <bbcd3873d9324ce185dc9eaf146ef741@mac.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Sparc Linux Mailing List <sparclinux@vger.kernel.org>, William Lee Irwin <wli@holomorphy.com>

In include/asm-sparc/types.h, __kernel_nlink_t is signed, whereas on 
all the
other architectures it is unsigned.  Is this intentional, or a bug?

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------

