From: Dave Anderson <anderson@redhat.com>
Date: Mon, 25 Apr 2016 22:58:40 +0000
Subject: Re: [Crash-utility] [PATCH V3 2/3] Implement byte-by-byte memory access facilitators
Message-Id: <1320531728.64608529.1461625120481.JavaMail.zimbra@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



----- Original Message -----
> On 04/25/2016 03:48 PM, Sam Ravnborg wrote:
> > Hi Dave.
> > 
> >> Sparc64 requires type-aligned memory access. Since data buffers may not
> >> be properly aligned, implement a safe copy from memory per data type.
> >>
> >> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> >> ---
> >>  defs.h |   41 +++++++++++++++++++++++++++++++++++++++++
> >>  1 files changed, 41 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/defs.h b/defs.h
> >> index e3afc58..d9d4559 100644
> >> --- a/defs.h
> >> +++ b/defs.h
> >> @@ -2187,6 +2187,45 @@ struct builtin_debug_table {
> >>   *  Facilitators for pulling correctly-sized data out of a buffer at a
> >>   *  known address.
> >>   */
> >> +
> >> +#ifdef NEED_ALIGNED_MEM_ACCESS
> >> +
> >> +#define DEF_LOADER(TYPE)			\
> >> +static inline TYPE				\
> >> +load_##TYPE (char *addr)			\
> >> +{						\
> >> +	TYPE ret;				\
> >> +	size_t i = sizeof(TYPE);		\
> >> +	while (i--)				\
> >> +		((char *)&ret)[i] = addr[i];	\
> >> +	return ret;				\
> >> +}
> >> +
> >> +DEF_LOADER(int);
> >> +DEF_LOADER(uint);
> >> +DEF_LOADER(long);
> >> +DEF_LOADER(ulong);
> >> +DEF_LOADER(ulonglong);
> >> +DEF_LOADER(ushort);
> >> +DEF_LOADER(short);
> >> +typedef void *pointer_t;
> >> +DEF_LOADER(pointer_t);
> >> +
> >> +#define LOADER(TYPE) load_##TYPE
> > A simpler model would be
> > #define LOADER(TYPE, addr)                         \
> > ({                                                 \
> > 	TYPE ret;                                  \
> > 	memcpy(&ret, (void *)addr, sizeof(TYPE));  \
> > 	ret;                                       \
> > })
> 
> This does simplify things a bit.
> 
> > 
> > I would expect the compiler to optimize this away for archs
> > that do not require aligned access.
> 
> I hesitate to to replace the macros for every architecture with this.
> I'll let Dave A. make that call, but I think it can improve the
> NEED_ALIGNED_MEM_ACCESS case.

Do not modify the macros for the existing architectures.

Thanks,
  Dave

> 
> > 
> > Quick test:
> > 
> > #include <string.h>
> > #include <stdio.h>
> > 
> > #define LOADER(TYPE, addr)                       \
> > ({                                               \
> >         TYPE ret;                                \
> >         memcpy(&ret, (void*)addr, sizeof(TYPE)); \
> >         ret;                                     \
> > })
> > 
> > #define INT(ADDR)       LOADER(int, ADDR)
> > 
> > void main(void)
> > {
> > 	int i = 37;
> > 	int j = -17;
> > 
> >         printf("i=%d j=%d\n", INT(&i), INT(&j));
> > }
> > 
> > 
> > 	Sam
> > 
> 
> --
> Crash-utility mailing list
> Crash-utility@redhat.com
> https://www.redhat.com/mailman/listinfo/crash-utility
> 
