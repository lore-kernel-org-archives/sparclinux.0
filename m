From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Mon, 27 Apr 2020 19:09:47 +0000
Subject: Re: [PATCH v3 2/4] hugetlbfs: move hugepagesz= parsing to arch independent code
Message-Id: <b1f04f9f-fa46-c2a0-7693-4a0679d2a1ee@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200417185049.275845-1-mike.kravetz@oracle.com>
 <20200417185049.275845-3-mike.kravetz@oracle.com>
 <7583dfcc-62d8-2a54-6eef-bcb4e01129b3@gmail.com>
 <5a380060-38db-b690-1003-678ca0f28f07@oracle.com>
In-Reply-To: <5a380060-38db-b690-1003-678ca0f28f07@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Sandipan Das <sandipan.osd@gmail.com>
Cc: linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, Mina Almasry <almasrymina@google.com>, linux-s390@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Longpeng <longpeng2@huawei.com>, Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Nitesh Narayan Lal <nitesh@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S.Miller" <davem@davemloft.net>

On 4/27/20 10:25 AM, Mike Kravetz wrote:
> On 4/26/20 10:04 PM, Sandipan Das wrote:
>> On 18/04/20 12:20 am, Mike Kravetz wrote:
>>> Now that architectures provide arch_hugetlb_valid_size(), parsing
>>> of "hugepagesz=3D" can be done in architecture independent code.
>>
>> This isn't working as expected on powerpc64.
>>
>>   [    0.000000] Kernel command line: root=3DUUID=DC7b49cf-95a2-4996-8e7=
d-7c64ddc7a6ff hugepagesz=16G hugepages=3D2=20
>>   [    0.000000] HugeTLB: huge pages not supported, ignoring hugepagesz =
=3D 16G
>>   [    0.000000] HugeTLB: huge pages not supported, ignoring hugepages =
=3D 2
>>   [    0.284177] HugeTLB registered 16.0 MiB page size, pre-allocated 0 =
pages
>>   [    0.284182] HugeTLB registered 16.0 GiB page size, pre-allocated 0 =
pages
>>   [    2.585062]     hugepagesz=16G
>>   [    2.585063]     hugepages=3D2
>>
>=20
> In the new arch independent version of hugepages_setup, I added the follo=
wing
> code in patch 4 off this series:
>=20
>> +	if (!hugepages_supported()) {
>> +		pr_warn("HugeTLB: huge pages not supported, ignoring hugepages =3D %s=
\n", s);
>> +		return 0;
>> +	}
>> +
>=20
> The easy solution is to remove all the hugepages_supported() checks from
> command line parsing routines and rely on the later check in hugetlb_init=
().

Here is a patch to address the issue.  Sorry, as my series breaks all huget=
lb
command line processing on powerpc.

Sandipan, can you test the following patch?

From 480fe2847361e2a85aeec1fb39fe643bb7100a07 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Mon, 27 Apr 2020 11:37:30 -0700
Subject: [PATCH] hugetlbfs: fix changes to command line processing

Previously, a check for hugepages_supported was added before processing
hugetlb command line parameters.  On some architectures such as powerpc,
hugepages_supported() is not set to true until after command line
processing.  Therefore, no hugetlb command line parameters would be
accepted.

Remove the additional checks for hugepages_supported.  In hugetlb_init,
print a warning if !hugepages_supported and command line parameters were
specified.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1075abdb5717..5548e8851b93 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3212,8 +3212,11 @@ static int __init hugetlb_init(void)
 {
 	int i;
=20
-	if (!hugepages_supported())
+	if (!hugepages_supported()) {
+		if (hugetlb_max_hstate || default_hstate_max_huge_pages)
+			pr_warn("HugeTLB: huge pages not supported, ignoring associated command=
-line parameters\n");
 		return 0;
+	}
=20
 	/*
 	 * Make sure HPAGE_SIZE (HUGETLB_PAGE_ORDER) hstate exists.  Some
@@ -3315,11 +3318,6 @@ static int __init hugepages_setup(char *s)
 	unsigned long *mhp;
 	static unsigned long *last_mhp;
=20
-	if (!hugepages_supported()) {
-		pr_warn("HugeTLB: huge pages not supported, ignoring hugepages =3D %s\n"=
, s);
-		return 0;
-	}
-
 	if (!parsed_valid_hugepagesz) {
 		pr_warn("HugeTLB: hugepages=3D%s does not follow a valid hugepagesz, ign=
oring\n", s);
 		parsed_valid_hugepagesz =3D true;
@@ -3372,11 +3370,6 @@ static int __init hugepagesz_setup(char *s)
 	struct hstate *h;
=20
 	parsed_valid_hugepagesz =3D false;
-	if (!hugepages_supported()) {
-		pr_warn("HugeTLB: huge pages not supported, ignoring hugepagesz =3D %s\n=
", s);
-		return 0;
-	}
-
 	size =3D (unsigned long)memparse(s, NULL);
=20
 	if (!arch_hugetlb_valid_size(size)) {
@@ -3424,11 +3417,6 @@ static int __init default_hugepagesz_setup(char *s)
 	unsigned long size;
=20
 	parsed_valid_hugepagesz =3D false;
-	if (!hugepages_supported()) {
-		pr_warn("HugeTLB: huge pages not supported, ignoring default_hugepagesz =
=3D %s\n", s);
-		return 0;
-	}
-
 	if (parsed_default_hugepagesz) {
 		pr_err("HugeTLB: default_hugepagesz previously specified, ignoring %s\n"=
, s);
 		return 0;
--=20
2.25.4
