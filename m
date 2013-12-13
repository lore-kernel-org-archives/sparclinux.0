From: =?UTF-8?B?UmHDumwgUG9yY2Vs?= <armin76@gentoo.org>
Date: Fri, 13 Dec 2013 11:46:06 +0000
Subject: Re: Issue booting Niagara T1 after commit 87fa05aeb3
Message-Id: <52AAF37E.4000505@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
References: <528B57AF.6020106@fabbione.net>
In-Reply-To: <528B57AF.6020106@fabbione.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hello,

On 12/12/13 14:09, Kirill Tkhai wrote:
> Hi,
>=20
> 12.12.2013, 16:33, "Ra=C3=BAl Porcel" <armin76@gentoo.org>:
>> Same here, I tried with the default config.
>=20
> just hypothesis. Does "nohlt" command line option help anyway?
>=20
> Does anything change if you are swapping local_irq_enable() and
> preempt_disable() in smp_callin() (file arch/sparc/kernel/smp_64.c):

Tried both of the suggestions, none worked.

Thanks

