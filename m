From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 25 Apr 2016 20:48:45 +0000
Subject: Re: [PATCH V3 2/3] Implement byte-by-byte memory access facilitators
Message-Id: <20160425204845.GB18464@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1461608888-5063-3-git-send-email-dave.kleikamp@oracle.com>
In-Reply-To: <1461608888-5063-3-git-send-email-dave.kleikamp@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Dave.

> Sparc64 requires type-aligned memory access. Since data buffers may not
> be properly aligned, implement a safe copy from memory per data type.
> 
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> ---
>  defs.h |   41 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 41 insertions(+), 0 deletions(-)
> 
> diff --git a/defs.h b/defs.h
> index e3afc58..d9d4559 100644
> --- a/defs.h
> +++ b/defs.h
> @@ -2187,6 +2187,45 @@ struct builtin_debug_table {
>   *  Facilitators for pulling correctly-sized data out of a buffer at a
>   *  known address. 
>   */
> +
> +#ifdef NEED_ALIGNED_MEM_ACCESS
> +
> +#define DEF_LOADER(TYPE)			\
> +static inline TYPE				\
> +load_##TYPE (char *addr)			\
> +{						\
> +	TYPE ret;				\
> +	size_t i = sizeof(TYPE);		\
> +	while (i--)				\
> +		((char *)&ret)[i] = addr[i];	\
> +	return ret;				\
> +}
> +
> +DEF_LOADER(int);
> +DEF_LOADER(uint);
> +DEF_LOADER(long);
> +DEF_LOADER(ulong);
> +DEF_LOADER(ulonglong);
> +DEF_LOADER(ushort);
> +DEF_LOADER(short);
> +typedef void *pointer_t;
> +DEF_LOADER(pointer_t);
> +
> +#define LOADER(TYPE) load_##TYPE
A simpler model would be
#define LOADER(TYPE, addr)                         \
({                                                 \
	TYPE ret;                                  \
	memcpy(&ret, (void *)addr, sizeof(TYPE));  \
	ret;                                       \
})

I would expect the compiler to optimize this away for archs
that do not require aligned access.

Quick test:

#include <string.h>
#include <stdio.h>

#define LOADER(TYPE, addr)                       \
({                                               \
        TYPE ret;                                \
        memcpy(&ret, (void*)addr, sizeof(TYPE)); \
        ret;                                     \
})

#define INT(ADDR)       LOADER(int, ADDR)

void main(void)
{
	int i = 37;
	int j = -17;

        printf("i=%d j=%d\n", INT(&i), INT(&j));
}


	Sam
