From: David Miller <davem@davemloft.net>
Date: Wed, 16 Feb 2011 01:31:34 +0000
Subject: Re: Sun Ultra2 (enterprise) finally failed... (stupid eprom)
Message-Id: <20110215.173134.193733022.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <AANLkTim2qJw9tvztMSiY1+1nS3UUOfsR7ZQEX1K5rFwB@mail.gmail.com>
In-Reply-To: <AANLkTim2qJw9tvztMSiY1+1nS3UUOfsR7ZQEX1K5rFwB@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 16 Feb 2011 11:02:15 +1100

> On Wed, Feb 16, 2011 at 10:38, Leif Sawyer <lsawyer@gci.com> wrote:
>> My poor 14yo sparc finally bit the dust --
>> well, actually, the battery in the prom finally gave up and lost
>> its config during the last power-cycle.
>>
>> So, now I'm looking for a replacement M48T59Y-70PC1 =A0from some reputib=
le dealer,
>> and preferably one that one cost an extra 50$ just to ship to Alaska...
>=20
> There is a hack to replace the battery. [1] I've got a SSLX with a
> similar issue which needs that, but haven't gotten around to doing it
> yet. Also remember that you're going to have to re-program the chip as
> it contains some important config information.

Whilst sparc32 chips absolutely need this config information set
properly (it contains the system type value), on sparc64 systems it
only really carries the date and the ethernet address.

And then of course the checksum has to be set correctly after
you've filled it in :-)
