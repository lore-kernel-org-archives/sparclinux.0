From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Mon, 18 Feb 2008 09:25:34 +0000
Subject: Re: [Ann] SparcV8 depot
Message-Id: <47B94F0E.6080902@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <47B6AE0B.1090906@systella.fr>
In-Reply-To: <47B6AE0B.1090906@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Chris Andrew wrote:
> CC'd this to a list that is trying to keep sparc-32 alive
> (http://wiki.debian.org/Sparc32).
> Thanks,
>=20
> Chris.
>=20
> On 18/02/2008, Martin Habets <errandir_news@mph.eclipse.co.uk> wrote:
>> Hi Jo=EBl,
>>
>> I've got an SS20 with dual hypersparc. Kernels post 2.6.21 boot okay,
>> run in general, but a 'make -j 3' build of the kernel aborts a couple of
>> times with a bus error or similar vague errors.
>>
>> I'd be interested in a V8 repository.
>>
>> Martin
>>
>> On Sat, Feb 16, 2008 at 10:34:03AM +0100, BERTRAND Jo=EBl wrote:
>>>       Hi folks,
>>>
>>>       I have built a 2.6.24.2 linux kernel on my SS20 (dual SM71) and it
>>>       is stable in SMP configuration with HIGHMEM. I haven't tested with
>>> HyperSPARC. Has anyone any information about HyperSPARC support ? I
>>> shall test, but if someone has tried before me... ;-)
>>>
>>>       I'm building deb packages to upgrade this workstation to
>>>       debian/testing (with of course only V8 support not V8+). I don't =
know if
>>> someone can be interested, but I think we can open a depot for sparc-V8
>>> package. I think I shall open an anonymous ftp server next week, but I
>>> won't do anything if I'm alone.
>>>
>>>       Regards,
>>>
>>>       JKB

	Hello,

	You can download first debian packages (strict V8) on=20
http://newton.systella.fr/~bertrand/sparc32. I have uploaded a kernel=20
(with built-in SX framebuffer support). URL can changes soon...

	Regards,

	JKB
