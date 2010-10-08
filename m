From: David Miller <davem@davemloft.net>
Date: Fri, 08 Oct 2010 19:02:16 +0000
Subject: Re: [PATCH] sparc: stop exporting openprom.h header
Message-Id: <20101008.120216.232734365.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20101008113424.2249c2df@debxo>
	<20101008.115226.179923658.davem@davemloft.net>
	<AANLkTikuaM5VZadCs302HwYYhOHi1Czw2BLam3ZQP=aj@mail.gmail.com>
In-Reply-To: <AANLkTikuaM5VZadCs302HwYYhOHi1Czw2BLam3ZQP=aj-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org

From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 8 Oct 2010 13:00:25 -0600

> On Fri, Oct 8, 2010 at 12:52 PM, David Miller <davem@davemloft.net> wrote:
>> From: Andres Salomon <dilinger@queued.net>
>> Date: Fri, 8 Oct 2010 11:34:24 -0700
>>
>>>
>>> It's unknown why openprom.h was being exported; there doesn't seem to b=
e any
>>> reason for it currently, and it creates headaches with userspace being =
able
>>> to potentially use the structures in there. =A0So, don't export it anym=
ore.
>>>
>>> Signed-off-by: Andres Salomon <dilinger@queued.net>
>>
>> Acked-by: David S. Miller <davem@davemloft.net>
>=20
> I suppose it makes sense for me to pick this one up into my tree so it
> is grouped with the rest of the pdt patches.  I'll pick it up once
> Andres reposts the series.

Yep, that makes sense.
