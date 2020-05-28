From: Jerome Glisse <jglisse@redhat.com>
Date: Thu, 28 May 2020 00:20:33 +0000
Subject: Cache flush issue with page_mapping_file() and swap back shmem page ?
Message-Id: <20200528002033.GB1992500@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
List-Id: <sparclinux.vger.kernel.org>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Huang Ying <ying.huang@intel.com>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org, Paul Burton <paulburton@kernel.org>, Helge Deller <deller@gmx.de>, James Hogan <jhogan@kernel.org>, rmk+kernel@arm.linux.org.uk, linux-xtensa@linux-xtensa.org, Steven Capper <steve.capper@linaro.org>, Rabin Vincent <rabinv@axis.com>, Ley Foon Tan <lftan@altera.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-parisc@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, nios2-dev@lists.rocketboards.org, "David S. Miller" <davem@davemloft.net>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

So any arch code which uses page_mapping_file() might get the wrong
answer, this function will return NULL for a swap backed page which
can be a shmem pages. But shmem pages can still be shared among
multiple process (and possibly at different virtual addresses if
mremap was use).

Attached is a patch that changes page_mapping_file() to return the
shmem mapping for swap backed shmem page. I have not tested it (no
way for me to test all those architecture) and i spotted this while
working on something else. So i hope someone can take a closer look.

Cheers,
J=E9r=F4me

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: attachment;
	filename="0001-mm-fix-cache-flush-for-shmem-page-that-are-swap-back.patch"
Content-Transfer-Encoding: quoted-printable

From 6c76b9f8baa87ff872f6be5a44805a74c1e07fea Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?J=3DC3=3DA9r=3DC3=3DB4me=3D20Glisse?=3D <jglisse@redhat.c=
om>
Date: Wed, 27 May 2020 20:18:59 -0400
Subject: [PATCH] mm: fix cache flush for shmem page that are swap backed.
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

This might be a shmem page that is in a sense a file that
can be mapped multiple times in different processes at
possibly different virtual addresses (fork + mremap). So
return the shmem mapping that will allow any arch code to
find all mappings of the page.

Note that even if page is not anonymous then the page might
have a NULL page->mapping field if it is being truncated,
but then it is fine as each pte poiting to the page will be
remove and cache flushing should be handled properly by that
part of the code.

Signed-off-by: J=E9r=F4me Glisse <jglisse@redhat.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
---
 mm/util.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 988d11e6c17c..ec8739ab0cc3 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -685,8 +685,24 @@ EXPORT_SYMBOL(page_mapping);
  */
 struct address_space *page_mapping_file(struct page *page)
 {
-	if (unlikely(PageSwapCache(page)))
+	if (unlikely(PageSwapCache(page))) {
+		/*
+		 * This might be a shmem page that is in a sense a file that
+		 * can be mapped multiple times in different processes at
+		 * possibly different virtual addresses (fork + mremap). So
+		 * return the shmem mapping that will allow any arch code to
+		 * find all mappings of the page.
+		 *
+		 * Note that even if page is not anonymous then the page might
+		 * have a NULL page->mapping field if it is being truncated,
+		 * but then it is fine as each pte poiting to the page will be
+		 * remove and cache flushing should be handled properly by that
+		 * part of the code.
+		 */
+		if (!PageAnon(page))
+			return page->mapping;
 		return NULL;
+	}
 	return page_mapping(page);
 }
=20
--=20
2.26.2


--/04w6evG8XlLl3ft--
