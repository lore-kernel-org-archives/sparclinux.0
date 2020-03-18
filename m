From: Dave Hansen <dave.hansen@intel.com>
Date: Wed, 18 Mar 2020 23:36:56 +0000
Subject: Re: [PATCH 1/4] hugetlbfs: add arch_hugetlb_valid_size
Message-Id: <1c8b16c7-248e-b75f-96c6-eabc953c5066@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200318220634.32100-1-mike.kravetz@oracle.com>
 <20200318220634.32100-2-mike.kravetz@oracle.com>
 <831a0773-1ba6-4d72-44b9-7472123b8528@intel.com>
 <5aceea6a-8dc0-a44b-80c6-94511b5c75ca@oracle.com>
In-Reply-To: <5aceea6a-8dc0-a44b-80c6-94511b5c75ca@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Longpeng <longpeng2@huawei.com>, Will Deacon <will@kernel.org>, "David S.Miller" <davem@davemloft.net>

On 3/18/20 3:52 PM, Mike Kravetz wrote:
> Sounds good.  I'll incorporate those changes into a v2, unless someone
> else with has a different opinion.
> 
> BTW, this patch should not really change the way the code works today.
> It is mostly a movement of code.  Unless I am missing something, the
> existing code will always allow setup of PMD_SIZE hugetlb pages.

Hah, I totally skipped over the old code in the diff.

It looks like we'll disable hugetblfs *entirely* if PSE isn't supported.
 I think this is actually wrong, but nobody ever noticed.  I think you'd
have to be running as a guest under a hypervisor that's lying about PSE
not being supported *and* care about 1GB pages.  Nobody does that.
