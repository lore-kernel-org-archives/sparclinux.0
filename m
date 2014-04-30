From: David Miller <davem@davemloft.net>
Date: Wed, 30 Apr 2014 21:54:20 +0000
Subject: [PATCH 0/10] Sparc64 MM bug fixes
Message-Id: <20140430.175420.1944889075484067093.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This is the current state of my audit of the sparc64 mm code.

Some of these changes have to do with THP, but some do not.

I've started to add some better checking of page table sanity,
in the hopes that it will potentially help further diagnosis
of any problems that still can be triggered.

In particular, pmd_bad() and pud_bad() now actually do something :)

If those exit_mmap() WARN_ON()'s still trigger, I'll have to code up a
more sophisticated debugging patch I guess.  My current idea is to
have a debugging function which walks the page tables counting PTE
tables (under suitable locks), and validates that mm->nr_ptes matches
this count.  Then we can sprinkle calls to this debugging function at
various critical spots, such as fault entry and exit, and around major
MM operations that potentially adjust page tables.

Actually, if I implement that facility, the first iteration I'd have
simply check only at free_pgtables() entry.  That way we can learn
quickly if we enter free_pgtables() with the counter already
corrupted, or if it gets corrupted by the unmaps done by
free_pgtables() itself.

Anyways, please let me know how well these patches work and if they
make any difference for your problems at all.  THP enabled and THP
disabled results are both extremely useful.

Thanks!
