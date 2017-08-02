From: "Zi Yan" <zi.yan@cs.rutgers.edu>
Date: Wed, 02 Aug 2017 02:28:40 +0000
Subject: Re: [mmotm:master 50/189] include/linux/swapops.h:220:9: error: implicit declaration of function '__
Message-Id: <3B5D0C56-FCBC-4911-9BE8-9CA895CBE49F@cs.rutgers.edu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_MailMate_3649D1C7-04B9-4810-B4B8-303C371ACD27_="
List-Id: <sparclinux.vger.kernel.org>
References: <201708011949.LtRajyO5%fengguang.wu@intel.com>
 <20170801143853.f210976a43d009dba1eeb0db@linux-foundation.org>
In-Reply-To: <20170801143853.f210976a43d009dba1eeb0db@linux-foundation.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, Linux Memory Management List <linux-mm@kvack.org>, sparclinux@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_3649D1C7-04B9-4810-B4B8-303C371ACD27_=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1 Aug 2017, at 17:38, Andrew Morton wrote:

> On Tue, 1 Aug 2017 19:57:54 +0800 kbuild test robot <fengguang.wu@intel=
=2Ecom> wrote:
>
>> tree:   git://git.cmpxchg.org/linux-mmotm.git master
>> head:   7961d18ba492e06ad240d37a5502c418b5f0a928
>> commit: 25faf0ef110322719330fcadf4fe541528bacd4d [50/189] mm-thp-enabl=
e-thp-migration-in-generic-path-fix
>> config: sparc-defconfig (attached as .config)
>> compiler: sparc-linux-gcc (GCC) 6.2.0
>> reproduce:
>>         wget https://na01.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Fraw.githubusercontent.com%2F01org%2Flkp-tests%2Fmaster%2Fsbin%2=
Fmake.cross&data=3D02%7C01%7Czi.yan%40cs.rutgers.edu%7C30301965f5964988c1=
8f08d4d925b5f4%7Cb92d2b234d35447093ff69aca6632ffe%7C1%7C0%7C6363722033712=
43236&sdata=3DQEB2C6y9u7ZfV4Ej%2F8M0BLMUi%2FI2XFVHStMPvPeyiFA%3D&reserved=
=3D0 -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         git checkout 25faf0ef110322719330fcadf4fe541528bacd4d
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=3Dsparc
>>
>> All errors (new ones prefixed by >>):
>>
>>    In file included from fs/proc/task_mmu.c:15:0:
>>    include/linux/swapops.h: In function 'swp_entry_to_pmd':
>>>> include/linux/swapops.h:220:9: error: implicit declaration of functi=
on '__pmd' [-Werror=3Dimplicit-function-declaration]
>>      return __pmd(0);
>>             ^~~~~
>>>> include/linux/swapops.h:220:9: error: incompatible types when return=
ing type 'int' but 'pmd_t {aka struct <anonymous>}' was expected
>>      return __pmd(0);
>>             ^~~~~~~~
>>    cc1: some warnings being treated as errors
>>
>> vim +/__pmd +220 include/linux/swapops.h
>>
>>    217	=

>>    218	static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
>>    219	{
>>> 220		return __pmd(0);
>>    221	}
>>    222	=

>>
>
> Seems that sparc32 forgot to implement __pmd()?

Hi Sam,

I saw __pmd() was deleted at commit 6e6e41879: sparc32: fix build with ST=
RICT_MM_TYPECHECKS.
It was commented out at least since 2008, before commit a439fe51a.

Is there any way to bring it back? Since __pmd() can help us work around =
a GCC zero initializer bug.

Thanks.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_3649D1C7-04B9-4810-B4B8-303C371ACD27_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJZgTjZAAoJEEGLLxGcTqbMHWkH/2Ton+66x+RRZjfL9DXsKKPI
t/+ydUusa5TrKZ41qIP9UiTIeaAaPzEvbqxWv3r7aLWrhtD6Bvp9yxmo+jY6K9ke
Z0FkoLQ1FnOpvZSkZnv2R0CmrHwprd0DwPJXPo+JPUpLp2+pnkgBNcFFiAVkBhXK
AOLA8sKF6QUWYLrTM7VfrCtt2+uPVkT+MB8ce+MxH6ofVBg4CsG4OzUroaR1+CT9
5cZDDSMleKNnnaXwwMEv04Ksk8NISSZyBBtZwK5vSgET5taJEWr/c5Z2jPYUxws3
aJiTptDsAAA2LQp/bejB8udOEmQUph4fXlXCLzyNGUR0PxyPwrSWaHosAIv3Vao=
=i3TQ
-----END PGP SIGNATURE-----

--=_MailMate_3649D1C7-04B9-4810-B4B8-303C371ACD27_=--
