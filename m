From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Mon, 20 Aug 2007 08:50:28 +0000
Subject: Odp: possible endless loop in PROM initialization
Message-Id: <46c955d43d407@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <20070820075949.GA5927@vimes.madsworld.lan>
In-Reply-To: <20070820075949.GA5927@vimes.madsworld.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Markus Dahms <mad@automagically.de>
Cc: sparclinux <sparclinux@vger.kernel.org>, linux-kernel@vger.kernel.org

Dnia 20-08-2007 o godz. 9:59 Markus Dahms napisa=B3(a):
> Hey,
>=20
> while trying to define a non-unique devalias at the Sun PROM prompt
> (the SPARCclassic X has wrong aliases for scsi, disk1, etc. in the
> PROM, at least mine) I fell over a bug resulting in an endless loop
> while booting the kernel.
>=20
> The problem is the getting the properties list of the /aliases
node.
> As the next element in this list is identified by name and the
> function which retrieves this property always returns the first
> occurrence this goes forever....
>

Could you give name of the function which contains this endless loop?
When I looked into the tree.c file for the first time I thought
it had a bug
in handling the prom_nextprop, but later I concluded that this is ok.
Maybe there is a bug there after all.

Regards,
Krzysztof

----------------------------------------------------
Wielka siatk=F3wka we wrze=B6niu w Starych Jab=B3onkach
zobacz gwiazdy siatk=F3wki pla=BFowej na =BFywo!=20
Mistrzostwa =A6wiata w siatk=F3wce pla=BFowej 5-9.09.2007
Kliknij: http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fsta=
rejablonki.html&sid=1262


