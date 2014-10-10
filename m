From: David Miller <davem@davemloft.net>
Date: Fri, 10 Oct 2014 04:32:38 +0000
Subject: Re: [PATCH] bcma: Add dependency on OF_ADDRESS
Message-Id: <20141010.003238.851779524160284732.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5436C2B4.6030801@broadcom.com>
	<20141009172120.GB2410@roeck-us.net>
	<CAGRGNgWWSX8rYatphNAmx+j3wZ7RAXgucUzi_7M6-3NeUjQDEg@mail.gmail.com>
In-Reply-To: <CAGRGNgWWSX8rYatphNAmx+j3wZ7RAXgucUzi_7M6-3NeUjQDEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: julian.calaby@gmail.com
Cc: linux@roeck-us.net, sparclinux@vger.kernel.org, arend@broadcom.com, zajec5@gmail.com, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, hauke@hauke-m.de, arnd@arndb.de

From: Julian Calaby <julian.calaby@gmail.com>
Date: Fri, 10 Oct 2014 11:24:53 +1100

> Hi,
>=20
> On Fri, Oct 10, 2014 at 4:21 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On Thu, Oct 09, 2014 at 07:15:32PM +0200, Arend van Spriel wrote:
>>> On 10/09/14 18:54, Rafa=A9=A9 Mi=A9=A9ecki wrote:
>>> >On 9 October 2014 18:41, Guenter Roeck<linux@roeck-us.net>  wrote:
>>> >>Commit 2101e533f41a ("bcma: register bcma as device tree driver")
>>> >>introduces a hard dependency on OF_ADDRESS into the bcma driver.
>>> >>OF_ADDRESS is specifically disabled for the sparc architecture.
>>> >>This results in the following error when building sparc64:allmodconfi=
g.
>>>
>>> Does this mean on sparc (using allmodconfig) you will get CONFIG_OF
>>> and !CONFIG_OF_ADDRESS? Does that makes sense?
>>>
>>
>> You tell me. From drivers/of/Kconfig:
>>
>> config OF_ADDRESS
>>         def_bool y
>>         depends on !SPARC
>>         select OF_ADDRESS_PCI if PCI
>>
>> Presumably there is a reason to disable OF_ADDRESS for sparc.
>=20
> Why not ask the sparclinux list? (CC'd)

On sparc, at boot time we precompute all of the addresses provided in
the OF device tree.

So we need none of this OF_ADDRESS infrastructure.

Frankly, I've always believed that this is how address computation
should be done on OF platforms, and it simplifies drivers massively.
You really only need to implement 2 or 3 bus translators to make it
work.  Others have disagreed with me.
