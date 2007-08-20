From: "Julian Calaby" <julian.calaby@gmail.com>
Date: Mon, 20 Aug 2007 23:34:56 +0000
Subject: Re: [patch 21/23] Add cmpxchg_local to sparc64
Message-Id: <646765f40708201634u5437f307l8259456c92af5cf5@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20070820201519.512791382@polymtl.ca>
	 <20070820201831.178200926@polymtl.ca>
In-Reply-To: <20070820201831.178200926@polymtl.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, clameter@sgi.com, sparclinux@vger.kernel.org, wli@holomorphy.com

On 8/21/07, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
> Use cmpxchg_u32 and cmpxchg_u64 for cmpxchg_local and cmpxchg64_local. For other
> type sizes, use the new generic cmpxchg_local (disables interrupt).
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> CC: clameter@sgi.com
> CC: sparclinux@vger.kernel.org
> CC: wli@holomorphy.com
> ---
>  include/asm-sparc64/system.h |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> Index: linux-2.6-lttng/include/asm-sparc64/system.h
> =================================> --- linux-2.6-lttng.orig/include/asm-sparc64/system.h   2007-08-07 14:31:51.000000000 -0400
> +++ linux-2.6-lttng/include/asm-sparc64/system.h        2007-08-07 15:13:05.000000000 -0400
> @@ -314,6 +314,32 @@ __cmpxchg(volatile void *ptr, unsigned l
>                                     (unsigned long)_n_, sizeof(*(ptr))); \
>    })
>
> +#include <asm-generic/cmpxchg-local.h>

Shouldn't #includes go at the start of the file?

-- 

Julian Calaby

Email: julian.calaby@gmail.com
