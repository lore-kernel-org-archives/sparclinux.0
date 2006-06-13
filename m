From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Tue, 13 Jun 2006 06:15:50 +0000
Subject: Odp: vmalloc can clobber framebuffer on sparc32
Message-Id: <448e5816e042a@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Dnia 12-06-2006 o godz. 8:43 Bob Breuer napisa=B3(a):
> David Miller wrote:
> > From: Bob Breuer <breuerr@mc.net>
> > Date: Sun, 11 Jun 2006 20:21:09 -0500
> >=20
> >> David Miller wrote:
> >>> But why in the world does the scheduler "lock up" just
because the
> >>> migration cost is too large?
> >> There is an address space collision between the vmalloc area
and where
> >> the prom maps the framebuffer.
> >=20

I run the kernel without the framebuffer (on serial console). I
saw many vmalloc warnings trigered in vmap_pte_range()
[mm/vmalloc.c line 97].=20
I supposed they were done from measure_one() [kernel/sched.c].

I have only CG6 installed in SS20. I have not the CG14 VRAM. The
warnings were triggered from the first call to measure_one(). The
calls were done with the smallest size (64K) first so the size
should not matter.

I hope it helps,
Krzysztof.

----------------------------------------------------
CIBELLE na koncertach w Sopocie (23.06) i Warszawie (24.06).
Zmys=B3owa bossa nowa, elementy jazzu oraz odrobina elektroniki.=20
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fchat_cibelle=
.html&sidy2


