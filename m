From: Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 14 Oct 2020 06:40:28 +0000
Subject: Re: [RFC] openprom: Fix 'opiocnextprop'; ensure integer conversions; use string size
Message-Id: <c1329005-fa37-e02e-0105-2634ee566f55@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <a5515efeaad94666a87f264dbf65bdbd@gmail.com>
In-Reply-To: <a5515efeaad94666a87f264dbf65bdbd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Witten <mfwitten@gmail.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 9/4/20 12:40 PM, Michael Witten wrote:
> The following patch improves the quality and correctness of the openprom code.
> 
> 
> --8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--
> 
> ---
>   arch/sparc/include/asm/prom.h   |   2 +-
>   arch/sparc/kernel/prom_common.c |  14 +--
>   drivers/sbus/char/openprom.c    | 263 ++++++++++++++++++++++++++++------------
>   3 files changed, 194 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/sbus/char/openprom.c b/drivers/sbus/char/openprom.c
> index 30b9751aad30..9bc2877aa09a 100644
> --- a/drivers/sbus/char/openprom.c
> +++ b/drivers/sbus/char/openprom.c
>   	/* If the bufsize is too large, just limit it.
>   	 * Fix from Jason Rappleye.
>   	 */

The sparc cross-compiler that I am using does not like to see type
casting in preprocessor lines.
SIZE_MAX is #defined as (~(size_t)0) and for the #if line below,

> +	#if OPROMMAXPARAM > SIZE_MAX/2
> +		if (bufsize > SIZE_MAX/2)
> +			return -EFAULT;
> +	#endif

gcc (cpp) says:

In file included from ../drivers/sbus/char/openprom.c:19:
../include/linux/limits.h:9:21: warning: "size_t" is not defined, 
evaluates to 0 [-Wundef]
     9 | #define SIZE_MAX (~(size_t)0)
       |                     ^~~~~~
../drivers/sbus/char/openprom.c:95:22: note: in expansion of macro 
'SIZE_MAX'
    95 |  #if OPROMMAXPARAM > SIZE_MAX/2
       |                      ^~~~~~~~
../include/linux/limits.h:9:28: error: missing binary operator before 
token "0"
     9 | #define SIZE_MAX (~(size_t)0)
       |                            ^
../drivers/sbus/char/openprom.c:95:22: note: in expansion of macro 
'SIZE_MAX'
    95 |  #if OPROMMAXPARAM > SIZE_MAX/2
       |                      ^~~~~~~~

causing a build error.

--
~Randy
