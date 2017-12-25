From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 25 Dec 2017 21:09:48 +0000
Subject: Re: [PATCH v5 1/8] arch: enable relative relocations for arm64, power, x86, s390 and x86
Message-Id: <CAKv+Gu_Ue30XqQ4sok34U0rjcsfkN1caACzQN3En71Hmd6Kc3A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171225205440.14575-1-ard.biesheuvel@linaro.org>
 <20171225205440.14575-2-ard.biesheuvel@linaro.org>
 <20171225210502.GA635@ravnborg.org>
In-Reply-To: <20171225210502.GA635@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 25 December 2017 at 21:05, Sam Ravnborg <sam@ravnborg.org> wrote:
> Hi Ard.
>
> On Mon, Dec 25, 2017 at 08:54:33PM +0000, Ard Biesheuvel wrote:
>> Before updating certain subsystems to use place relative 32-bit
>> relocations in special sections, to save space  and reduce the
>> number of absolute relocations that need to be processed at runtime
>> by relocatable kernels, introduce the Kconfig symbol and define it
>> for some architectures that should be able to support and benefit
>> from it.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: x86@kernel.org
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/Kconfig                    | 10 ++++++++++
>>  arch/arm64/Kconfig              |  1 +
>
>>  arch/arm64/kernel/vmlinux.lds.S |  2 +-
> The change to arch/arm64/kernel/vmlinux.lds.S is
> not justified in the changelog.
> Did you add it by mistake?
>

No. The PREL32 support adds a __ADDRESSABLE() macro that emits code
into .discard.text, and on arm64, the EFI object sections get a .init
prefix so we need to discard .init.discard.* explicitly as well.

I will add this as a note.

Thanks,
Ard.
