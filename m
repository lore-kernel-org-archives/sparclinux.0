From: David Miller <davem@davemloft.net>
Date: Fri, 15 May 2020 00:41:38 +0000
Subject: Re: [RESEND PATCH 0/4] Rework sparc32 page-table layout
Message-Id: <20200514.174138.617083643581260276.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200414214011.2699-1-will@kernel.org>
        <20200513.153226.1639916880914538869.davem@davemloft.net>
        <20200514072624.GA4280@willie-the-truck>
In-Reply-To: <20200514072624.GA4280@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: will@kernel.org
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, ndesaulniers@google.com, matt@codeblueprint.co.uk, sparclinux@vger.kernel.org, kernel-team@android.com, tglx@linutronix.de

From: Will Deacon <will@kernel.org>
Date: Thu, 14 May 2020 08:26:24 +0100

> Hi David,
> 
> On Wed, May 13, 2020 at 03:32:26PM -0700, David Miller wrote:
>> From: Will Deacon <will@kernel.org>
>> Date: Tue, 14 Apr 2020 22:40:07 +0100
>> 
>> > This is a reposting of the patch series I sent previously to rework the
>> > sparc32 page-table layout so that 'pmd_t' can be used safely with
>> > READ_ONCE():
>> > 
>> > https://lore.kernel.org/lkml/20200324104005.11279-1-will@kernel.org
>> > 
>> > This is blocking the READ_ONCE() rework, which in turn allows us to
>> > bump the minimum GCC version for building the kernel up to 4.8.
>> 
>> Series applied to sparc-next, thanks Will.
> 
> Thanks, although this was picked up by -tip a couple of days ago [1] since
> the READ_ONCE() rework relies on it to avoid breaking the sparc32 build.
> 
> It's obviously harmless to go in both trees, but if you don't need it for
> anything then you may want to drop these to avoid duplicate commits in
> mainline.
 ...
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=locking/kcsan

Thanks for the heads up but I'll leave it in the sparc-next tree for now.
