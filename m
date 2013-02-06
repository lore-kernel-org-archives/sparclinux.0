From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 06 Feb 2013 14:20:42 +0000
Subject: get_user_pages_fast and sparc THP
Message-Id: <87d2wda61h.fsf@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Hi Dave,

Don't we need to handle THP splitting condition in gup_pmd_range in case
of sparc ?. Other archs do have

		if (pmd_none(pmd) || pmd_trans_splitting(pmd))
			return 0;
		if (unlikely(pmd_large(pmd))) {
			if (!gup_huge_pmd(pmd, addr, next, write, pages, nr))
				return 0;

-aneesh

