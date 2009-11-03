From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 03 Nov 2009 22:48:20 +0000
Subject: Re: [PATCH 1/1] Support for GRLIB APBUART serial port
Message-Id: <646765f40911031448j7a602871gc3a08fc5773adce@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1257173328-25144-1-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257173328-25144-1-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Tue, Nov 3, 2009 at 01:48, Kristoffer Glembo <kristoffer@gaisler.com> wr=
ote:
> This patch adds support for the APBUART serial port from Aeroflex
> Gaisler's IP library GRLIB. It is currently used in all LEON3 designs
> (SPARC V8) but can be used on other platforms as well.
[snip]
> +config SERIAL_GRLIB_GAISLER_APBUART
> + =A0 =A0 =A0 tristate "GRLIB APBUART serial support"
> + =A0 =A0 =A0 depends on SPARC_LEON
> + =A0 =A0 =A0 ---help---
> + =A0 =A0 =A0 Add support for the GRLIB APBUART serial port.
> +

Shouldn't it then depend on OpenFirmware rather than SPARC_LEON?

Thanks,

--=20

Julian Calaby

Email: julian.calaby@gmail.com
.Plan: http://sites.google.com/site/juliancalaby/
