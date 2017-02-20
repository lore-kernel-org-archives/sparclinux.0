From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Mon, 20 Feb 2017 13:24:24 +0000
Subject: Re: [PATCH 1/4] s390: convert debug_info.ref_count from atomic_t to refcount_t
Message-Id: <20170220132424.GA5656@osiris>
List-Id: <sparclinux.vger.kernel.org>
References: <1487588781-15123-1-git-send-email-elena.reshetova@intel.com>
 <1487588781-15123-2-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1487588781-15123-2-git-send-email-elena.reshetova@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Elena Reshetova <elena.reshetova@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, x86@kernel.org, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org, davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, tony.luck@intel.com, hpa@zytor.com, Hans Liljestrand <ishkamiel@gmail.com>, Kees Cook <keescook@chromium.org>, David Windsor <dwindsor@gmail.com>

On Mon, Feb 20, 2017 at 01:06:18PM +0200, Elena Reshetova wrote:
> refcount_t type and corresponding API should be
> used instead of atomic_t when the variable is used as
> a reference counter. This allows to avoid accidental
> refcounter overflows that might lead to use-after-free
> situations.
> 
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  arch/s390/include/asm/debug.h | 3 ++-
>  arch/s390/kernel/debug.c      | 8 ++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)

I can only see a pull request from Ingo a couple of hours ago for Peter's
refcount code. So the refcount code is not merged yet. It would have been
good if you would have waited until it is really merged to avoid confusion.

> @@ -361,7 +361,7 @@ debug_info_create(const char *name, int pages_per_area, int nr_areas,
>          debug_area_last = rc;
>          rc->next = NULL;
>  
> -	debug_info_get(rc);
> +	refcount_set(&rc->ref_count, 1);

This is not wrong, but I will remove this hunk before applying your patch,
since this doesn't look like an obvious correct change at first glance.

Thanks,
Heiko

