From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Mon, 05 Mar 2018 19:24:14 +0000
Subject: Re: [PATCH v12 09/11] mm: Allow arch code to override copy_highpage()
Message-Id: <68ee1cbc-8e21-e693-7878-777e0d5b0f0c@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <ecbafa2bfcc05f22183be2e7784ed11943b1d5b2.1519227112.git.khalid.aziz@oracle.com>
In-Reply-To: <ecbafa2bfcc05f22183be2e7784ed11943b1d5b2.1519227112.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org, davem@davemloft.net
Cc: kstewart@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de, anthony.yznaga@oracle.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

On 02/21/2018 09:15 AM, Khalid Aziz wrote:
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

I think we prefer that these are CONFIG_* options.
