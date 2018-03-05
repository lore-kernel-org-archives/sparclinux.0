From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Mon, 05 Mar 2018 21:14:39 +0000
Subject: Re: [PATCH v12 02/11] mm, swap: Add infrastructure for saving page metadata on swap
Message-Id: <b55a493a-3401-b493-d9fe-b873878e02e0@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <f5316c71e645d99ffdd52963f1e9675de3fc6386.1519227112.git.khalid.aziz@oracle.com>
 <0d77dc3c-1454-a689-a0fb-f07e8973c29e@linux.intel.com>
 <4a766f6d-ba96-7963-b367-7214eab7e307@oracle.com>
 <d807ba68-decd-e195-f607-ef6962e40c96@linux.intel.com>
 <66c8ab93-f491-ad2e-5313-d03e23f73006@oracle.com>
 <0709b55b-3b77-ba43-efbc-6f767714a0b7@linux.intel.com>
In-Reply-To: <0709b55b-3b77-ba43-efbc-6f767714a0b7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Dave Hansen <dave.hansen@linux.intel.com>, akpm@linux-foundation.org, davem@davemloft.net, arnd@arndb.de
Cc: kirill.shutemov@linux.intel.com, mhocko@suse.com, ross.zwisler@linux.intel.com, dave.jiang@intel.com, mgorman@techsingularity.net, willy@infradead.org, hughd@google.com, minchan@kernel.org, hannes@cmpxchg.org, shli@fb.com, mingo@kernel.org, jglisse@redhat.com, me@tobin.cc, anthony.yznaga@oracle.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

On 03/05/2018 02:04 PM, Dave Hansen wrote:
> On 03/05/2018 12:28 PM, Khalid Aziz wrote:
>>> Do you have a way to tell that data is not being thrown away?=C2=A0 Lik=
e if
>>> the ADI metadata is different for two different cachelines within a
>>> single page?
>>
>> Yes, since access to tagged data is made using pointers with ADI tag
>> embedded in the top bits, any mismatch between what app thinks the ADI
>> tags should be and what is stored in the RAM for corresponding page will
>> result in exception. If ADI data gets thrown away, we will get an ADI
>> tag mismatch exception. If ADI tags for two different ADI blocks on a
>> page are different when app expected them to be the same, we will see an
>> exception on access to the block with wrong ADI data.
>=20
> So, when an app has two different ADI tags on two parts of a page, the
> page gets swapped, and the ADI block size is under PAGE_SIZE, the app
> will get an ADI exception after swap-in through no fault of its own?
>=20

Only if the kernel fails to re-establish ADI tags on the swapped in page=20
which is why I added infrastructure to save the ADI tags for a page=20
before it is swapped out and then re-establish those tags when the page=20
is swapped back in. Kernel needs to save as many as ADI TAGS as may=20
exist on each page, not just one tag per page. On sparc M7 8K pages,=20
there are 128 ADI tags for the page, so kernel will store and restore=20
128 ADI tags for each page on swap-out and swap-in. If kernel restores=20
only one ADI tag for the page on swap in, app will get an exception and=20
it will be kernel's fault.

--
Khalid
