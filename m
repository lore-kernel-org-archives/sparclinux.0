From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Mon, 27 Apr 2020 17:25:02 +0000
Subject: Re: [PATCH v3 2/4] hugetlbfs: move hugepagesz= parsing to arch independent code
Message-Id: <5a380060-38db-b690-1003-678ca0f28f07@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200417185049.275845-1-mike.kravetz@oracle.com>
 <20200417185049.275845-3-mike.kravetz@oracle.com>
 <7583dfcc-62d8-2a54-6eef-bcb4e01129b3@gmail.com>
In-Reply-To: <7583dfcc-62d8-2a54-6eef-bcb4e01129b3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Sandipan Das <sandipan.osd@gmail.com>
Cc: linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, Mina Almasry <almasrymina@google.com>, linux-s390@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Longpeng <longpeng2@huawei.com>, Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Nitesh Narayan Lal <nitesh@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S.Miller" <davem@davemloft.net>

On 4/26/20 10:04 PM, Sandipan Das wrote:
> Hi Mike,
>=20
> On 18/04/20 12:20 am, Mike Kravetz wrote:
>> Now that architectures provide arch_hugetlb_valid_size(), parsing
>> of "hugepagesz=3D" can be done in architecture independent code.
>> Create a single routine to handle hugepagesz=3D parsing and remove
>> all arch specific routines.  We can also remove the interface
>> hugetlb_bad_size() as this is no longer used outside arch independent
>> code.
>>
>> This also provides consistent behavior of hugetlbfs command line
>> options.  The hugepagesz=3D option should only be specified once for
>> a specific size, but some architectures allow multiple instances.
>> This appears to be more of an oversight when code was added by some
>> architectures to set up ALL huge pages sizes.
>>
>> [...]
>>
>> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage=
.c
>> index de54d2a37830..2c3fa0a7787b 100644
>> --- a/arch/powerpc/mm/hugetlbpage.c
>> +++ b/arch/powerpc/mm/hugetlbpage.c
>> @@ -589,21 +589,6 @@ static int __init add_huge_page_size(unsigned long =
long size)
>>  	return 0;
>>  }
>> =20
>> -static int __init hugepage_setup_sz(char *str)
>> -{
>> -	unsigned long long size;
>> -
>> -	size =3D memparse(str, &str);
>> -
>> -	if (add_huge_page_size(size) !=3D 0) {
>> -		hugetlb_bad_size();
>> -		pr_err("Invalid huge page size specified(%llu)\n", size);
>> -	}
>> -
>> -	return 1;
>> -}
>> -__setup("hugepagesz=3D", hugepage_setup_sz);
>> -
>> [...]
>=20
> This isn't working as expected on powerpc64.
>=20
>   [    0.000000] Kernel command line: root=3DUUID=DC7b49cf-95a2-4996-8e7d=
-7c64ddc7a6ff hugepagesz=16G hugepages=3D2=20
>   [    0.000000] HugeTLB: huge pages not supported, ignoring hugepagesz =
=3D 16G
>   [    0.000000] HugeTLB: huge pages not supported, ignoring hugepages =
=3D 2
>   [    0.284177] HugeTLB registered 16.0 MiB page size, pre-allocated 0 p=
ages
>   [    0.284182] HugeTLB registered 16.0 GiB page size, pre-allocated 0 p=
ages
>   [    2.585062]     hugepagesz=16G
>   [    2.585063]     hugepages=3D2
>=20
> The "huge pages not supported" messages are under a !hugepages_supported()
> condition which checks if HPAGE_SHIFT is non-zero. On powerpc64, HPAGE_SH=
IFT
> comes from the hpage_shift variable. At this point, it is still zero and =
yet
> to be set. Hence the check fails. The reason being hugetlbpage_init_defau=
lt(),
> which sets hpage_shift, it now called after hugepage_setup_sz().

Thanks for catching this Sandipan.

In the new arch independent version of hugepages_setup, I added the followi=
ng
code in patch 4 off this series:

> +static int __init hugepages_setup(char *s)
>  {
>  	unsigned long *mhp;
>  	static unsigned long *last_mhp;
> =20
> +	if (!hugepages_supported()) {
> +		pr_warn("HugeTLB: huge pages not supported, ignoring hugepages =3D %s\=
n", s);
> +		return 0;
> +	}
> +
>  	if (!parsed_valid_hugepagesz) {

In fact, I added it to the beginning of all the hugetlb command line parsing
routines.  My 'thought' was to warn early if hugetlb pages were not support=
ed.
Previously, the first check for hugepages_supported() was in hugetlb_init()
which ran after hugetlbpage_init_default().

The easy solution is to remove all the hugepages_supported() checks from
command line parsing routines and rely on the later check in hugetlb_init().

Another reason for adding those early checks was to possibly prevent the
preallocation of gigantic pages at command line parsing time.   Gigantic
pages are allocated at command line parsing time as they need to be allocat=
ed
with the bootmem allocator.  My concern is that there could be some strange
configuration where !hugepages_supported(), yet we allocate gigantic pages
from bootmem that can not be used or freeed later.

powerpc is the only architecture which has it's own alloc_bootmem_huge_page
routine.  So, it handles this potential issue.

I'll send out a fix shortly.
--=20
Mike Kravetz
