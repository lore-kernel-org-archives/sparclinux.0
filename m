From: Jurij Smakov <jurij@wooyd.org>
Date: Tue, 08 Feb 2005 03:34:44 +0000
Subject: Re: Hang in SIOCGIFCONF ioctl handler
Message-Id: <Pine.LNX.4.61.0502072218510.3446@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0502071259370.2050@bobcat>
In-Reply-To: <Pine.LNX.4.61.0502071259370.2050@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Mon, 7 Feb 2005, David S. Miller wrote:

> On Mon, 7 Feb 2005 13:21:16 -0500 (EST)
> Jurij Smakov <jurij@wooyd.org> wrote:
>
>> 510                 size_t len =3D((ifc32.ifc_len / sizeof (struct ifreq=
32)) + 1) *
>> 511                         sizeof (struct ifreq);
>> 512                 uifc =3D compat_alloc_user_space(sizeof(struct ifcon=
f) + len);
>> 513                 ifc.ifc_len =3D len;
>> 514                 ifr =3D ifc.ifc_req =3D (void __user *)(uifc + 1);
>> 515                 ifr32 =3D compat_ptr(ifc32.ifcbuf);
>> 516                 for (i =3D 0; i < ifc32.ifc_len; i +=3D sizeof (stru=
ct ifreq32)) {
>> 517                         if (copy_in_user(ifr, ifr32, sizeof(struct i=
freq32)))
>> 518                                 return -EFAULT;
>> 519                         ifr++;
>> 520                         ifr32++;
>> 521                 }
>>
>> By inserting some debugging statements, I was able to figure out that
>> machine hangs because at some point the call to copy_in_user function do=
es
>> not return.
>
> How big are the values "ifc32.ifc_len" and the length passed into the
> compat_alloc_user_space() call for the failure case?

Hi Dave,

I have inserted the printk statements before, after and inside the loop.
The debugging output (including the previous successfull execution of the=20
loop) right before the hang looks like this:

dev_ifconf[516]: alloc_size=11056 ifc.ifc_len=11040 ifc32.ifc_len=8800
dev_ifconf[518]: i=3D0 ifr=00000000713163f8 ifr32=0000000071319050
dev_ifconf[518]: i2 ifr=0000000071316420 ifr32=0000000071319070
dev_ifconf[518]: id ifr=0000000071316448 ifr32=0000000071319090
dev_ifconf[518]: i=96 ifr=0000000071316470 ifr32=00000000713190b0
[...]
dev_ifconf[518]: i=8736 ifr=0000000071318ea0 ifr32=000000007131b270
dev_ifconf[518]: i=8768 ifr=0000000071318ec8 ifr32=000000007131b290
dev_ifconf[524]: after loop
dev_ifconf[516]: alloc_size=11056 ifc.ifc_len=11040 ifc32.ifc_len=8800
dev_ifconf[518]: i=3D0 ifr=00000001efffacf8 ifr32=00000000efffd898

alloc_size is the amount allocated by compat_alloc_user_space(). The only=20
"strange" thing I can notice is the ifr address. On a few previous calls=20
to this function starting ifr (at i=3D0) looks like that:

ifr=00000000efffb3b0
ifr=00000000efffacc0
ifr=00000000efffb328
ifr=00000000efffb2b8

and so on. The ifr address right before the hang has an extra bit set.

I hope it helps,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC

