From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Sun, 06 Jan 2008 10:03:02 +0000
Subject: Re: 2.6.24-rc6-mm1: sparc64: undefined reference to `vmemmap_table'
Message-Id: <200801061103.04999.m.kozlowski@tuxland.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <20071222233056.d652743e.akpm@linux-foundation.org>
In-Reply-To: <20071222233056.d652743e.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Hello,

	This is from allnoconfig on sparc64:

  LD      .tmp_vmlinux1
arch/sparc64/kernel/head.o: In function `kvmap_vmemmap':
(.text+0x34ec): undefined reference to `vmemmap_table'
arch/sparc64/kernel/head.o: In function `kvmap_vmemmap':
(.text+0x34f4): undefined reference to `vmemmap_table'
make: *** [.tmp_vmlinux1] Error 1

Regards,

	Mariusz

Linux sparc64 2.6.23 #2 SMP PREEMPT Fri Dec 21 21:20:01 CET 2007 sparc64 sun4u TI UltraSparc II (BlackBird) GNU/Linux
 
Gnu C                  4.1.2
Gnu make               3.81
binutils               2.18
util-linux             2.12r
mount                  2.12r
module-init-tools      3.4
e2fsprogs              1.40.3
Linux C Library        2.6.1
Dynamic linker (ldd)   2.6.1
Procps                 3.2.7
Net-tools              1.60
Kbd                    1.13
Sh-utils               6.9
udev                   115
