From: Sandipan Das <sandipan.osd@gmail.com>
Date: Mon, 27 Apr 2020 05:16:36 +0000
Subject: Re: [PATCH v3 2/4] hugetlbfs: move hugepagesz= parsing to arch independent code
Message-Id: <7583dfcc-62d8-2a54-6eef-bcb4e01129b3@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200417185049.275845-1-mike.kravetz@oracle.com>
 <20200417185049.275845-3-mike.kravetz@oracle.com>
In-Reply-To: <20200417185049.275845-3-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, Mina Almasry <almasrymina@google.com>, linux-s390@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Longpeng <longpeng2@huawei.com>, Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Nitesh Narayan Lal <nitesh@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>

Hi Mike,

On 18/04/20 12:20 am, Mike Kravetz wrote:
> Now that architectures provide arch_hugetlb_valid_size(), parsing
> of "hugepagesz=3D" can be done in architecture independent code.
> Create a single routine to handle hugepagesz=3D parsing and remove
> all arch specific routines.  We can also remove the interface
> hugetlb_bad_size() as this is no longer used outside arch independent
> code.
>=20
> This also provides consistent behavior of hugetlbfs command line
> options.  The hugepagesz=3D option should only be specified once for
> a specific size, but some architectures allow multiple instances.
> This appears to be more of an oversight when code was added by some
> architectures to set up ALL huge pages sizes.
>=20
> [...]
>=20
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index de54d2a37830..2c3fa0a7787b 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -589,21 +589,6 @@ static int __init add_huge_page_size(unsigned long l=
ong size)
>  	return 0;
>  }
> =20
> -static int __init hugepage_setup_sz(char *str)
> -{
> -	unsigned long long size;
> -
> -	size =3D memparse(str, &str);
> -
> -	if (add_huge_page_size(size) !=3D 0) {
> -		hugetlb_bad_size();
> -		pr_err("Invalid huge page size specified(%llu)\n", size);
> -	}
> -
> -	return 1;
> -}
> -__setup("hugepagesz=3D", hugepage_setup_sz);
> -
> [...]

This isn't working as expected on powerpc64.

  [    0.000000] Kernel command line: root=3DUUID=DC7b49cf-95a2-4996-8e7d-7=
c64ddc7a6ff hugepagesz=16G hugepages=3D2=20
  [    0.000000] HugeTLB: huge pages not supported, ignoring hugepagesz =3D=
 16G
  [    0.000000] HugeTLB: huge pages not supported, ignoring hugepages =3D 2
  [    0.284177] HugeTLB registered 16.0 MiB page size, pre-allocated 0 pag=
es
  [    0.284182] HugeTLB registered 16.0 GiB page size, pre-allocated 0 pag=
es
  [    2.585062]     hugepagesz=16G
  [    2.585063]     hugepages=3D2

The "huge pages not supported" messages are under a !hugepages_supported()
condition which checks if HPAGE_SHIFT is non-zero. On powerpc64, HPAGE_SHIFT
comes from the hpage_shift variable. At this point, it is still zero and yet
to be set. Hence the check fails. The reason being hugetlbpage_init_default=
(),
which sets hpage_shift, it now called after hugepage_setup_sz().


- Sandipan
