From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 25 Mar 2020 09:38:40 +0000
Subject: Re: [PATCH 1/4] hugetlbfs: add arch_hugetlb_valid_size
Message-Id: <505b3d0a-b754-ba56-0b98-b7551ef414be@de.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200318220634.32100-1-mike.kravetz@oracle.com>
 <20200318220634.32100-2-mike.kravetz@oracle.com>
 <831a0773-1ba6-4d72-44b9-7472123b8528@intel.com>
 <5aceea6a-8dc0-a44b-80c6-94511b5c75ca@oracle.com>
 <5ea6313e-ec4f-a043-632b-ef2901ce2cc9@huawei.com>
In-Reply-To: <5ea6313e-ec4f-a043-632b-ef2901ce2cc9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" <longpeng2@huawei.com>, Mike Kravetz <mike.kravetz@oracle.com>, Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, "David S.Miller" <davem@davemloft.net>



On 25.03.20 03:58, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
[...]
> Hi Mike,
> 
> Inspired by Dave's opinion, it seems the x86-specific hugepages_supported should
> also need to use cpu_feature_enabled instead.
> 
> Also, I wonder if the hugepages_supported is correct ? There're two arch
> specific hugepages_supported:
> x86:
> #define hugepages_supported() boot_cpu_has(X86_FEATURE_PSE)
> and
> s390:
> #define hugepages_supported() (MACHINE_HAS_EDAT1)
> 
> Is it possible that x86 has X86_FEATURE_GBPAGES but hasn't X86_FEATURE_GBPAGES
> or s390 has MACHINE_HAS_EDAT2 but hasn't MACHINE_HAS_EDAT1 ?

The s390 architecture says that 

When EDAT-2 applies, the following function is available in the DAT process:
 - EDAT-1 applies.
[..]

So if the machine has EDAT-2 it also has EDAT-1.
