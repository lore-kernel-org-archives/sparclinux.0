From: Pavel Begunkov <asml.silence@gmail.com>
Date: Mon, 21 Sep 2020 16:20:42 +0000
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Message-Id: <2f2ee014-688e-8835-369b-61deb0688c73@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200920151510.GS32101@casper.infradead.org>
 <76A432F3-4532-42A4-900E-16C0AC2D21D8@gmail.com>
In-Reply-To: <76A432F3-4532-42A4-900E-16C0AC2D21D8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: William Kucharski <kucharsk@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

On 20/09/2020 18:55, William Kucharski wrote:
> I really like that as it’s self-documenting and anyone debugging it can see what is actually being used at a glance.

Also creates special cases for things that few people care about,
and makes it a pain for cross-platform (cross-bitness) development.

> 
>> On Sep 20, 2020, at 09:15, Matthew Wilcox <willy@infradead.org> wrote:
>>
>> ﻿On Fri, Sep 18, 2020 at 02:45:25PM +0200, Christoph Hellwig wrote:
>>> Add a flag to force processing a syscall as a compat syscall.  This is
>>> required so that in_compat_syscall() works for I/O submitted by io_uring
>>> helper threads on behalf of compat syscalls.
>>
>> Al doesn't like this much, but my suggestion is to introduce two new
>> opcodes -- IORING_OP_READV32 and IORING_OP_WRITEV32.  The compat code
>> can translate IORING_OP_READV to IORING_OP_READV32 and then the core
>> code can know what that user pointer is pointing to.

-- 
Pavel Begunkov
