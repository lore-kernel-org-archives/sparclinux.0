From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 15 Sep 2017 21:20:59 +0000
Subject: Re: [PATCH v8 10/11] arm64/kasan: explicitly zero kasan shadow memory
Message-Id: <bff836ec-3922-1783-6cb4-94d1be92544b@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170914223517.8242-1-pasha.tatashin@oracle.com>
 <20170914223517.8242-11-pasha.tatashin@oracle.com>
 <20170915011035.GA6936@remoulade>
 <c76f72fc-21ed-62d0-014e-8509c0374f96@oracle.com>
 <20170915203852.GA10749@remoulade>
In-Reply-To: <20170915203852.GA10749@remoulade>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Mark,

I had this option=C2=A0 back upto version 3, where zero flag was passed int=
o=20
vmemmap_alloc_block(), but I was asked to remove it, because it required=20
too many changes in other places. So, the current approach is cleaner,=20
but the idea is that kasan should use its own version of=20
vmemmap_populate() for both x86 and ARM, but I think it is outside of=20
the scope of this work.

See this comment from Ard Biesheuvel:
https://lkml.org/lkml/2017/8/3/948

"
KASAN uses vmemmap_populate as a convenience: kasan has nothing to do
with vmemmap, but the function already existed and happened to do what
KASAN requires.

Given that that will no longer be the case, it would be far better to
stop using vmemmap_populate altogether, and clone it into a KASAN
specific version (with an appropriate name) with the zeroing folded
into it.
"

If you think I should add these function in this project, than sure I=20
can send a new version with kasanmap_populate() functions.

Thank you,
Pasha

On 09/15/2017 04:38 PM, Mark Rutland wrote:
> On Thu, Sep 14, 2017 at 09:30:28PM -0400, Pavel Tatashin wrote:
>> Hi Mark, Thank you for looking at this. We can't do this because page=20
>> table is not set until cpu_replace_ttbr1() is called. So, we can't do=20
>> memset() on this memory until then.=20
> I see. Sorry, I had missed that we were on the temporary tables at=20
> this point in time. I'm still not keen on duplicating the iteration.=20
> Can we split the vmemmap code so that we have a variant that takes a=20
> GFP? That way we could explicitly pass __GFP_ZERO for those cases=20
> where we want a zeroed page, and are happy to pay the cost of=20
> initialization. Thanks Mark.

