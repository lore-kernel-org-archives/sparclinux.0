From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Sat, 22 Dec 2007 13:10:36 +0000
Subject: Re: No dma_sync_* during pci_probe? (Sparc, post 2.6.22	regression)
Message-Id: <476D0CCC.2050402@s5r6.in-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <4767A323.7090205@s5r6.in-berlin.de> <20071218.142956.26529678.davem@davemloft.net> <476947C1.2010405@s5r6.in-berlin.de> <20071220.004033.75315225.davem@davemloft.net> <20071220201901.GA30969@darkmoon.home>
In-Reply-To: <20071220201901.GA30969@darkmoon.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@suse.de, krh@bitplanet.net, linux1394-devel@lists.sourceforge.net

Emanuele Rocca wrote:
> * David Miller <davem@davemloft.net>, [2007-12-20  0:40 -0800]:
>>  The problem is that I created indirection that was totally unused, the
>>  operation vectors members for these cases thus didn't get filled in,
>>  and we OOPS trying to call NULL pointers as functions :-)
>> =20
>>  This should fix the crash:
>=20
> It does, tested on a Sun Blade 2000.

Thanks David and Emanuele.  I haven't got feedback from the other
reporter yet but I assume this fixes the issue
(http://bugzilla.kernel.org/show_bug.cgi?id=9160).
--=20
Stefan Richter
-=3D=3D=3D-=3D-=3D=3D =3D-- =3D-=3D-
http://arcgraph.de/sr/
