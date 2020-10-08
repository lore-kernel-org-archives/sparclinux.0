From: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 08 Oct 2020 10:12:10 +0000
Subject: Re: [PATCH 1/2] mm/mprotect: Call arch_validate_prot under mmap_lock and with length
Message-Id: <20201008101209.GD7661@gaia>
List-Id: <sparclinux.vger.kernel.org>
References: <20201007073932.865218-1-jannh@google.com>
In-Reply-To: <20201007073932.865218-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jann Horn <jannh@google.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, Khalid Aziz <khalid.aziz@oracle.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, sparclinux@vger.kernel.org, Anthony Yznaga <anthony.yznaga@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org

On Wed, Oct 07, 2020 at 09:39:31AM +0200, Jann Horn wrote:
> arch_validate_prot() is a hook that can validate whether a given set of
> protection flags is valid in an mprotect() operation. It is given the set
> of protection flags and the address being modified.
>=20
> However, the address being modified can currently not actually be used in
> a meaningful way because:
>=20
> 1. Only the address is given, but not the length, and the operation can
>    span multiple VMAs. Therefore, the callee can't actually tell which
>    virtual address range, or which VMAs, are being targeted.
> 2. The mmap_lock is not held, meaning that if the callee were to check
>    the VMA at @addr, that VMA would be unrelated to the one the
>    operation is performed on.
>=20
> Currently, custom arch_validate_prot() handlers are defined by
> arm64, powerpc and sparc.
> arm64 and powerpc don't care about the address range, they just check the
> flags against CPU support masks.
> sparc's arch_validate_prot() attempts to look at the VMA, but doesn't take
> the mmap_lock.
>=20
> Change the function signature to also take a length, and move the
> arch_validate_prot() call in mm/mprotect.c down into the locked region.

For arm64 mte, I noticed the arch_validate_prot() issue with multiple
vmas and addressed this in a different way:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=
=3Dfor-next/mte&id=C462ac288f2c97e0c1d9ff6a65955317e799f958
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=
=3Dfor-next/mte&id=0042090548740921951f31fc0c20dcdb96638cb0

Both patches queued for 5.10.

Basically, arch_calc_vm_prot_bits() returns a VM_MTE if PROT_MTE has
been requested. The newly introduced arch_validate_flags() will check
the VM_MTE flag against what the system supports and this covers both
mmap() and mprotect(). Note that arch_validate_prot() only handles the
latter and I don't think it's sufficient for SPARC ADI. For arm64 MTE we
definitely wanted mmap() flags to be validated.

In addition, there's a new arch_calc_vm_flag_bits() which allows us to
set a VM_MTE_ALLOWED on a vma if the conditions are right (MAP_ANONYMOUS
or shmem_mmap():

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=
=3Dfor-next/mte&id=B3fbbea4c00220f62e6f7e2514466e6ee81f7f60

--=20
Catalin
