From: David Miller <davem@davemloft.net>
Date: Wed, 13 May 2020 22:32:26 +0000
Subject: Re: [RESEND PATCH 0/4] Rework sparc32 page-table layout
Message-Id: <20200513.153226.1639916880914538869.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200414214011.2699-1-will@kernel.org>
In-Reply-To: <20200414214011.2699-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: will@kernel.org
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, ndesaulniers@google.com, matt@codeblueprint.co.uk, sparclinux@vger.kernel.org, kernel-team@android.com

From: Will Deacon <will@kernel.org>
Date: Tue, 14 Apr 2020 22:40:07 +0100

> This is a reposting of the patch series I sent previously to rework the
> sparc32 page-table layout so that 'pmd_t' can be used safely with
> READ_ONCE():
> 
> https://lore.kernel.org/lkml/20200324104005.11279-1-will@kernel.org
> 
> This is blocking the READ_ONCE() rework, which in turn allows us to
> bump the minimum GCC version for building the kernel up to 4.8.

Series applied to sparc-next, thanks Will.
