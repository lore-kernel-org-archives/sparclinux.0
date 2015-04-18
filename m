From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 18 Apr 2015 05:47:05 +0000
Subject: sparc64: Build failure due to commit f1600e549b94 (sparc: Make sparc64 use scalable lib/iommu-common
Message-Id: <20150418054705.GA10746@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Sowmini Varadhan <sowmini.varadhan@oracle.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Hi all,

I see the following build failure when compiling sparc64:allmodconfig
in the upstream kernel (v4.0-7820-g04b7fe6a4a23).

arch/sparc/kernel/pci_sun4v.o:(.discard+0x1): multiple definition of `__pcpu_unique_iommu_pool_hash'
arch/sparc/kernel/iommu.o:(.discard+0x0): first defined here
make[2]: *** [arch/sparc/kernel/built-in.o] Error 1
make[1]: *** [arch/sparc/kernel] Error 2

The problem is caused by commit f1600e549b94 ("sparc: Make sparc64
use scalable lib/iommu-common.c functions"), which introduces 

static DEFINE_PER_CPU(unsigned int, iommu_pool_hash);

in both files.

DEFINE_PER_CPU translates to DEFINE_PER_CPU_SECTION, which in turn is
defined as

#define DEFINE_PER_CPU_SECTION(type, name, sec)                         \
        __PCPU_DUMMY_ATTRS char __pcpu_scope_##name;                    \
	extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;		\
-->	__PCPU_DUMMY_ATTRS char __pcpu_unique_##name;			\
	extern __PCPU_ATTRS(sec) __typeof__(type) name;			\
	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES __weak                 \
					        __typeof__(type) name

if CONFIG_DEBUG_FORCE_WEAK_PER_CPU is configured, which is the case here.
The marked line above shows that __pcpu_unique_iommu_pool_hash is declared as
global variable, which explains the problem (and makes me wonder what the
'static' keyword in front of DEFINE_PER_CPU is supposed to accomplish).

I thought about fixing the problem by renaming one of the variables, but
I am not sure if that is what is intended. Specifically, I am not sure if
the variables are supposed to be different, as it looks like, or if they
are supposed to be the same.

In case it is relevant, I use gcc version 4.6.3 for my build test.

Guenter
