From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Mon, 05 Mar 2018 21:04:10 +0000
Subject: Re: [PATCH v12 02/11] mm, swap: Add infrastructure for saving page metadata on swap
Message-Id: <0709b55b-3b77-ba43-efbc-6f767714a0b7@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <f5316c71e645d99ffdd52963f1e9675de3fc6386.1519227112.git.khalid.aziz@oracle.com>
 <0d77dc3c-1454-a689-a0fb-f07e8973c29e@linux.intel.com>
 <4a766f6d-ba96-7963-b367-7214eab7e307@oracle.com>
 <d807ba68-decd-e195-f607-ef6962e40c96@linux.intel.com>
 <66c8ab93-f491-ad2e-5313-d03e23f73006@oracle.com>
In-Reply-To: <66c8ab93-f491-ad2e-5313-d03e23f73006@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org, davem@davemloft.net, arnd@arndb.de
Cc: kirill.shutemov@linux.intel.com, mhocko@suse.com, ross.zwisler@linux.intel.com, dave.jiang@intel.com, mgorman@techsingularity.net, willy@infradead.org, hughd@google.com, minchan@kernel.org, hannes@cmpxchg.org, shli@fb.com, mingo@kernel.org, jglisse@redhat.com, me@tobin.cc, anthony.yznaga@oracle.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

On 03/05/2018 12:28 PM, Khalid Aziz wrote:
>> Do you have a way to tell that data is not being thrown away?=C2=A0 Like=
 if
>> the ADI metadata is different for two different cachelines within a
>> single page?
>=20
> Yes, since access to tagged data is made using pointers with ADI tag
> embedded in the top bits, any mismatch between what app thinks the ADI
> tags should be and what is stored in the RAM for corresponding page will
> result in exception. If ADI data gets thrown away, we will get an ADI
> tag mismatch exception. If ADI tags for two different ADI blocks on a
> page are different when app expected them to be the same, we will see an
> exception on access to the block with wrong ADI data.

So, when an app has two different ADI tags on two parts of a page, the
page gets swapped, and the ADI block size is under PAGE_SIZE, the app
will get an ADI exception after swap-in through no fault of its own?

