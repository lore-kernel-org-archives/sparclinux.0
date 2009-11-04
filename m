From: David Miller <davem@davemloft.net>
Date: Wed, 04 Nov 2009 13:36:08 +0000
Subject: Re: [PATCH 1/1] Support for GRLIB APBUART serial port
Message-Id: <20091104.053608.126412435.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1257173328-25144-1-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257173328-25144-1-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 4 Nov 2009 09:48:20 +1100

> On Tue, Nov 3, 2009 at 01:48, Kristoffer Glembo <kristoffer@gaisler.com> =
wrote:
>> This patch adds support for the APBUART serial port from Aeroflex
>> Gaisler's IP library GRLIB. It is currently used in all LEON3 designs
>> (SPARC V8) but can be used on other platforms as well.
> [snip]
>> +config SERIAL_GRLIB_GAISLER_APBUART
>> + =A0 =A0 =A0 tristate "GRLIB APBUART serial support"
>> + =A0 =A0 =A0 depends on SPARC_LEON
>> + =A0 =A0 =A0 ---help---
>> + =A0 =A0 =A0 Add support for the GRLIB APBUART serial port.
>> +
>=20
> Shouldn't it then depend on OpenFirmware rather than SPARC_LEON?

Yeah it probably should unless there are real dependencies
on LEON specific functions, which I don't think this serial
driver does.

Using "OF" as the dependency would be great for me because
then I'd be able to test the build on this even on sparc64.
:-)

So Kristoffer, please make this change and resubmit your patch.
The driver looks fine to me otherwise.

Thanks!
