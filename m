From: James Clarke <jrtc27@jrtc27.com>
Date: Thu, 24 Nov 2016 22:32:05 +0000
Subject: Re: [PATCH] silo: Add 64-bit support
Message-Id: <96D2CE3B-A9A2-469B-8718-B0ABBFAD4467@jrtc27.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

> On 24 Nov 2016, at 22:26, John Paul Adrian Glaubitz <glaubitz@physik.fu-b=
erlin.de> wrote:
>=20
> On 11/24/2016 11:05 PM, Aaro Koskinen wrote:
>> I think that's your job to try. If you want to "add 64-bit support"
>> (instead of forcing it to everybody), do the required changes so that
>> it's still works for everybody without extra fiddling.
>=20
> Don't be so rude, I'm not forcing anything onto anyone.
>=20
>>>> Also you broke the tilo build...
>>>=20
>>> Not here. Just tried it again and it builds fine. Can you be more speci=
fic?
>>=20
>> The same issue as with silo.
>=20
> Don't you think your statements are a bit misleading then? I didn't break=
 anything,
> I changed the default target to 64-bit which is somewhat reasonable in th=
e year
> 2016, isn't it.
>=20
> Or are you going to tell me now that your 333 MHz, 128 MiB RAM Sun Ultra =
5 is
> your everyday production machine?

Part of the problem is not forcing 64-bit, but that the Makefile is inconsi=
stent.
The default CC is gcc without any flags, but ld is given -m elf64_sparc. If=
 you
are running with sparc32 as your default target, gcc will generate 32-bit f=
iles
but ld expects 64-bit. If you really want to force 64-bit, you should also =
pass
appropriate -m64/-64 flags to gcc/as. However, I think the sensible, least
controversial solution is to just drop the -m elf64_sparc and let everything
be the default. It was only changed to force 32-bit in c836dbda because 64-=
bit
support wasn=E2=80=99t present.

Regards,
James

