From: David Miller <davem@davemloft.net>
Date: Wed, 16 Sep 2009 08:14:35 +0000
Subject: Re: Sparc release requalification
Message-Id: <20090916.011435.70116885.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Wed, 16 Sep 2009 09:57:22 +0200

> On Tue, Sep 15, 2009 at 12:05:30PM +0200, S=E9bastien Bernard wrote:
>>> I was able to reproduce the hang with your originally posted config.
>>>
>>> It only triggers when CONFIG_PROM_CONSOLE is enabled
>>>  =20
>> Very good news.
>> I had a lot of trouble because of this.
>> I had to disable it for initcall_debug to work, but then, any kernel =20
>> patched or not was working.
>> I thought I messed up between patches and built kernels.
>> I realize now that I had the explanation under my nose.
>> Duh....
>=20
> I had just recompiled and booted my SMP kernel without the dreaded
> PROM_CONSOLE, and yet the machine got stuck in the same place in the
> NMI code. I then removed initcall_debug, and it still doesn't work.
> What am I missing?!
>=20
> The .config diff between the working UP kernel and this one is:

I put up the kernel image I booted with your config (sans PROM_CONSOLE)
at:

	http://vger.kernel.org/~davem/vmlinux-debug

give it a try.
