From: Rene Rebe <rene@exactcode.de>
Date: Thu, 29 Jun 2006 11:09:54 +0000
Subject: Re: booting the T1000
Message-Id: <200606291309.54737.rene@exactcode.de>
List-Id: <sparclinux.vger.kernel.org>
References: <200606290937.49481.rene@exactcode.de>
In-Reply-To: <200606290937.49481.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

On Thursday 29 June 2006 11:04, David Miller wrote:
> From: Rene Rebe <rene@exactcode.de>
> Date: Thu, 29 Jun 2006 09:37:49 +0200
>=20
> > In a blog of someone working on the Ubuntu suport I found a note
> > about "problems with hpa-tftpd", so I tried iputils/tftpd and atftpd wi=
thout
> > success. Note  that an Ultra30 booted the same image served from the
> > same daemons just fine.
>=20
> iputils inetd doesn't work well with tftpd at all, it propagates the
> non-blocking setting of the socket down to tftpd which is not expecting
> this.
>=20
> Use netkit-inetd and it should go fine.  That's what I'm using here.

Thanks for this hints, switching to netkit-tftpd made the OBP tftp client
load the image ,-)

Yours,

--=20
Ren=E9 Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://exactcode.de | http://t2-project.org | http://rebe.name
            +49 (0)30 / 255 897 45
