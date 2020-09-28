From: Jann Horn <jannh@google.com>
Date: Mon, 28 Sep 2020 12:14:11 +0000
Subject: SPARC version of arch_validate_prot() looks broken (UAF read)
Message-Id: <CAG48ez3YsfTfOFKa-Po58e4PNp7FK54MFbkK3aUPSRt3LWtxQA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, Khalid Aziz <khalid.aziz@oracle.com>, Khalid Aziz <khalid@gonehiking.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, Anthony Yznaga <anthony.yznaga@oracle.com>, Andrew Morton <akpm@linux-foundation.org>

From what I can tell from looking at the code:

SPARC's arch_validate_prot() looks up the VMA and peeks at it; that's
not permitted though. do_mprotect_pkey() calls arch_validate_prot()
before taking the mmap lock, so we can hit use-after-free reads if
someone concurrently deletes a VMA we're looking at.

Additionally, arch_validate_prot() currently only accepts the start
address as a parameter, but the SPARC code probably should be checking
the entire given range, which might consist of multiple VMAs?

I'm not sure what the best fix is here; it kinda seems like what SPARC
really wants is a separate hook that is called from inside the loop in
do_mprotect_pkey() that iterates over the VMAs? So maybe commit
9035cf9a97e4 ("mm: Add address parameter to arch_validate_prot()")
should be reverted, and a separate hook should be created?

(Luckily the ordering of the vmacache operations works out such that
AFAICS, despite calling find_vma() without holding the mmap_sem, we
can never end up establishing a vmacache entry with a dangling pointer
that might be considered valid on a subsequent call. So this should be
limited to a rather boring UAF data read, and not be exploitable for a
UAF write or UAF function pointer read.)
