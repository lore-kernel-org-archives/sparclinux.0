From: James Clarke <jrtc27@jrtc27.com>
Date: Fri, 21 Oct 2016 21:52:45 +0000
Subject: Re: Regression with 4.7.2 on sun4u
Message-Id: <B7B80838-8050-4291-838B-3188EE8DACC1@jrtc27.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Apple-Mail=_F5FAE877-8953-43BB-BC02-876E0E881C11"
List-Id: <sparclinux.vger.kernel.org>
References: <3fc12066-505b-5f87-cbbe-88593a736162@physik.fu-berlin.de>
In-Reply-To: <3fc12066-505b-5f87-cbbe-88593a736162@physik.fu-berlin.de>
To: sparclinux@vger.kernel.org


--Apple-Mail=_F5FAE877-8953-43BB-BC02-876E0E881C11
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 21 Oct 2016, at 18:47, James Clarke <jrtc27@jrtc27.com> wrote:
>> On 21 Oct 2016, at 18:26, David Miller <davem@davemloft.net> wrote:
>>=20
>> From: Rob Gardner <rob.gardner@oracle.com>
>> Date: Fri, 21 Oct 2016 09:49:30 -0600
>>=20
>>> That could be either a stray memory write or a boot time patch gone
>>> wrong.
>>=20
>> It could be that we need to use non-predicting branches in the jump
>> label implementation.  We could be overflowing the branch =
displacement
>> range if the kernel being built is really huge.
>>=20
>> Something like the following would fix it if true:
>>=20
>> diff --git a/arch/sparc/kernel/jump_label.c =
b/arch/sparc/kernel/jump_label.c
>> index 59bbeff..841d98e 100644
>> --- a/arch/sparc/kernel/jump_label.c
>> +++ b/arch/sparc/kernel/jump_label.c
>> @@ -19,13 +19,8 @@ void arch_jump_label_transform(struct jump_entry =
*entry,
>>   if (type =3D=3D JUMP_LABEL_JMP) {
>>       s32 off =3D (s32)entry->target - (s32)entry->code;
>>=20
>> -#ifdef CONFIG_SPARC64
>> -        /* ba,pt %xcc, . + (off << 2) */
>> -        val =3D 0x10680000 | ((u32) off >> 2);
>> -#else
>>       /* ba . + (off << 2) */
>>       val =3D 0x10800000 | ((u32) off >> 2);
>> -#endif
>>   } else {
>>       val =3D 0x01000000;
>>   }
>>=20
>=20
> (Was top-post; moved here)
>=20
> Yes, I found that. I don't think its overflowing, more negative (hence =
the
> 3ffffff2, which would be fffff88 or something like that for off). =
Trying with
> that masked appropriately. If it works I'll send a patch with =
appropriate
> BUG_ONs.

This indeed was the case. The attached patch fixes the problem for me,
generating 0x106ffff2, which gdb can verify is sensible (of course, the
addresses have shifted slightly):

(gdb) x/10xw 0x5c9880
0x5c9880:	0x400f10d0	0x01000000	0x106ffff2	=
0x01000000
0x5c9890:	0x106fffc8	0x01000000	0xc611a036	=
0x05002c36
0x5c98a0:	0x8410a038	0x8328f030
(gdb) x/i 0x5c9888
   0x5c9888:	b  %xcc, 0x5c9850
   0x5c988c:	nop=20

I also took the opportunity to correct the misleading/incorrect =
comments.
Please let me know if you=E2=80=99d like this properly submitted =
git-send-email style.

Regards,
James

--Apple-Mail=_F5FAE877-8953-43BB-BC02-876E0E881C11
Content-Disposition: attachment;
	filename=0001-sparc-Handle-negative-offsets-in-arch_jump_label_tra.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0001-sparc-Handle-negative-offsets-in-arch_jump_label_tra.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=2027ecad347d19c613d4e85665e710f1bd6bd56117=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20James=20Clarke=20<jrtc27@jrtc27.com>=0ADate:=20=
Fri,=2021=20Oct=202016=2019:11:10=20+0100=0ASubject:=20[PATCH]=20sparc:=20=
Handle=20negative=20offsets=20in=20arch_jump_label_transform=0A=0A=
Signed-off-by:=20James=20Clarke=20<jrtc27@jrtc27.com>=0A---=0A=20=
arch/sparc/kernel/jump_label.c=20|=2016=20++++++++++++----=0A=201=20file=20=
changed,=2012=20insertions(+),=204=20deletions(-)=0A=0Adiff=20--git=20=
a/arch/sparc/kernel/jump_label.c=20b/arch/sparc/kernel/jump_label.c=0A=
index=2059bbeff..dec09ce=20100644=0A---=20=
a/arch/sparc/kernel/jump_label.c=0A+++=20=
b/arch/sparc/kernel/jump_label.c=0A@@=20-19,12=20+19,20=20@@=20void=20=
arch_jump_label_transform(struct=20jump_entry=20*entry,=0A=20=09if=20=
(type=20=3D=3D=20JUMP_LABEL_JMP)=20{=0A=20=09=09s32=20off=20=3D=20=
(s32)entry->target=20-=20(s32)entry->code;=0A=20=0A+=09=09BUG_ON(off=20&=20=
3);=0A+=0A=20#ifdef=20CONFIG_SPARC64=0A-=09=09/*=20ba,pt=20%xcc,=20.=20+=20=
(off=20<<=202)=20*/=0A-=09=09val=20=3D=200x10680000=20|=20((u32)=20off=20=
>>=202);=0A+=09=09/*=20WDISP19=20-=20target=20is=20.=20+=20(immed=20<<=20=
2)=20*/=0A+=09=09BUG_ON(off=20>=200xfffff);=0A+=09=09BUG_ON(off=20<=20=
-0x100000);=0A+=09=09/*=20ba,pt=20%xcc,=20.=20+=20off=20*/=0A+=09=09val=20=
=3D=200x10680000=20|=20(((u32)=20off=20>>=202)=20&=200x7ffff);=0A=20=
#else=0A-=09=09/*=20ba=20.=20+=20(off=20<<=202)=20*/=0A-=09=09val=20=3D=20=
0x10800000=20|=20((u32)=20off=20>>=202);=0A+=09=09/*=20WDISP22=20-=20=
target=20is=20.=20+=20(immed=20<<=202)=20*/=0A+=09=09BUG_ON(off=20>=20=
0x7fffff);=0A+=09=09BUG_ON(off=20<=20-0x800000);=0A+=09=09/*=20ba=20.=20=
+=20off=20*/=0A+=09=09val=20=3D=200x10800000=20|=20(((u32)=20off=20>>=20=
2)=20&=200x3fffff);=0A=20#endif=0A=20=09}=20else=20{=0A=20=09=09val=20=3D=20=
0x01000000;=0A--=20=0A2.9.3=0A=0A=

--Apple-Mail=_F5FAE877-8953-43BB-BC02-876E0E881C11--
