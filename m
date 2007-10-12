From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Fri, 12 Oct 2007 05:47:56 +0000
Subject: Re: sun4v_data_access_exception on new 2.6.23
Message-Id: <470F0A8C.2060502@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <470E6F28.2010709@systella.fr>
In-Reply-To: <470E6F28.2010709@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Thu, 11 Oct 2007 20:44:56 +0200
>=20
>> 	Hello,
>>
>> 	I have built a 2.6.23 kernel on a T1000 server. I have seen this
>> message on system console :

	David,

> Looking at the trace some more, I'm %99.99999 sure you're using
> gcc-4.2.x to build this and that compiler is known to miscompile SMP
> sparc64 kernels.

	I a first time, I though that is was this trouble, but I can see the=20
same bug with debian kernel provided by debian/testing (a 2.6.22=20
kernel). I don't know what compiler was used to build debian kernel.

> gcc-4.1.x would never inline __flush_tsb_one() into flush_tsb_user(),
> yet as is evident in your backtraces this is exactly what has
> happened, therefore you must be using gcc-4.2.x or another non-4.1.x
> compiler to build this.

	OK, I will try to rebuild a kernel with gcc-4.1. Thanks for your help.

	Regards,

	JKB
