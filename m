From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 27 Dec 2017 20:24:27 +0000
Subject: Re: [PATCH v6 2/8] module: use relative references for __ksymtab entries
Message-Id: <CAKv+Gu-wRtfnGfrEjuxR5YkCpZM-nQHZShROEdbcEh=fSiWf5A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
 <20171227085033.22389-3-ard.biesheuvel@linaro.org>
 <CA+55aFxqJqJq_7VUzBVTppgXFPc-8Ou55iLsZjp3fr6B2gRyTQ@mail.gmail.com>
 <CAKv+Gu-2NUzsakN2rcM_5fqD0ubr+6ZXSc+5sjZZPbU3wj_Xsg@mail.gmail.com>
 <CA+55aFzygF6P3v5VxyBucZfn-tg58jeV6qwt0y7QGmmNiKYghQ@mail.gmail.com>
In-Reply-To: <CA+55aFzygF6P3v5VxyBucZfn-tg58jeV6qwt0y7QGmmNiKYghQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 27 December 2017 at 20:13, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Dec 27, 2017 at 12:11 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>>
>> I tried to keep the generic patches generic, so perhaps I should just
>> put the arm64 vmlinux.lds.S change in a patch on its own?
>
> I guess it doesn't matter, but regardless of where it gets introduced
> I would like to see the explanation for where the heck that magical
> ".init.discard.text" comes from. It's definitely not obvious from the
> patches, and is presumably some odd arm64 special case.
>

This has to do with the EFI stub. x86 and ARM link it into the
decompressor, and so the code and data are not annotated as __init
(and doing so would involve modifying a lot of code). arm64 does not
have a decompressor, and so the EFI stub is linked into the kernel
proper. To make sure the code ends up in the .init segment, all
sections are prepended with .init at the object level, using objcopy.

Annoyingly, we need this because there is a single instance of a
special section that ends up in the EFI stub code: we build lib/sort.c
again as a EFI libstub object, and given that sort() is exported, we
end up with a ksymtab section in the EFI stub. The sort() thing has
caused issues before [0], so perhaps I should just clone sort.c into
drivers/firmware/efi/libstub and get rid of that hack.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id)f9007b3182ab3f328a31da13e6b1c9072f7a95
