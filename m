From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 13 May 2006 06:22:28 +0000
Subject: Re: Possible alignment issue in kernel's sha256 implementation
Message-Id: <20060512.232228.73054660.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.63.0605121941580.3617@bobcat>
In-Reply-To: <Pine.LNX.4.63.0605121941580.3617@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Fri, 12 May 2006 19:59:10 -0700 (PDT)

> 60 static inline void LOAD_OP(int I, u32 *W, const u8 *input)
> 61 {
> 62         W[I] = __be32_to_cpu( ((__be32*)(input))[I] );
> 63 }
 ...
> I cannot really determine how dangerous this is. It might be that the 
> cryptographic layer takes care of alignment, or the kernel will just 
> handle the unaligned access gracefully. In any case, I think it's worth 
> checking out by someone with more knowledge on the matter than myself.
> 
> [0] http://bugs.debian.org/366717

We allow kernel unaligned accesses to be fixed up transparently
by a relatively expensive trap handler, but we don't allow it for
user accesses.

Maybe the unaligned case cannot happen in the kernel for some
reason.

Herbert, is there anything which ensures 32-bit alignment
for the data accessed by LOAD_OP()?
