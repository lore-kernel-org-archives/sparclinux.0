From: David Miller <davem@davemloft.net>
Date: Tue, 26 Apr 2016 02:46:28 +0000
Subject: Re: [PATCH V3 2/3] Implement byte-by-byte memory access facilitators
Message-Id: <20160425.224628.682746714119383786.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1461608888-5063-3-git-send-email-dave.kleikamp@oracle.com>
In-Reply-To: <1461608888-5063-3-git-send-email-dave.kleikamp@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 25 Apr 2016 22:48:45 +0200

> A simpler model would be
> #define LOADER(TYPE, addr)                         \
> ({                                                 \
> 	TYPE ret;                                  \
> 	memcpy(&ret, (void *)addr, sizeof(TYPE));  \
> 	ret;                                       \
> })
> 
> I would expect the compiler to optimize this away for archs
> that do not require aligned access.

The compiler is allowed to "look through" void pointer casts and
use the alignment guaranteed by the original types.

That is why memcpy()'s aren't used for unaligned access handling.

Take a look at include/linux/unaligned/packed_struct.h in the kernel
sources, which is in my opinion the most portable and efficient way to
deal with this problem.

That code does the right thing on both architectures where alignment
matters, and where it does not.
