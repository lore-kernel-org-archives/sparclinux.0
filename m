From: Jerome Glisse <jglisse@redhat.com>
Date: Thu, 28 May 2020 11:20:25 +0000
Subject: Re: Cache flush issue with page_mapping_file() and swap back shmem page ?
Message-Id: <20200528112025.GA10175@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200528002033.GB1992500@redhat.com>
 <alpine.LSU.2.11.2005272021220.3857@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2005272021220.3857@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Hugh Dickins <hughd@google.com>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, linux-mm@kvack.org, Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org, Paul Burton <paulburton@kernel.org>, Helge Deller <deller@gmx.de>, Huang Ying <ying.huang@intel.com>, James Hogan <jhogan@kernel.org>, rmk+kernel@arm.linux.org.uk, linux-xtensa@linux-xtensa.org, Steven Capper <steve.capper@linaro.org>, Rabin Vincent <rabinv@axis.com>, Ley Foon Tan <lftan@altera.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-parisc@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, nios2-dev@lists.rocketboards.org, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>

On Wed, May 27, 2020 at 08:46:22PM -0700, Hugh Dickins wrote:
> Hi Jerome,
>=20
> On Wed, 27 May 2020, Jerome Glisse wrote:
> > So any arch code which uses page_mapping_file() might get the wrong
> > answer, this function will return NULL for a swap backed page which
> > can be a shmem pages. But shmem pages can still be shared among
> > multiple process (and possibly at different virtual addresses if
> > mremap was use).
> >=20
> > Attached is a patch that changes page_mapping_file() to return the
> > shmem mapping for swap backed shmem page. I have not tested it (no
> > way for me to test all those architecture) and i spotted this while
> > working on something else. So i hope someone can take a closer look.
>=20
> I'm certainly no expert on flush_dcache_page() and friends, but I'd
> be very surprised if such a problem exists, yet has gone unnoticed
> for so long.  page_mapping_file() itself is fairly new, added when
> a risk of crashing on a race with swapoff came in: but the previous
> use of page_mapping() would have suffered equally if there were such
> a cache flushinhg problem here.
>=20
> And I'm afraid your patch won't do anything to help if there is a
> problem: very soon after shmem calls add_to_swap_cache(), it calls
> shmem_delete_from_page_cache(), which sets page->mapping to NULL.
>=20
> But I can assure you that a shmem page (unlike an anon page) is never
> put into swap cache while it is mapped into userspace, and never
> mapped into userspace while it is still in swap cache: does that help?
>=20

You are right i missed/forgot the part where shmem is never swapcache
and mapped at the same time, thus page_mapping_file() can return NULL
for those as they can no longer have alias mapping.

Thank you Hugh
J=E9r=F4me
