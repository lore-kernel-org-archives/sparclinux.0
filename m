From: Dave Hansen <dave.hansen@intel.com>
Date: Thu, 26 Mar 2020 23:10:56 +0000
Subject: Re: [PATCH 1/4] hugetlbfs: add arch_hugetlb_valid_size
Message-Id: <ae80063f-cef8-3141-3c6b-9130def5396a@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200318220634.32100-1-mike.kravetz@oracle.com>
 <20200318220634.32100-2-mike.kravetz@oracle.com>
 <831a0773-1ba6-4d72-44b9-7472123b8528@intel.com>
 <5aceea6a-8dc0-a44b-80c6-94511b5c75ca@oracle.com>
 <1c8b16c7-248e-b75f-96c6-eabc953c5066@intel.com>
 <530e6e11-ad1a-55bc-e61e-9da6eb7fea21@oracle.com>
In-Reply-To: <530e6e11-ad1a-55bc-e61e-9da6eb7fea21@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Shutemov,
 Kirill" <kirill.shutemov@intel.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Longpeng <longpeng2@huawei.com>, Will Deacon <will@kernel.org>, "David S.Miller" <davem@davemloft.net>

On 3/26/20 2:56 PM, Mike Kravetz wrote:
> Perhaps it would be best to check hugepages_supported() when parsing
> hugetlb command line options.  If not enabled, throw an error.  This
> will be much easier to do after moving all command line parsing to
> arch independent code.

Yeah, that sounds sane.

> Is that a sufficient way to address this concern?  I think it is a good
> change in any case.

(Thanks to Kirill for pointing this out.)

So, it turns out the x86 huge page enumeration is totally buggered.
X86_FEATURE_PSE is actually meaningless on 64-bit (and 32-bit PAE).  All
CPUs architecturally support 2MB pages regardless of X86_FEATURE_PSE and
the state of CR4.PSE.

So, on x86_64 at least, hugepages_supported() should *always* return 1.

1GB page support can continue to be dependent on X86_FEATURE_GBPAGES.
