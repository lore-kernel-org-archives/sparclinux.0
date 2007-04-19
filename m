From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Thu, 19 Apr 2007 12:19:48 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <46275E64.8080404@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller a =E9crit :
> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Tue, 17 Apr 2007 17:28:24 +0200
>=20
>> 	esp: esp0: reconnect, tag type changed 22 --> 00
>=20
> There is a bug in this error message, could you reproduce
> this with the following fix applied so I can debug this
> further?
>=20
> The patch might apply with some fuzz.  Even if it doesn't
> apply, it is very easy for you to hand edit the file to
> change that esp->command_block[1] into esp->command_block[0]
> :-)

	Thanks. Patch applied. Now, kernel says :
...
/dev/md1: clean, 220181/1251712 files...
esp: esp0: Reconnect, tag type changed 22 --> 20
esp: esp0: Aborting command [fbc5f3c0:2a]
esp: esp0: Queued command [fbc5f3c0:2a]
esp: esp0: Queued command [fbc5f4e0:2a]
esp: esp0: Dumping command log

followd by a lot of insane messages ;-)

	Regards,

	JKB
