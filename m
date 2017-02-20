From: David Miller <davem@davemloft.net>
Date: Mon, 20 Feb 2017 14:56:58 +0000
Subject: Re: [PATCH 3/4] sparc: convert mdesc_handle.refcnt from atomic_t to refcount_t
Message-Id: <20170220.095658.2221033513472748245.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1487588781-15123-1-git-send-email-elena.reshetova@intel.com>
        <1487588781-15123-4-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1487588781-15123-4-git-send-email-elena.reshetova@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: elena.reshetova@intel.com
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, x86@kernel.org, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, tony.luck@intel.com, hpa@zytor.com, ishkamiel@gmail.com, keescook@chromium.org, dwindsor@gmail.com

From: Elena Reshetova <elena.reshetova@intel.com>
Date: Mon, 20 Feb 2017 13:06:20 +0200

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

Acked-by: David S. Miller <davem@davemloft.net>
