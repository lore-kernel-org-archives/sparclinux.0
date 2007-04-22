From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Sun, 22 Apr 2007 07:49:52 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <462B13A0.5040108@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Georg Chini a =E9crit :
>=20
>=20
> David Miller wrote:
>=20
>>
>> I only need to resolve the bug that Bertrand is still seeing
>> where the reconnect tag gets corrupted somehow.
>>
>> I'll try to work on that over the weekend, but for everyone
>> else keep beating on it :-)
>> -
>>
>> =20
>>
> Hi Dave,
>=20
> I'm seeing the same problem on my ultra2 with 2.6.21-rc7 and
> your patch. Even the message is the same. Maybe it is connected
> to the use of md-devices, as far as I could see from the logs
> Bertrand is also using md-devices. If I can provide any debugging
> output, please advise.

	Hello,

	My SS20 use raid1 too. I haven't test without raid.

	Regards,

	JKB
