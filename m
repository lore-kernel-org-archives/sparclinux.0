From: James Clarke <jrtc27@jrtc27.com>
Date: Wed, 26 Oct 2016 17:21:06 +0000
Subject: Re: [PATCH] sparc64: Handle extremely large kernel TSB range flushes sanely.
Message-Id: <6EF334A5-D690-4076-ACD6-2C959B31AF80@jrtc27.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20161025.224442.1417439049113609110.davem@davemloft.net>
In-Reply-To: <20161025.224442.1417439049113609110.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

> On 26 Oct 2016, at 18:09, David Miller <davem@davemloft.net> wrote:
>=20
> From: James Clarke <jrtc27@jrtc27.com>
> Date: Wed, 26 Oct 2016 17:58:16 +0100
>=20
>>> On 26 Oct 2016, at 16:54, David Miller <davem@davemloft.net> wrote:
>>>=20
>>> From: James Clarke <jrtc27@jrtc27.com>
>>> Date: Wed, 26 Oct 2016 09:28:05 +0100
>>>=20
>>>> Any progress on TLB flushing?
>>>=20
>>> I'll keep plugging away at it today.
>>=20
>> Great; let me know if you need a guinea pig, as it=E2=80=99s pretty easy=
 for me to
>> reproduce.
>=20
> Will do, what kind of cpus do you have?

* UltraSparc T5 (Niagara5)
* UltraSparc T1 (Niagara)
* UltraSPARC IIIi

The IIIi seems to be down at the moment though.

James

