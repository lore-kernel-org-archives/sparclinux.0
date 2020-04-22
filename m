From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Wed, 22 Apr 2020 16:56:03 +0000
Subject: Re: [PATCH v3 3/4] hugetlbfs: remove hugetlb_add_hstate() warning for existing hstate
Message-Id: <d39a33da-6095-c616-6bff-6af8795922d1@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200417185049.275845-1-mike.kravetz@oracle.com>
 <20200417185049.275845-4-mike.kravetz@oracle.com>
 <87blnj4x9p.fsf@linux.ibm.com>
In-Reply-To: <87blnj4x9p.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Xu <peterx@redhat.com>, Paul Mackerras <paulus@samba.org>, Will Deacon <will@kernel.org>, Mina Almasry <almasrymina@google.com>, Jonathan Corbet <corbet@lwn.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Longpeng <longpeng2@huawei.com>, Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, Christophe Leroy <christophe.leroy@c-s.fr>, Nitesh Narayan Lal <nitesh@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, "David S.Miller" <davem@davemloft.net>

On 4/22/20 3:42 AM, Aneesh Kumar K.V wrote:
> Mike Kravetz <mike.kravetz@oracle.com> writes:
>=20
>> The routine hugetlb_add_hstate prints a warning if the hstate already
>> exists.  This was originally done as part of kernel command line
>> parsing.  If 'hugepagesz=3D' was specified more than once, the warning
>> 	pr_warn("hugepagesz=3D specified twice, ignoring\n");
>> would be printed.
>>
>> Some architectures want to enable all huge page sizes.  They would
>> call hugetlb_add_hstate for all supported sizes.  However, this was
>> done after command line processing and as a result hstates could have
>> already been created for some sizes.  To make sure no warning were
>> printed, there would often be code like:
>> 	if (!size_to_hstate(size)
>> 		hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT)
>>
>> The only time we want to print the warning is as the result of command
>> line processing.
>=20
> Does this patch break hugepages=3Dx command line? I haven't tested this
> yet. But one of the details w.r.t. skipping that hugetlb_add_hstate is
> to make sure we can configure the max_huge_pages.=20
>=20

Are you asking about hugepages=3Dx being the only option on the command lin=
e?
If so, then the behavior is not changed.  This will result in x pages of
default huge page size being allocated.  Where default huge page size is of
course architecture dependent.  On an x86 VM,

[    0.040474] Kernel command line: BOOT_IMAGE=3D/vmlinuz-5.6.0-mm1+ root=
=3D/dev/mapper/fedora_new--host-root ro rd.lvm.lv=FEdora_new-host/root rd.l=
vm.lv=FEdora_new-host/swap console=3Dtty0 console=3DttyS0,115200 audit=3D0 =
transparent_hugepage=3Dalways hugepages=128
[    0.332618] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.333245] HugeTLB registered 2.00 MiB page size, pre-allocated 128 pag=
es

BTW - Here are the command line options I tested on x86 with this series.

No errors or warnings
---------------------
hugepages=128
hugepagesz=3D2M hugepages=128
default_hugepagesz=3D2M hugepages=128
hugepages=128 default_hugepagesz=3D2M
hugepagesz=3D1G hugepages=3D2
hugepages=3D2 default_hugepagesz=3D1G
default_hugepagesz=3D1G hugepages=3D2
hugepages=128 hugepagesz=3D1G hugepages=3D2
hugepagesz=3D1G hugepages=3D2 hugepagesz=3D2M hugepages=128
default_hugepagesz=3D2M hugepages=128 hugepagesz=3D1G hugepages=3D2
hugepages=128 default_hugepagesz=3D2M hugepagesz=3D1G hugepages=3D2
hugepages=3D2 default_hugepagesz=3D1G hugepagesz=3D2M hugepages=128
default_hugepagesz=3D1G hugepages=3D2 hugepagesz=3D2M hugepages=128
default_hugepagesz=3D2M hugepagesz=3D2M hugepages=128
default_hugepagesz=3D2M hugepagesz=3D1G hugepages=3D2 hugepagesz=3D2M hugep=
ages=128

Error or warning
----------------
hugepages=128 hugepagesz=3D2M hugepages%6
hugepagesz=3D2M hugepages=128 hugepagesz=3D2M hugepages%6
default_hugepagesz=3D2M hugepages=128 hugepagesz=3D2M hugepages%6
hugepages=128 hugepages%6
hugepagesz=3D2M hugepages=128 hugepages=3D2 default_hugepagesz=3D1G

--=20
Mike Kravetz
