From: Ingo Molnar <mingo@kernel.org>
Date: Thu, 28 Dec 2017 12:05:31 +0000
Subject: Re: [PATCH v6 2/8] module: use relative references for __ksymtab entries
Message-Id: <20171228120531.xhcb4dg2qu2z5ssp@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
 <20171227085033.22389-3-ard.biesheuvel@linaro.org>
 <CA+55aFxqJqJq_7VUzBVTppgXFPc-8Ou55iLsZjp3fr6B2gRyTQ@mail.gmail.com>
 <CAKv+Gu-2NUzsakN2rcM_5fqD0ubr+6ZXSc+5sjZZPbU3wj_Xsg@mail.gmail.com>
 <CA+55aFzygF6P3v5VxyBucZfn-tg58jeV6qwt0y7QGmmNiKYghQ@mail.gmail.com>
 <CAKv+Gu-wRtfnGfrEjuxR5YkCpZM-nQHZShROEdbcEh=fSiWf5A@mail.gmail.com>
In-Reply-To: <CAKv+Gu-wRtfnGfrEjuxR5YkCpZM-nQHZShROEdbcEh=fSiWf5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> Annoyingly, we need this because there is a single instance of a
> special section that ends up in the EFI stub code: we build lib/sort.c
> again as a EFI libstub object, and given that sort() is exported, we
> end up with a ksymtab section in the EFI stub. The sort() thing has
> caused issues before [0], so perhaps I should just clone sort.c into
> drivers/firmware/efi/libstub and get rid of that hack.
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id)f9007b3182ab3f328a31da13e6b1c9072f7a95

If the root problem is early bootstrap code randomly using generic facility that 
isn't __init, then we should definitely improve tooling to at least detect these 
problems.

As bootstrap code gets improved (KASLR, more complex decompression, etc. etc.) we 
keep using new bits of generic facilities...

So this should definitely not be hidden by open coding that function (which has 
various other disadvantages as well), but should be turned from silent breakage 
either into non-breakage (and do so not only for sort() but for other generic 
functions as well), or should be turned into a build failure.

Thanks,

	Ingo
