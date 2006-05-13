From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 13 May 2006 02:59:10 +0000
Subject: Possible alignment issue in kernel's sha256 implementation
Message-Id: <Pine.LNX.4.63.0605121941580.3617@bobcat>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Yesterday a bug was discovered in Debian's application, which uses the 
sha256 implementation virtually identical to the one available in kernel 
[0]. An unaligned access in sha256 code was causing a bus error on sparc. 
The offending code also present in the 2.6.17-rc3 crypto/sha256.c in the 
following form:

60 static inline void LOAD_OP(int I, u32 *W, const u8 *input)
61 {
62         W[I] = __be32_to_cpu( ((__be32*)(input))[I] );
63 }

This function is only called from sha256_transform(), which is called only 
from sha256_update(), which, in turn, is exposed to the kernel's 
cryptographic API layer. I believe that if a u8 array not aligned on 
4-byte boundary is passed as a second argument ('data') to that function, 
it will cause an unaligned memory access in LOAD_OP.

I cannot really determine how dangerous this is. It might be that the 
cryptographic layer takes care of alignment, or the kernel will just 
handle the unaligned access gracefully. In any case, I think it's worth 
checking out by someone with more knowledge on the matter than myself.

[0] http://bugs.debian.org/366717

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
