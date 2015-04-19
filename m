From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Sun, 19 Apr 2015 18:36:25 +0000
Subject: Fwd: Re: sparc64: Build failure due to commit f1600e549b94 (sparc: Make sparc64 use scalable lib/iom
Message-Id: <20150419183625.GA18901@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org, aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Cc: sparclinux@vger.kernel.org, sowmini.varadhan@oracle.com, davem@davemloft.net, linux@roeck-us.net, linux-kernel@vger.kernel.org


> On (04/19/15 14:09), David Miller wrote:
>
> > On (04/18/15 21:23), Guenter Roeck wrote:
> >> lib/built-in.o:(.discard+0x1): multiple definition of
> >> `__pcpu_unique_iommu_pool_hash'
> >> arch/powerpc/kernel/built-in.o:(.discard+0x18): first defined here
> >> .. I get a similar failure in the
> >> powerpc:allmodconfig build
    :
> 
> Maybe ping the powerpc folks becuase if they can do a quick
> conversion, this change isn't necessary.

linuxppc-dev,

The disussion above [http://www.spinics.net/lists/sparclinux/msg13835.html]
is in reference to the issue that Guenter Roeck
identified. The problem is that we have a 
  static DEFINE_PER_CPU(unsigned int, iommu_pool_hash);
in both lib/iommu-common.c as well as arch/powerpc/kernel/iommu.c,
and as Guenter correctly pointed out,

" DEFINE_PER_CPU translates to DEFINE_PER_CPU_SECTION, which in turn is
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
  global variable"

This results in a build error for allmodconfig on powerpc, due to 
a multiple definition of __pcpu_unique_iommu_pool_hash.

Given that the goal is to use the functions in lib/iommu-common.c
as the Generic IOMMU pooled allocator that will be a superset of
functionality in arch/powerpc/kernel/iommu.c, DaveM suggested that I 
ping you to see if you can do a quick conversion to handle this
duplicate defintion, rather than rename iommu_pool_hash in iommu-common.c.

Would that be possible?

--Sowmini
