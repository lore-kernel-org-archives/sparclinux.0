From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 23 Jul 2012 22:16:24 +0000
Subject: Re: [next:akpm 244/309] lib/atomic64_test.c:131:2: warning: #warning Please implement atomic64_dec_i
Message-Id: <20120723151624.60760bdc.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120723082823.GA17005@arm.com>
In-Reply-To: <20120723082823.GA17005@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

On Mon, 23 Jul 2012 09:28:23 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> Hi Fengguang,
> 
> On Mon, Jul 23, 2012 at 07:55:42AM +0100, Fengguang Wu wrote:
> > There are new compile warnings show up in
> > 
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git akpm
> > head:   37e2ad4953983527f7bdb6831bf478eedcc84082
> > commit: ffacc905e2135e8408d43adbe0b8e21484b2c8e7 [244/309] atomic64_test: simplify the #ifdef for atomic64_dec_if_positive() test
> > config: sparc-allmodconfig (attached as .config)
> > 
> > All warnings:
> > 
> > lib/atomic64_test.c: In function 'test_atomic64':
> > lib/atomic64_test.c:131:2: warning: #warning Please implement atomic64_dec_if_positive for your architecture and select the above Kconfig symbol [-Wcpp]
> 
> Is this a new warning in the sense that the string is different now? Or
> you never got it before on sparc64. I don't have a sparc toolchain at
> hand now but it looks to me like atomic64_test.c should have given the
> warning before this patch as atomic64_dec_if_positive() does not seem to
> be defined on sparc64.
> 

Before:
lib/atomic64_test.c:132:2: warning: #warning Please implement atomic64_dec_if_positive for your architecture, and add it to the IF above

After:
lib/atomic64_test.c:131:2: warning: #warning Please implement atomic64_dec_if_positive for your architecture and select the above Kconfig symbol
