From: Cajus Pollmeier <cajus@naasa.net>
Date: Mon, 29 Mar 2004 21:05:39 +0000
Subject: Re: srmmu: out of nocache
Message-Id: <200403292305.41236.cajus@naasa.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200403282153.19509.lists@naasa.net>
In-Reply-To: <200403282153.19509.lists@naasa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Montag, 29. M=E4rz 2004 12:21, Keith M Wesolowski wrote:
> On Mon, Mar 29, 2004 at 08:25:09AM +0200, Joerg Platte wrote:
>=20
> > OK, here's the first report for a 2.6.4... :-) I had more problems with=
 a=20
> > 2.6.3, but the problem remains... Is it possible to increase the nocach=
ed=20
> > part of the memory?
>=20
> Yes, but I don't recommend it.  You're using only about 2/3 of the
> pagetable memory when you run out because of fragmentation.
>=20
> This patch changes the next-fit allocator to a next/first to possibly
> reduce fragmentation.  There is some performance cost associated.
> Please try it and report your results.  If it does fail, the log
> messages are important.

Ok. I've recompiled the kernel with your patch (hell - I guess we've to
make use of cross compiling...) The machine boots cleanly and
everything works fine till this moment. Cronjobs, etc. fire up tomorrow
and we'll inspect the system mails for "out of nocache" messages and
other anomalies.

Thanks,
Cajus
