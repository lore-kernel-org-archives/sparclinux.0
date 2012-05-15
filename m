From: David Miller <davem@davemloft.net>
Date: Tue, 15 May 2012 17:06:48 +0000
Subject: Re: [PATCH] sparc32: Remove cypress cpu support.
Message-Id: <20120515.130648.766436692264173586.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120515.010944.1681839607025121917.davem@davemloft.net>
In-Reply-To: <20120515.010944.1681839607025121917.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 15 May 2012 20:01:01 +1000

> Hi,
>=20
> On Tue, May 15, 2012 at 6:41 PM, Josip Rodin <joy@entuzijast.net> wrote:
>> On Tue, May 15, 2012 at 02:16:08AM -0500, Dennis Gilmore wrote:
>>> El Tue, 15 May 2012 01:09:44 -0400 (EDT)
>>> David Miller <davem@davemloft.net> escribi=F3:
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prom_printf("Sparc-Linux Cypres=
s support
>>> > does not longer exit.\n");
>>>
>>> maybe that should say
>>> "Sparc-Linux Cypress support no longer exists.\n"
>>
>> Or "You actually run a Cypress SPARC? Please mail sparclinux@vger.kernel=
.org\n"
>=20
> I think that's a much better message =3D)

I don't, because I have no intention of ever putting the Cypress
support back into the tree.

They can go use one of the BSDs or a release based upon an older
kernel instead.
