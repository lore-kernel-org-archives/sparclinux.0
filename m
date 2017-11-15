From: David Miller <davem@davemloft.net>
Date: Wed, 15 Nov 2017 05:42:15 +0000
Subject: Re: [PATCH] sparc64: convert mdesc_handle.refcnt from atomic_t to refcount_t
Message-Id: <20171115.144215.1875016289797792026.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1508486277-24913-1-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1508486277-24913-1-git-send-email-elena.reshetova@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: elena.reshetova@intel.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, shannon.nelson@oracle.com, jag.raman@oracle.com, peterz@infradead.org, keescook@chromium.org

From: Elena Reshetova <elena.reshetova@intel.com>
Date: Fri, 20 Oct 2017 10:57:57 +0300

> atomic_t variables are currently used to implement reference
> counters with the following properties:
>  - counter is initialized to 1 using atomic_set()
>  - a resource is freed upon counter reaching zero
>  - once counter reaches zero, its further
>    increments aren't allowed
>  - counter schema uses basic atomic operations
>    (set, inc, inc_not_zero, dec_and_test, etc.)
> 
> Such atomic variables should be converted to a newly provided
> refcount_t type and API that prevents accidental counter overflows
> and underflows. This is important since overflows and underflows
> can lead to use-after-free situation and be exploitable.
> 
> The variable mdesc_handle.refcnt is used as pure reference counter.
> Convert it to refcount_t and fix up the operations.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: David Windsor <dwindsor@gmail.com>
> Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>

Applied.
