From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Date: Wed, 18 Oct 2017 17:20:27 +0000
Subject: Re: [PATCH v12 07/11] x86/kasan: add and use kasan_map_populate()
Message-Id: <56120ddc-e03e-dbac-50c4-adb2287ec407@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171013173214.27300-1-pasha.tatashin@oracle.com>
 <20171013173214.27300-8-pasha.tatashin@oracle.com>
 <f4540f92-2229-53f5-ee74-fe160bedc873@virtuozzo.com>
 <6fd8291b-b3f5-46c1-2650-98a775e37fa0@oracle.com>
In-Reply-To: <6fd8291b-b3f5-46c1-2650-98a775e37fa0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 10/18/2017 08:14 PM, Pavel Tatashin wrote:
> Thank you Andrey, I will test this patch. Should it go on top or replace =
the existing patch in mm-tree? ARM and x86 should be done the same either b=
oth as follow-ups or both replace.
>=20

 It's a replacement of your patch.


> Pavel
>=20
> --=20
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.=C2=A0 For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
