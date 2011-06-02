From: David Miller <davem@davemloft.net>
Date: Thu, 02 Jun 2011 21:36:22 +0000
Subject: Re: [PATCH 1/3 v3] sparc32: added CONFIG_PCIC_PCI Kconfig setting
Message-Id: <20110602.143622.27567493396791333.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1306220688-8438-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1306220688-8438-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 25 May 2011 08:47:41 +1000

> On Tue, May 24, 2011 at 17:04, Daniel Hellstrom <daniel@gaisler.com> wrot=
e:
>> @@ -1650,7 +1650,7 @@ pcic_nmi_trap_patch:
>> =A0 =A0 =A0 =A0 rd =A0 =A0 %psr, %l0
>> =A0 =A0 =A0 =A0.word =A0 0
>>
>> -#endif /* CONFIG_PCI */
>> +#endif /* CONFIG_PCI_PCIC */
>=20
> This should be CONFIG_PCIC_PCI

I fixed this up when applying the patches.
