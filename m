From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Wed, 27 Jan 2016 22:29:49 +0000
Subject: [RFC] hugepages on sparc
Message-Id: <56A944DD.3060809@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I wanted to use 4M hugepages but found that kernel only supports
non-HW backed 8M hugepages on SPARC. I see the change was made by this
commit: http://permalink.gmane.org/gmane.linux.ports.sparc/18407

I'm not a hugepage expert but as I understand, this change in default
hugepage size is due to the way transparent hugepage (THP) is
implemented, which looks at memory in PMD size increments and PMD
happens to be 8M aligned. Correct? If this THP design is the only
reason why we have moved from 4M to 8M as default hugepage size then I
think it would be better to fix THP instead.

THP code in mm/huge_memory.c also seems to assume an x86 style page
table (depends on "PMD" size etc.). This seems not ideal for
architectures like SPARC where any data structure like hash table can
be used for page tables. So, shouldn't THP code be using some API to
figure out hugepage backing status of a memory area?

Do you think it would be worth fixing THP as above (remove constrain
for hugepage to be PMD aligned) to at least allow enabling hw-backed
hugepage size as default again?

The whole notion of "default hugepage size" looks weird to me. Ideally
there should be equivalent support for all (most?) hw-backed
hugepapges and THP should be able to work with all kernel supported
pages.

Thanks,
Nitin
