From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 15 May 2007 00:15:18 +0000
Subject: Re: slab hang on boot
Message-Id: <20070514171518.fdca9f8c.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0705142133190.17204@math>
	<20070514.151148.45744375.davem@davemloft.net>
	<Pine.LNX.4.64.0705141642350.13606@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0705141642350.13606@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Lameter <clameter@sgi.com>
Cc: mroos@linux.ee, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 14 May 2007 16:46:17 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> -#define KMALLOC_SHIFT_HIGH 25
> +#define KMALLOC_SHIFT_HIGH ((MAX_ORDER + PAGE_SHIFT) =< 25 ? \
> +				MAX_ORDER + PAGE_SHIFT - 1 : 25)

Would prefer to see a lot more parentheses in there.  Who knows what the arch
is using for MAX_ORDER and PAGE_SHIFT.

>  #if !defined(CONFIG_MMU) || NR_CPUS > 512 || MAX_NUMNODES > 256
>  #define KMALLOC_SHIFT_HIGH 20
> @@ -86,6 +87,9 @@ static inline int kmalloc_index(int size
>  	 */
>  	WARN_ON_ONCE(size = 0);
>  
> +	if (size >= (1UL << KMALLOC_SHIFT_HIGH))
> +		return -1;
> +

`size' is `int'.  Deliberately comparing it to an unsigned long seems
unpointful.

Arguably, `size' should be size_t.
