From: krzysztof.h1@poczta.fm
Date: Tue, 05 May 2009 08:45:05 +0000
Subject: =?UTF-8?q?Re:_[PATCH]_cg3:_use_standard_fields_for_framebuffer_physical_address_and_length?=
Message-Id: <20090505084505.C94E615F7883@f12.poczta.interia.pl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>, krzysztof.h1@poczta.fm, linux-fbdev-devel@lists.sourceforge.net, sparclinux@vger.kernel.org

David Miller napisa=B3(a):
> From: Krzysztof Helt >krzysztof.h1@poczta.fm>
> Date: Mon, 4 May 2009 22:37:46 +0200
>=20
> > Use standard fields fbinfo.fix.smem_start and fbinfo.fix.smem_len
> > for physical address and length of framebuffer.
> >=20
> > This also fixes output of the &#039;fbset -i&#039; command - address an=
d length=20
> > of the framebuffer is displayed correctly.
> >=20
> > Signed-off-by: Krzysztof Helt >krzysztof.h1@wp.pl>
>=20
> I think this is not appropriate.
>=20
> The "physical address" of these framebuffers is composed of
> two values, the 32-bit physical offset and the "which_io"
> value.  The full physical I/O address is 36 bits.
>=20
> Considering either seperately makes no sense.  And adjustments
> of one make no sense without consideration of the other.
>=20
>=20

I see. However, there is no adjustment to the smem_start outside=20
the driver. It is used only to be displayed by the fbset (which is
general and does not understand the IO spaces).
Another usage is inside the fb_mmap but only if there is no local
fb_mmap function defined by the driver. It is not a case for all sbus=20
drivers.

Regards,
Krzysztof



----------------------------------------------------------------------
Wygraj wycieczke do Eurodisneylandu!
Sprawdz >> http://link.interia.pl/f2153

