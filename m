From: Christoph Hellwig <hch@lst.de>
Date: Sat, 01 Jun 2019 07:49:43 +0000
Subject: RFC: switch the remaining architectures to use generic GUP v2
Message-Id: <20190601074959.14036-1-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190525133203.25853-1-hch@lst.de>
In-Reply-To: <20190525133203.25853-1-hch@lst.de>
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

Changes since v1:
 - fix various issues found by the build bot
 - cherry pick and use the untagged_addr helper form Andrey
 - add various refactoring patches to share more code over architectures
 - move the powerpc hugepd code to mm/gup.c and sync it with the generic
   hup semantics
