From: Christoph Hellwig <hch@lst.de>
Date: Tue, 11 Jun 2019 14:40:46 +0000
Subject: switch the remaining architectures to use generic GUP v3
Message-Id: <20190611144102.8848-1-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>
Cc: Nicholas Piggin <npiggin@gmail.com>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org

Hi Linus and maintainers,

below is a series to switch mips, sh and sparc64 to use the generic
GUP code so that we only have one codebase to touch for further
improvements to this code.  I don't have hardware for any of these
architectures, and generally no clue about their page table
management, so handle with care.

Changes since v2:
 - rebase to mainline to pick up the untagged_addr definition
 - fix the gup range check to be start <= end to catch the 0 length case
 - use pfn based version for the missing pud_page/pgd_page definitions
 - fix a wrong check in the sparc64 version of pte_access_permitted

Changes since v1:
 - fix various issues found by the build bot
 - cherry pick and use the untagged_addr helper form Andrey
 - add various refactoring patches to share more code over architectures
 - move the powerpc hugepd code to mm/gup.c and sync it with the generic
   hup semantics
