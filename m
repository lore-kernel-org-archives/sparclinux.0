From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 20 Nov 2020 12:20:04 +0000
Subject: Re: [PATCH 0/5] perf/mm: Fix PERF_SAMPLE_*_PAGE_SIZE
Message-Id: <20201120122004.GG3021@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20201113111901.743573013@infradead.org>
 <16ad8cab-08e2-27a7-6803-baadc6b8721b@csgroup.eu>
 <2a32b00b-2214-3283-58e0-9cb0ff4bd728@csgroup.eu>
In-Reply-To: <2a32b00b-2214-3283-58e0-9cb0ff4bd728@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, eranian@google.com, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, will@kernel.org, willy@infradead.org, aneesh.kumar@linux.ibm.com, sparclinux@vger.kernel.org, davem@davemloft.net, catalin.marinas@arm.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com, dave.hansen@intel.com, kirill.shutemov@linux.intel.com

On Fri, Nov 20, 2020 at 12:18:22PM +0100, Christophe Leroy wrote:
> Hi Peter,
>=20
> Le 13/11/2020 =E0 14:44, Christophe Leroy a =E9crit=A0:
> > Hi
> >=20
> > Le 13/11/2020 =E0 12:19, Peter Zijlstra a =E9crit=A0:
> > > Hi,
> > >=20
> > > These patches provide generic infrastructure to determine TLB page si=
ze from
> > > page table entries alone. Perf will use this (for either data or code=
 address)
> > > to aid in profiling TLB issues.
> > >=20
> > > While most architectures only have page table aligned large pages, so=
me
> > > (notably ARM64, Sparc64 and Power) provide non page table aligned lar=
ge pages
> > > and need to provide their own implementation of these functions.
> > >=20
> > > I've provided (completely untested) implementations for ARM64 and Spa=
rc64, but
> > > failed to penetrate the _many_ Power MMUs. I'm hoping Nick or Aneesh =
can help
> > > me out there.
> > >=20
> >=20
> > I can help with powerpc 8xx. It is a 32 bits powerpc. The PGD has 1024
> > entries, that means each entry maps 4M.
> >=20
> > Page sizes are 4k, 16k, 512k and 8M.
> >=20
> > For the 8M pages we use hugepd with a single entry. The two related PGD
> > entries point to the same hugepd.
> >=20
> > For the other sizes, they are in standard page tables. 16k pages appear
> > 4 times in the page table. 512k entries appear 128 times in the page
> > table.
> >=20
> > When the PGD entry has _PMD_PAGE_8M bits, the PMD entry points to a
> > hugepd with holds the single 8M entry.
> >=20
> > In the PTE, we have two bits: _PAGE_SPS and _PAGE_HUGE
> >=20
> > _PAGE_HUGE means it is a 512k page
> > _PAGE_SPS means it is not a 4k page
> >=20
> > The kernel can by build either with 4k pages as standard page size, or
> > 16k pages. It doesn't change the page table layout though.
> >=20
> > Hope this is clear. Now I don't really know to wire that up to your ser=
ies.
>=20
> Does my description make sense ? Is there anything I can help with ?

It did, and I had vague memories from when we fixed that pgd_t issue.
I've just not had time to dig through the powerpc code yet to find the
right mmu header to stick it in.

I was meaning to get another version of these patches posted this week,
but time keeps slipping away, I'll try.
