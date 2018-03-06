From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 06 Mar 2018 22:48:19 +0000
Subject: Re: [PATCH v12 09/11] mm: Allow arch code to override copy_highpage()
Message-Id: <20180306144819.53e794acc83309fd8b401e92@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
	<ecbafa2bfcc05f22183be2e7784ed11943b1d5b2.1519227112.git.khalid.aziz@oracle.com>
In-Reply-To: <ecbafa2bfcc05f22183be2e7784ed11943b1d5b2.1519227112.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: davem@davemloft.net, dave.hansen@linux.intel.com, kstewart@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de, anthony.yznaga@oracle.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

On Wed, 21 Feb 2018 10:15:51 -0700 Khalid Aziz <khalid.aziz@oracle.com> wrote:

> Some architectures can support metadata for memory pages and when a
> page is copied, its metadata must also be copied. Sparc processors
> from M7 onwards support metadata for memory pages. This metadata
> provides tag based protection for access to memory pages. To maintain
> this protection, the tag data must be copied to the new page when a
> page is migrated across NUMA nodes. This patch allows arch specific
> code to override default copy_highpage() and copy metadata along
> with page data upon migration.
> 
> ...
>
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -237,6 +237,8 @@ static inline void copy_user_highpage(struct page *to, struct page *from,
>  
>  #endif
>  
> +#ifndef __HAVE_ARCH_COPY_HIGHPAGE
> +
>  static inline void copy_highpage(struct page *to, struct page *from)
>  {
>  	char *vfrom, *vto;
> @@ -248,4 +250,6 @@ static inline void copy_highpage(struct page *to, struct page *from)
>  	kunmap_atomic(vfrom);
>  }
>  
> +#endif
> +
>  #endif /* _LINUX_HIGHMEM_H */

It would be more consistent and conventional here to do

#ifndef copy_highpage
static inline void copy_highpage(struct page *to, struct page *from)
{
	...
}
#define copy_highpage copy_highpage

As is happening in [patch 07/11].

And a similar change could be made to [patch 02/11], actually.


Either way,

Acked-by: Andrew Morton <akpm@linux-foundation.org>
