From: Qian Cai <cai@lca.pw>
Date: Wed, 29 Jan 2020 11:09:56 +0000
Subject: Re: [PATCH V12] mm/debug: Add tests validating architecture page table helpers
Message-Id: <50B7EFFE-1FF0-4B16-84A1-D851052B18B4@lca.pw>
List-Id: <sparclinux.vger.kernel.org>
References: <20200128174709.GK655507@arrakis.emea.arm.com>
 <69091BA4-18C4-4425-A5E2-31FBE4654AF9@lca.pw>
 <20200129103640.GA668562@arrakis.emea.arm.com>
In-Reply-To: <20200129103640.GA668562@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, Linux-MM <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-s390@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, Michael Ellerman <mpe@ellerman.id.au>, the arch/x86 maintainers <x86@kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Matthew Wilcox <willy@infradead.org>, Steven Price <Steven.Price@arm.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Vlastimil Babka <vbabka@suse.cz>, linux-snps-arc@lists.infradead.org, Kees Cook <keescook@chromium.org>, Anshuman Khandual <Anshuman.Khandual@arm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Mark Brown <broonie@kernel.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Sri Krishna chowdary <schowdary@nvidia.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Dave Hansen <dave.hansen@intel.com>, linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Vineet Gupta <vgupta@synopsys.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>



> On Jan 29, 2020, at 5:36 AM, Catalin Marinas <catalin.marinas@arm.com> wr=
ote:
>=20
> On Tue, Jan 28, 2020 at 02:07:10PM -0500, Qian Cai wrote:
>> On Jan 28, 2020, at 12:47 PM, Catalin Marinas <catalin.marinas@arm.com> =
wrote:
>>> The primary goal here is not finding regressions but having clearly
>>> defined semantics of the page table accessors across architectures. x86
>>> and arm64 are a good starting point and other architectures will be
>>> enabled as they are aligned to the same semantics.
>>=20
>> This still does not answer the fundamental question. If this test is
>> simply inefficient to find bugs,
>=20
> Who said this is inefficient (other than you)?

Inefficient of finding bugs. It said only found a bug or two in its lifetim=
e?

>=20
>> who wants to spend time to use it regularly?=20
>=20
> Arch maintainers, mm maintainers introducing new macros or assuming
> certain new semantics of the existing macros.
>=20
>> If this is just one off test that may get running once in a few years
>> (when introducing a new arch), how does it justify the ongoing cost to
>> maintain it?
>=20
> You are really missing the point. It's not only for a new arch but
> changes to existing arch code. And if the arch code churn in this area
> is relatively small, I'd expect a similarly small cost of maintaining
> this test.
>=20
> If you only turn DEBUG_VM on once every few years, don't generalise this
> to the rest of the kernel developers (as others pointed out, this test
> is default y if DEBUG_VM).

Quite the opposite, I am running DEBUG_VM almost daily for regression
workload while I felt strongly this thing does not add any value mixing the=
re.

So, I would suggest to decouple this away from DEBUG_VM, and clearly
document that this test is not something intended for automated regression
workloads, so those people don=E2=80=99t need to waste time running this.

>=20
> Anyway, I think that's a pointless discussion, so not going to reply
> further (unless you have technical content to add).
>=20
> --=20
> Catalin
