From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 14 Nov 2012 14:53:31 +0000
Subject: Re: [PATCH] Centralise CONFIG_ARCH_NO_VIRT_TO_BUS
Message-Id: <CAErSpo6p09BJo=3tFp7f8StLT9avYdqiecGm8FxyQnWUm+pfiw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <ADE657CA350FB648AAC2C43247A983F00206B25884B1@AUSP01VMBX24.collaborationhost.net>
 <CAErSpo6WG2R_8sa=rOmAOci-3iFpDs2NFzNkZYxDnD2oTiMQJg@mail.gmail.com>
 <20121113082615.2f482eb8835daf46e1f27947@canb.auug.org.au> <CAMuHMdXu2VJhB+1uFApeBrYS3t2cfpPMaTz12F=A_FNJB1Q60w@mail.gmail.com>
In-Reply-To: <CAMuHMdXu2VJhB+1uFApeBrYS3t2cfpPMaTz12F=A_FNJB1Q60w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, H Hartley Sweeten <hartleys@visionengravers.com>, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

On Tue, Nov 13, 2012 at 3:32 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Nov 12, 2012 at 10:26 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 366ec06..9bc00e7 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -271,6 +271,13 @@ config ARCH_WANT_OLD_COMPAT_IPC
>>         select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
>>         bool
>>
>> +config ARCH_NO_VIRT_TO_BUS
>> +       bool
>> +       help
>> +         An architecture should select this if it cannot (or will not)
>> +         implement virt_to_bus().  All new architectures should probably
>> +         select this.
>
> Don't we typically put the burden of selecting Kconfig flags for deprecated
> features on the existing architectures that provide the deprecated features?
>
> I.e. shouldn't it be ARCH_HAS_VIRT_TO_BUS, selected by the architectures
> that need it, instead?

I like this idea.
