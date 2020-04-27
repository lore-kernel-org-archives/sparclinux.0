From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Mon, 27 Apr 2020 20:31:06 +0000
Subject: Re: [PATCH v3 2/4] hugetlbfs: move hugepagesz= parsing to arch independent code
Message-Id: <b34270b7-fa9b-ce2c-20bc-84279ce6ea59@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200417185049.275845-1-mike.kravetz@oracle.com>
 <20200417185049.275845-3-mike.kravetz@oracle.com>
 <7583dfcc-62d8-2a54-6eef-bcb4e01129b3@gmail.com>
 <5a380060-38db-b690-1003-678ca0f28f07@oracle.com>
 <b1f04f9f-fa46-c2a0-7693-4a0679d2a1ee@oracle.com>
 <20200427131802.3d132055a59535a0e6780e9f@linux-foundation.org>
In-Reply-To: <20200427131802.3d132055a59535a0e6780e9f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, Mina Almasry <almasrymina@google.com>, linux-s390@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Longpeng <longpeng2@huawei.com>, Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Nitesh Narayan Lal <nitesh@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Sandipan Das <sandipan.osd@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, linuxppc-dev@lists.ozlabs.org, "David S.Miller" <davem@davemloft.net>

On 4/27/20 1:18 PM, Andrew Morton wrote:
> On Mon, 27 Apr 2020 12:09:47 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
>> Previously, a check for hugepages_supported was added before processing
>> hugetlb command line parameters.  On some architectures such as powerpc,
>> hugepages_supported() is not set to true until after command line
>> processing.  Therefore, no hugetlb command line parameters would be
>> accepted.
>>
>> Remove the additional checks for hugepages_supported.  In hugetlb_init,
>> print a warning if !hugepages_supported and command line parameters were
>> specified.
> 
> This applies to [4/4] instead of fixing [2/4].  I guess you'll
> straighten that out in v4?

Yes.

> btw, was
> http://lkml.kernel.org/r/CADYN=9Koefrq9H1Y82Q8nMNbeyN4tzhEfvDu5u=sVFjFZCYorA@mail.gmail.com
> addressed?

Yes, you pulled a patch into your tree to address this.
hugetlbfs-remove-hugetlb_add_hstate-warning-for-existing-hstate-fix.patch

I'll send out a v4 with both these issues addressed.  Would like to wait
until receiving confirmation from someone who can test on powerpc.
-- 
Mike Kravetz
