From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Fri, 26 Jul 2019 17:58:01 +0000
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
Message-Id: <14242f6d-e833-c5b7-3748-458f31039b84@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190625143715.1689-1-hch@lst.de>
 <20190625143715.1689-10-hch@lst.de> <20190717215956.GA30369@altlinux.org>
In-Reply-To: <20190717215956.GA30369@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Dmitry V. Levin" <ldv@altlinux.org>, Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Anatoly Pugachev <matorola@gmail.com>, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On 7/17/19 3:59 PM, Dmitry V. Levin wrote:
> Hi,
> 
> On Tue, Jun 25, 2019 at 04:37:08PM +0200, Christoph Hellwig wrote:
>> The sparc64 code is mostly equivalent to the generic one, minus various
>> bugfixes and two arch overrides that this patch adds to pgtable.h.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
>> ---
>>  arch/sparc/Kconfig                  |   1 +
>>  arch/sparc/include/asm/pgtable_64.h |  18 ++
>>  arch/sparc/mm/Makefile              |   2 +-
>>  arch/sparc/mm/gup.c                 | 340 ----------------------------
>>  4 files changed, 20 insertions(+), 341 deletions(-)
>>  delete mode 100644 arch/sparc/mm/gup.c
> 
> So this ended up as commit 7b9afb86b6328f10dc2cad9223d7def12d60e505
> (thanks to Anatoly for bisecting) and introduced a regression: 
> futex.test from the strace test suite now causes an Oops on sparc64
> in futex syscall
> 

I have been working on reproducing this problem but ran into a different
problem. I found 5.1 and newer kernels no longer boot on an S7 server or
in an ldom on a T7 server (kernel hangs after "crc32c_sparc64: Using
sparc64 crc32c opcode optimized CRC32C implementation" on console). A
long git bisect session between 5.0 and 5.1 pointed to commit
73a66023c937 ("sparc64: fix sparc_ipc type conversion") but that makes
no sense. I will keep working on finding root cause. I wonder if
Anatoly's git bisect result is also suspect.

--
Khalid
