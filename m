From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 03 Oct 2017 20:26:51 +0000
Subject: Re: [PATCH v9 12/12] mm: stop zeroing memory during allocation in vmemmap
Message-Id: <e5872937-b166-fd48-d46d-1921c738d4b1@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-13-pasha.tatashin@oracle.com>
 <20171003131952.aqq377pjug5me6go@dhcp22.suse.cz>
 <c028f65a-b4a6-e56d-3a50-5d7ad9af50cb@oracle.com>
In-Reply-To: <c028f65a-b4a6-e56d-3a50-5d7ad9af50cb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Michal,

I decided not to merge these two patches, because in addition to sparc=20
optimization move, we have this dependancies:

mm: zero reserved and unavailable struct pages

must be before

mm: stop zeroing memory during allocation in vmemmap.

Otherwise, we can end-up with struct pages that are not zeroed properly.

However, the first patch depends on
mm: zero struct pages during initialization

As it uses mm_zero_struct_page().

Pasha


On 10/03/2017 11:34 AM, Pasha Tatashin wrote:
> On 10/03/2017 09:19 AM, Michal Hocko wrote:
>> On Wed 20-09-17 16:17:14, Pavel Tatashin wrote:
>>> vmemmap_alloc_block() will no longer zero the block, so zero memory
>>> at its call sites for everything except struct pages.=C2=A0 Struct page=
=20
>>> memory
>>> is zero'd by struct page initialization.
>>>
>>> Replace allocators in sprase-vmemmap to use the non-zeroing version. So,
>>> we will get the performance improvement by zeroing the memory in=20
>>> parallel
>>> when struct pages are zeroed.
>>
>> Is it possible to merge this patch with=20
>> http://lkml.kernel.org/r/20170920201714.19817-7-pasha.tatashin@oracle.com
>=20
> Yes, I will do that. It would also require re-arranging
> [PATCH v9 07/12] sparc64: optimized struct page zeroing
> optimization to come after this patch.
>=20
> Pasha
