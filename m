From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 10 Nov 2009 21:41:47 +0000
Subject: Re: [PATCH 09/11] of: merge prom_{add,remove,modify}_property
Message-Id: <fa686aa40911101341n3096fe62rc4919f9142a3a19a@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091105073728.10460.6061.stgit@angua> <20091105074656.10460.29333.stgit@angua>
	<4AF9CE2F.7080502@austin.ibm.com>
In-Reply-To: <4AF9CE2F.7080502@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Nathan Fontenot <nfont@austin.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, benh@kernel.crashing.org, sfr@canb.auug.org.au, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au

On Tue, Nov 10, 2009 at 1:33 PM, Nathan Fontenot <nfont@austin.ibm.com> wro=
te:
> Grant Likely wrote:
>>
>> Merge common code between PowerPC and MicroBlaze
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>>
>> =A0arch/microblaze/kernel/prom.c | =A0113
>> ----------------------------------------
>> =A0arch/powerpc/kernel/prom.c =A0 =A0| =A0114
>> ----------------------------------------
>> =A0drivers/of/base.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0116
>> +++++++++++++++++++++++++++++++++++++++++
>> =A03 files changed, 116 insertions(+), 227 deletions(-)
>>
>
> Should the prom_{add,remove,update}_property routines belong in base.c or
> of_dynamic.c (patches coming soon for of_dynamic.c)?
> My original patch set put these routines in of_dynamic.c and renamed
> them to of_{add,remove,update}_property since they are part of the of
> code.

First stage for me is to go through the rather mechanical process of
merging common code.  As much as possible I'm not changing any APIs,
and I don't have enough background on the of_dynamic stuff to make a
call about where it should ultimately live.  The goal of the first
stage is simply to eliminate duplicated code.  Rename of functions to
of_ is potentially risky, so I'm deferring those changes until after
all the code is merged.

Feel free to make changes on top of what I'm doing.  Keep each one
small to reduce the risk of conflict.  I'll pick up the ones that make
sense.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
