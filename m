From: "David S. Miller" <davem@redhat.com>
Date: Sun, 09 May 2004 00:14:00 +0000
Subject: Re: [PATCH] Use $(LD) -V for NEW_GAS check [4/4]
Message-Id: <20040508171400.480ac7a2.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040506224026.GD29131@triplehelix.org>
In-Reply-To: <20040506224026.GD29131@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 8 May 2004 14:04:43 -0700
joshk@triplehelix.org (Joshua Kwan) wrote:

> Line 433 in include/asm-sparc/unistd.h is a comment. Remember, I'm
> talking 2.6 here.

No, it's part of a macro definition in 2.6.x:

#define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4, \
	  type5,arg5) \
type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5) \
{ \
long __res; \
register long __g1 __asm__ ("g1") = __NR_##name; \
register long __o0 __asm__ ("o0") = (long)(arg1); \
register long __o1 __asm__ ("o1") = (long)(arg2); \
register long __o2 __asm__ ("o2") = (long)(arg3); \
register long __o3 __asm__ ("o3") = (long)(arg4); \
register long __o4 __asm__ ("o4") = (long)(arg5); \
__asm__ __volatile__ ("t 0x10\n\t" \
		      "bcc 1f\n\t" \
		      "mov %%o0, %0\n\t" \
		      "sub %%g0, %%o0, %0\n\t" \
		      "1:\n\t" \
		      : "=r" (__res), "=&r" (__o0) \
		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__o3), "r" (__o4), "r" (__g1) \
		      : "cc"); \
if (__res < -255 || __res>=0) \
	return (type) __res; \
errno = -__res; \
return -1; \
}
^^^^^ this is line 433
