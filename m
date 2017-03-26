From: kbuild test robot <lkp@intel.com>
Date: Sun, 26 Mar 2017 09:53:55 +0000
Subject: Re: [PATCH v3 7/7] vga: Optimise console scrolling
Message-Id: <201703261730.9nRIHfGC%fengguang.wu@intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
List-Id: <sparclinux.vger.kernel.org>
References: <20170324161318.18718-8-willy@infradead.org>
In-Reply-To: <20170324161318.18718-8-willy@infradead.org>
To: sparclinux@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Matthew,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.11-rc3 next-20170324]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Matthew-Wilcox/Add-memsetN-functions/20170326-140108
config: mips-defconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   In file included from include/linux/selection.h:11:0,
                    from drivers/video/console/newport_con.c:16:
   include/linux/vt_buffer.h: In function 'scr_memsetw':
>> include/linux/vt_buffer.h:34:2: error: implicit declaration of function 'memset16' [-Werror=implicit-function-declaration]
     memset16(s, c, count / 2);
     ^~~~~~~~
   include/linux/vt_buffer.h: In function 'scr_memcpyw':
>> include/linux/vt_buffer.h:47:2: error: implicit declaration of function 'memcpy' [-Werror=implicit-function-declaration]
     memcpy(d, s, count);
     ^~~~~~
   include/linux/vt_buffer.h: In function 'scr_memmovew':
>> include/linux/vt_buffer.h:66:2: error: implicit declaration of function 'memmove' [-Werror=implicit-function-declaration]
     memmove(d, s, count);
     ^~~~~~~
   In file included from include/linux/string.h:18:0,
                    from include/linux/bitmap.h:8,
                    from include/linux/cpumask.h:11,
                    from arch/mips/include/asm/processor.h:15,
                    from arch/mips/include/asm/thread_info.h:15,
                    from include/linux/thread_info.h:25,
                    from include/asm-generic/preempt.h:4,
                    from ./arch/mips/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:80,
                    from include/linux/spinlock.h:50,
                    from include/linux/wait.h:8,
                    from include/linux/fs.h:5,
                    from include/linux/tty.h:4,
                    from include/linux/vt_kern.h:11,
                    from drivers/video/console/newport_con.c:18:
   arch/mips/include/asm/string.h: At top level:
>> arch/mips/include/asm/string.h:138:14: error: conflicting types for 'memcpy'
    extern void *memcpy(void *__to, __const__ void *__from, size_t __n);
                 ^~~~~~
   In file included from include/linux/selection.h:11:0,
                    from drivers/video/console/newport_con.c:16:
   include/linux/vt_buffer.h:47:2: note: previous implicit declaration of 'memcpy' was here
     memcpy(d, s, count);
     ^~~~~~
   In file included from include/linux/string.h:18:0,
                    from include/linux/bitmap.h:8,
                    from include/linux/cpumask.h:11,
                    from arch/mips/include/asm/processor.h:15,
                    from arch/mips/include/asm/thread_info.h:15,
                    from include/linux/thread_info.h:25,
                    from include/asm-generic/preempt.h:4,
                    from ./arch/mips/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:80,
                    from include/linux/spinlock.h:50,
                    from include/linux/wait.h:8,
                    from include/linux/fs.h:5,
                    from include/linux/tty.h:4,
                    from include/linux/vt_kern.h:11,
                    from drivers/video/console/newport_con.c:18:
>> arch/mips/include/asm/string.h:141:14: error: conflicting types for 'memmove'
    extern void *memmove(void *__dest, __const__ void *__src, size_t __n);
                 ^~~~~~~
   In file included from include/linux/selection.h:11:0,
                    from drivers/video/console/newport_con.c:16:
   include/linux/vt_buffer.h:66:2: note: previous implicit declaration of 'memmove' was here
     memmove(d, s, count);
     ^~~~~~~
   In file included from include/linux/bitmap.h:8:0,
                    from include/linux/cpumask.h:11,
                    from arch/mips/include/asm/processor.h:15,
                    from arch/mips/include/asm/thread_info.h:15,
                    from include/linux/thread_info.h:25,
                    from include/asm-generic/preempt.h:4,
                    from ./arch/mips/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:80,
                    from include/linux/spinlock.h:50,
                    from include/linux/wait.h:8,
                    from include/linux/fs.h:5,
                    from include/linux/tty.h:4,
                    from include/linux/vt_kern.h:11,
                    from drivers/video/console/newport_con.c:18:
   include/linux/string.h:104:14: error: conflicting types for 'memset16'
    extern void *memset16(uint16_t *, uint16_t, __kernel_size_t);
                 ^~~~~~~~
   In file included from include/linux/selection.h:11:0,
                    from drivers/video/console/newport_con.c:16:
   include/linux/vt_buffer.h:34:2: note: previous implicit declaration of 'memset16' was here
     memset16(s, c, count / 2);
     ^~~~~~~~
   cc1: some warnings being treated as errors

vim +/memset16 +34 include/linux/vt_buffer.h

    28	{
    29	#ifdef VT_BUF_HAVE_RW
    30		count /= 2;
    31		while (count--)
    32			scr_writew(c, s++);
    33	#else
  > 34		memset16(s, c, count / 2);
    35	#endif
    36	}
    37	#endif
    38	
    39	#ifndef VT_BUF_HAVE_MEMCPYW
    40	static inline void scr_memcpyw(u16 *d, const u16 *s, unsigned int count)
    41	{
    42	#ifdef VT_BUF_HAVE_RW
    43		count /= 2;
    44		while (count--)
    45			scr_writew(scr_readw(s++), d++);
    46	#else
  > 47		memcpy(d, s, count);
    48	#endif
    49	}
    50	#endif
    51	
    52	#ifndef VT_BUF_HAVE_MEMMOVEW
    53	static inline void scr_memmovew(u16 *d, const u16 *s, unsigned int count)
    54	{
    55	#ifdef VT_BUF_HAVE_RW
    56		if (d < s)
    57			scr_memcpyw(d, s, count);
    58		else {
    59			count /= 2;
    60			d += count;
    61			s += count;
    62			while (count--)
    63				scr_writew(scr_readw(--s), --d);
    64		}
    65	#else
  > 66		memmove(d, s, count);
    67	#endif
    68	}
    69	#endif

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--J2SCkAp4GZ/dPZZf
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICKON11gAAy5jb25maWcAlFxLc+M4kr73r1BU72EmoqfLr1JX74YPEAiKaJEEDYCS7AvD
5VJ1O8aPWluemfr3mwmQIkAClPfSXc788Eok8gVQP//084y87Z8fb/f3d7cPDz9mf+6edi+3
+93X2bf7h93/zBIxK4WesYTrXwGc3z+9/efj4/3319nFr6env5784+XufLbavTztHmb0+enb
/Z9v0Pz++emnn3+iokz5sil4pS5//ASEn2fF7d1f90+72evuYXfXwn6eOcBmyUomOZ3dv86e
nvcA3A8AJKcZK66DACJ/C9N1dvYpxvnt9yBncXQ6C1pc/Lbdxnjz8wjPdEzFguQ6zCc0axJG
lSaaizKO+YPc3MS5vITJR6aek1LzqwhLkYl55UKUSyXK87PjmPlFHFNxWB7NuIhDtjxPqyWJ
y7AACUbYdggamWXJKEDkivFSxduv5cVpZAvLbdUovTg7O5lmh5WuKmB4VQV5kuS8XLmslqGW
vOHV2RkcpQO4pYWVvmV+nmBGxKP44lqzhsqMl2wSQWTB8iN9iOk+jgLUBkaZAuRc65ypWk72
wkotVFhbWsiCL6OdlLyJTMKoit6e/x477ZZ/EeXzlRSarxq5+BTZD0rWvC4aQTUTZaNE+EyX
edFsc9ksBJHJBKKaQJhjVREJA0odUEK5UazojGKjKl7mgq5clSQSlpsR1fBcLM+aOrKkIcw3
FS2oGyfbML7MNAwzYFA4LAtJYO8SlpPrHqDARySNKLhuUkkK1lSCl5rJHpFucA7935StdSMv
Vg5FSepTrOHGFTdrda1g9Hy09KQgDUkS2ehmfrHgISEanKqrSkitmrqSYsFUPwr2UIqSioxJ
UNqeUTJYE3ILguYFlu2O3lpEGj2zpWi4wDGx/YS0uSI4yljaLaOberOQYsXKHtfxScUdKVY1
HqyGlQknDhjk18vAA/gryuola3S+6MAhy7gBeXAB6kgoc0YAE2c0rEyuE7EcMzKSn42pirGr
MXWT/H4+pt6g9gZG/Hxy4fScsJTUuTZsOFuao1cfauK502AhhG5Ynro0I4z8FFQeVLtRGU91
89sk+/I3R+Eg3iiVyB3xIBFUr4AT1EVnsFfhyAw3UV5sT04C0je8TycnJ/7eohwOzSKscauD
RpyfwdlpVkyWLI9AzPEaQbDjI714kHf0gipYkSU7RLFtvLv/8X3Xh7lmLFd9R8f/wFmtwYbW
TIWUGQcCh3TDmovVwu2uZ5zOV4twXHGAzC98SKdqQlIGx3/b3IDTFTIBi3h62qsduAUwnahC
zqmGmMPKY8BAWmcakrqo8JT6XDCeTVrVY6LV0hEeDZxCO6UgONNGpYUE1aagpjaJcMDmrF6X
dHAGiOJJq/8nYwbsiLr87BniNCe6AKfGSrJwz0dL9wkwuQQECHCwoT0rI2tDXbTeMERum7rN
rMPgIFiQu9P8sKGmA7QGOCIvU2E6CZnACoKgptJmIJCOurw4yEoUYBd9k1PwpSQtqdeeDE7X
EdeFYUGjRbOoldt0pYoAuLN7Bfqrgpem88uLk9/nnkermDQbuircLmnOSGn0JKjqqRSlRsMf
DpiKcKB3UwkRDldvFnU4IroBXczzSMjFk5zZU6cloSvIuIKw7KY5C6dCwLkIB+jAOT0JZxfI
ioT1ONKnaKuzT/PANtmRTjy9Q9JZKCTzLDCRaDuzG0fjby6xLz8My8Dl+XpdScaKCk9TGdLm
jr0WeV1qIq8DbcOGlW1ZeKeoJCozZiq0KEbxlIxiD3F+BvZrfjERe9iQsEggaWOolIU5rrkg
iRts4rFMWNX14zg0yIFXqDtszDOHH2wOK+m1FoHG1VKjyWpytma5ujxzzl03LiTZlx8+Ptx/
+fj4/PXtYff68b/qEuNhyeB8Kfbx1ztTtPlwsPbyqtkI6RixRc3zRHNow7Z2PGVnYVzh0tSL
HlAkb997Z2hDwwazlcIxeLwEfWHlGjQHJwfh+eX5Ydpg5ZUy5oqDHf7wwdk8S2t02GWCdEm+
ZlKhQfvwIURuSK3FOCLLhNIojssPf3t6ftr9/dAWLYsXdqx5RUcE/D/VXg5QCcW3TXFVszqk
2XaNYM2FvG6IxgqI42AyUia5F9TXikF8Fs6g6sQ30WY/YP9mr29fXn+87neP/X4cQnjYXpNv
BKJ7YKlMbMIcSCvcfQRKIgrCS1ddcfItGRE+3IQeSaMzyUgChnLgBU1WpUSN8UlCdCD7MCro
pF0DtukADgJ4hQCzEJhoJTZlMoLS94+7l9eQrNBYgeYyEIabfAm0iqCJhe81gQgOjIvEr7R5
rXjiBhaG5sgNUls4jsosUB5iTPCIH/Xt6z9ne5jo7Pbp6+x1f7t/nd3e3T2/Pe3vn/4czBhd
KAE7BhbTivcwReO0fTZKJuzRYKuMpHtsuL6pElQkykCdARo2x5qoFeapaqSmktYzFRJ9ed0A
z509/AmWB2QcTP0GYDMiNgnX1qArmE+et/sYnjT4F4M0ZjkwpjGIEEmWZ45F4Cv7jzHFiMl1
BdhD2oaop4cwrZK81KtGkZQNMedDdbZulQ6jRbqUoq7CBU1oQVemCIK6poUMrQxNoUminSNU
g58vnb/R7Ll/g4WSHqGCMNv9u2Ta/t0X08z00SKbCYcLbtcqVWCnwdtTOLVJYLayLfn0Opmv
oMXaeBkZakFpIyrQbsyQwB7hwYX/FRBnekZ3CMOMKhwKWePf2TGIZmBsCNCd1VsQKDBlFQbc
Vqsc71ql/R9WzZ0wHXwURwG7JQamC1DyZmQIrcQCZal2Ci0nFG4Zn3UwP10sBWB1Xfhxfktr
Bh0FAAsFwZtmKGMsK4xHPUAXEIeYzdR87UjGHojh301ZOMWlRe0cOJancK6lK1zsOa1dKaUw
p63TphKeDPmyJHma9BQjFZdgXIwh9HpXpRPSVZmXRRLuxCEkWXOYYtvYEzVuuwlS0pAmY7JI
pORGNQ5tgMiSJHhYTDCJ+t4MfaQhwmjN2iY6XjRDT08uRsa7LX9Uu5dvzy+Pt093uxn71+4J
nBMBN0XRPYFrdetHzsChpLKwvMZ4HKuEXuxHsNYYvBPJiVcjUXkdDpZULmIMsoC4nTEMlRsJ
MYyI3DVcKw1JOMYmDQSVPOU0fjsHJj/l+cB3ujshLMIzOytbCA52+AfWV2CqkcuWeqKpGc9W
uUgO+o2ml6LfjlWmURfQx4EzBje/GdU5VsOCtaVKpoMM78AaihnF2MFMiGG5BAvI8Lfmy1rU
gVAO8gmbdttIctBasiXYnjKxiVW7UL8gfRgFqOAuPBPST68X+CBQ3RBQVHSCFZF4aNq0I9BF
m1U2sM/ezUOMblqC7zFTB1FqRsFPDxyTzwz7OB9jkuzJXlBqdU7CN19jtNJSxDUb9w4SxUNB
ZLC+SCw6QAWi0GFVTSStlCtG8TA6XlMkdQ7xNOox+gTp7uGhe7aFAyFKm/bgAgf7jOVF09qY
BIgAQltsKluybOuKPsAMMFTScSssjA0qkgM+2V6efooDYo07w3lkDA9mh/JNRyeNLJwvKILF
QDxMIWXMQffADdPVhsjEt+tY7xUNS2HvOBr/NJ2wX2YS6/bei66CQIMRJsoieVvRb+QmfOsa
A3elgelLSzgCnOp3jeHArWIO4baMQsX6H19uX3dfZ/+03vX7y/O3+web5o17RHzrZdgwGHPl
dqjPG6s6vFBE54dV5Z6Cl4MYIblW3ERRpgrqVNTtGfMqZnZ19ooBC2ChsMVi6hL50caWHb6f
FklrcSPvNmw/kBYeCj+RSLVD8nB+27LxdMiBr3QyRV7AZMHOJM0KQ9lQsujfCOSLhDgBP2Ys
iioONuoK74N8DuYyC7UMEu2tXSD10WwpuQ4/j+pQePkTli8iumqmcXBhp4CwzSJ8SMya8PK9
IvlIz6vbl/093i7O9I/vu9c+8z/ci2JMjAmZpx4E4vqyx4RPG+Qw0wih0mN9FHxJjmE0kfwI
piA0jOj4KhHKuwv2CisJV6t4sAfGHJaq6sX0HCD/gomqZvt5fmS2NfQH9pkdGTdPislFDa+3
+/5zOCnHNkfVxzZ4RSBVn5wBSyMzwHrt/POR/h29H6NscVXM1N1fOyykvzi6y4WtaJRCuDXS
lppAAID9jjk0vXIn2RWluwYTN2qRljiBiVbtuJcf7r7976HSXVxNzbQ0EsF3PsYqQ0jtF3Yt
H2Oclj/FC7bdgLViscYus23t3AAyduPbJ7NJi7fX2fN3tDGvs79VlP8yq2hBOfllxiBY+WVm
/qPp3/v9yzY22gOOkxZTyA4kRzfS5GxJ6HVXmU12r/d/Pm1uX3bQM4d8F/6h3r5/f37Zu74a
uwsd/cK5D+efzz6d+wk3HTzNMl2y/+zu3va3Xx525lnuzOTde0cF0Y0X5s3IINbsGYcXQ938
8tSvluBf9iK/UxhslTG8ynLDAdujopJX3nsHG6iJOlSnbRsVXNHLR3dAHM+ptkhQFluEORTC
q+d/715mj7dPt3/uHndP+25z+8XbqIgvIBozKTkWtBRfDB674JMrSBYg5HXYjvkxvHAE2ncd
qp5519ZVYXPKYEebKxh7w6QT9QbCzYOZrxReueHQua1DOXcDrViKg1iAceDxrw+74fMdzJnj
Uap9edHhsBBT5cE6Usm8B2kaXxljgOQTWUczsyh3+38/v/wTYtnx3lUQzTNPjSwFfBEJ5Zjo
qzzfgr4wgt2m0im84V8QDS7FgGTqq499j4YI3hW2Kuf0OtJv+4TC0yHbEh9tK81pKBo0CF6Z
y+ZHV2Ardu1LEAjOEAer6EqfV7ZATInyBAj0LoZqJBxHFioTAMjwIEUjcBoSr9uqrAYdAqVJ
MhryLi0Xr71DrSSR4Qq/UZ6KTzGXaJBYUW/DiohD6Lq0D7fccQuztEgZrwTtFiseqZbZbtea
R7l10o0ahaQifP/U8vp5h3QEN7khWa8fhsBU5SppR2tEmkZyLW6X4uuaIRotbAXncw7SHMEL
fLwE5rlU5g1CoEOLCPXasxeMDdvi2R0MqGnVkf0Fo+iHZ91HSLI5gkAuKBUWscJJEo4O/1we
DlFAtgcMrRdu6alznB0fQq23L/d3H9x2RfJJefeE1Xru/9WeWnzpkoY4jZ+zG4a9sEK70yRu
wQnXPB+p0zykT/N3KNR8rFE4OviqudcdEnkein9sL1EVnEeoISX8EYUE1Hg+VMMo18i4vQC0
j+SGKxuYB5el+MAWW1ozD15IGnaJLwDNwz59XbHBvh6k4XcZszAdM2ChvP1Cv1FhER0f9KjB
mOD88BJ8SLZWdbQ6Sx52GRu54oUqmvXZWEhsOW/yzYRl7WEZ5Ndhl4BPl7DAjh/3uEPgya90
1Xq7NHzyu/ZVdm3iLXDlRRW+xAHooXzvtrfEcQg4QjhVDhupYRYBgRKE93uI6yKf0vXtQ2FX
y4J/4SdErs6MmKM3G1GgecnkBSsDAL6A79l4BVuWpvjvTSA1jxqgTcLWoXGddk27eSFWv7Uh
Lr60SFWEebj3dCfVs3HDB7lLHGg0I7IMjdPQokkorfypdBzYOV9iHUNRHWkCni/nbijoTYkU
pExIeBeaVFcRTnZ+dh5hcUkH29fzYBMXXOCrkOPCUmVUTv2uVdEZKlKyGIvHGunRinXwTLiM
6e0f6fwyryFyjipL1AT2PW1by/toj//WJPevs7vnxy/3T7uvs/a5Zujob7U9IYEzudVGDi3b
63l/+/Lnbu/dynvtNJFLMJLmnZCqQ8+5g/DWnkYm06H6OR1Bdec7aLsc6LTt6oGJotX0qFl+
bLAMZ3REMXo05s8mWX93CzCM71zNcRmWqW+Og5DOpE/OqhTmNL1zZpin4v3FkU4B9M4O8S3B
9oha2adUk5Ben6b6oVWh1FEMhIR4kVcNT9bj7f7ur138ZBVE08x8+4Dx3XG1sPhFlb4XSvNa
hbP8EFgUBV4ChlfbYcoSv4hV0f3scaP7giNw8+j72OATe9aDxkFGABd8ehYAGm893RdELqP3
ihPouOWxAEbLab6abo9X8selmbG8MvWtCUjcAlqATfnet2xeQXq2jFuXDrWOll+G2PxMv3Ps
nJVLnU2u9bjAILU4wj+imjYRskWSqXWVafTddAAtVPo+IYhNeWS/bV1zGrLSJhedwlzVQpNJ
RO8UJjCM5MURBLX2ako8GDm/Tz72FmRqwEMF9whK4qukKcikX2khEClMAurzMz/5B5cWCn6A
sXaGMn92pSW39VpFk1PLhbjUPis6PWsvPfGs7l9un17xhgvfpeyf754fZg/Pt19nX24fbp/u
sLL/ergB87qz6Yt2UyGXAXlNmEGsAQzyogySjVfbZ1bj61xc2Wt3oTucuZRDcW7GpJyOQDkd
bBgQ0/CvnFimWIeOdtv/YjwC0kYTSbIhRY0pLBmSyqsumjHCUFlcHirrdeOz0+b2+/eH+ztT
qJj9tXv4bloOllimEUvX7hG+wwntz3+/oySSYtVVElMfuoils5bl5mhKmGsm5MTSuKSuJvlY
0Yjeblj2sHnPlewPRnVoZiUZT6sXFwB4dUgePXobaGZhuo03XMkfWLKyZic6YmusdD7sui2C
DahdUmCWOB60i82vSxPkxxTDimJiTuUyZ5Gh25CYVxG+F3x5nMAiJdkMSbDt4T0gnSwDjH7K
rXr/a/7/VfB5XMHnUQWfH1Hw0EfBnoYOu241O9pvq8Ghfnk1j6nwPKbDDoPVfH4R4aGMIixM
3SKsLI8wcAH28UMEUGS+as/feaBcnB717ZYlfM5Yr+ZHDtv8yGkbTml4oOa99g97LSO/EQbK
jqlUjDf0wweeTCJvLCH5iDzDC3+nMUwX+od1kifLUPnBfqVgikVkeGeQRH4xap2Tsvl8cnYa
/g21BOwLCwsoz2n4F5F4FXlFrEkeLj9tIz8vlpMq9OMfFf7Qlqch81xsKhL5EJQxhgv8FPRf
qFDmLVl7fXH1tnvbQRj4sX0f532e2qIburjyXz0gMdOLADFVdEytJBeDPMDQTcZ1FZ8mnI0k
1E6lITH13MBsNbvKA9RFOiYupRtuddREjRJIQ4f/syI0yURGK4l28VcolkkIzcQqWncyiKs0
rMeHHkQy8dwBEenVu0CT7CyLlrzs/vNI9dBwuxuxgAyr3E94bID6cPv6ev+tDV19baX54EET
EPAd/CAnNGRNeZmw7Zhh7kUvxvR0M6YN0ryWZL6bC79VbQHD0vRwCmpdBSYG1HlgXmANhtIz
645XIg/t4uVuAzHeLvYSH0HMICZWQujg3RnBuzGsZLAxfUmo41iXxF6jLcbAgsuAbUCOIkWV
x9SNmLDIL2wYInjFMbHCH08dkxUfPgIz1NWihY+mRAfXMiMAOqVJwNROmhHa0uskCGZYiMjv
C3aySePmBvn2kh/fuE1qDS8jLxCtMeHmEUzvc2nImielwg/eBf4QiCvUBcQPxHxsEJyCqFi5
Vhs+UMre/9voOlrENLeE0YdIoFqRb53UhLE3sxlcn3uI/BwOmrLvD+KokqrQ6xVkyS1+y3Xd
+B9FL66893X4tfMfgV8eaV95zva71/3gsyXsu1rp2G9OZKSQJIk4MRqLT2QSDs0in6UQiGS3
MhZMps2KRr771ZKRIvAxTMtP+aKRtfeIZsPx13VUgILveR0qM/e17htsQ/J/MMKQVHU9AvG1
9z1dusRw7TQwxZwvDKu3Nh2lofK60tBhFeVRWsSZesW9W5MDe1RjtOrQzfFpt/v6Ots/z77s
ZrsnvEb7im/aZwWh/0fZkzS3jSv9V1TvNFM1mfFu+ZADxUVizC0EqSUXlsZWElViyyXZb17+
/dfd4AKQ3fR8hyxCNwEQBBq9NyEYyaPrFtTKksmDstdhRoaPZ924qxBamTfPg/swsswbugVI
SyYb+6s7IauYEwq3sZ+haYGPME8Cfs9lwyvGmoRERDkfqYbYqaLqJemb5ylMr5dbgCQbfykk
Go6dDcXO1hj9AOX6/HfREP/dP+wm3nH/Xx0U06WF2j/UzZO07/Zd6oD/2jr1i22GM1csrDxQ
MKMizgLOswK2R+I5UZpYGSR0d0GYxxTfRJlbOniwqvqJulrUMBnkhIRTlzsthjWxtiedDqWe
fwAcz4y3oWOmhRXF4hlBEMZ7wumpo08E+ZIQ/GUuuDFrBMyXVXcDl2CcLvkdRWgO5lJskCmQ
nyeHmL9zA2+3DFXKT65NupSVOEXg0IQ5YirZBSylh8luAiGU55H2l2Vdn+VurIpZNQ/VDHPQ
MeuLnIwOnzfOflzwbEvK6d91lDSmHa5zZ1BEX+132h1i3cQ8X8dackGaSQkUaCYI9Q2SC/tj
JEtRgxb1Qr4GCF4+k0M9aTbvwHOHcwZyPcx1B5e66y0NMddqrj8rmgs6UmkhrAYJHpvVB2qf
4k70C0vL1kxq8c6chXdKlrFf2fRYlyXYnx64nab8BHa5wjx6l9Hy7ILvFY5vvMHwNBbqJ26U
qjLHFOS5fBpUb527Fbvo7zAdEuZj8l7D7NYNSJDq7tJd3wweK3b/254m4fPp9fj2RDlbTt+3
R7h+OwvfTyzQ8Agrsn/B/zYk3UEl9XZCGfm/7o9P/2AA3OPhn2cyBGp/tQY3fH7d/ZzEoUtH
WF8CDUy5cIsOm5ewj4etXUeLw+lVBLrb4yM3jIh/eDke4FufgOdQr9vXnRFINfnNTVX8e/9G
w/m13XVr7S4EtnUdUeC8CHSCsqG2acbdaDpThWc7XNvJX+sXBX5e792hEZaCy0FcMyL8ndDD
zIO5oRBHLCMrAD6jE4B3uxPbarmG37400OeReDbCQNa2CtrIMJp7PWlKpzz5DTbejz8mr9uX
3R8T1/sAO9mI1GzOtzJeyF3kus0izE1rqtiUkW1HOUegVV4B4+AJ91s7IGdEb4Huwl5fSsAN
TEqhBusapfM572ZOYOWioFqnOu6WrWgO7Kn3uVUWth/YHihwNUAaKaS/+WeVo4YPD1GAC4Z/
RnDybHwOwBdRPlPDwk/the2fpRspUTolPuO6m4eYtb3Z3fY8ykAtXJ6c6/0vBnFqMK8WIFiq
PEpBFzqFsIMcqWoJP6HWP5ZP2kc+9aGVtC8Ow55+z86Lliae5bxCN1j30/9cOhGIWBb3FAaC
fEN+nSyTAMIb6qQsHgyaCiFr83ItKbDgKSUk9oXhXZ3aXgKjNkOcOQIpZ1EO/2EFfJC2zBeA
n9WSlpRSubI6wmWPa0mimMkmQOJkd+0+2veNt4crev/3G5ZiUv/sXx++T5zjw/f96+7h9Q1v
3ha9+WjFAgWWnppU0zGQNxwXY+ldy0PGQYOiUxVKUnQ2T8fOFzPHlQmCrZLAVueBudsXOxtI
mac5Fx5GKwuSVC8lI2wAyVZT9zjLQQADhtmi51e878bMjVFI4RUAXnx3JiTe9hLW98qYhf/F
TpRrgDA1S8RDphfX6zULip0caKGlf4uXsaQri3FjOtVM8N5vOw3d3I6ZvVfT6fV5FbOJhIwn
Ewf2ipnPzYT5mBcsjX0WOr28szKMO+vp9PaO9yCAnZwK8V1Nd0igUDoyu/wMDWhIeOfRHL48
XFHsLHPU6uYsSDmxKu28umo9n/k42/EBBwVF7AYTE1O2BJGT82uoYmXmoI7du/O1dU8D/O78
XIqWbnopqKCC9SJFjBlr3n2TpXDOV+GXxA7i1y3V6lrKYd8iXLJFRYzO15hI0Yr51y30qTEo
ink8W2wwQVLtaEPn5e9Wl2CQTuPmDVMkC5hPgN9BGiMsZg5dnLrjMJzAUCP9OrGHk+G5gJp0
ygjF9OxyLYJhurfr9Sh8ejsGrylmH6HhZEOgwzQ5g09wgNHQT5gbz8uml9OrqTgSwW9uRXgQ
rn15nUI3i0olg5GuVuuVsxFRIuDK/OL87PzcFV42Qo26+aY14e2/qSad4kB0svAGGMdAGipi
6EQjzmCQhso1D3dzRR/qwr/vzxXJgTiKKvzzszXPhyFTAAcwdOVFX8K5U8oX4fURncMJucjx
b14FngnJnyPGGxQVAB9O+8fdpFSzVmhErN3usbYfIKSxQzmP2xd0qxvIxKvILjPVGmdWHidG
IHrLtngxLLRhiTFhhc1bFQvR09p+LDbZAhNksDQM1AURKOVBPVajD8pVaGbETEEstWQr3dJq
ut95gY5F4YC+B2KQtGS61qEA05taAJr6ChNgptAz2wsB/8vGc1pthE+WqMlqj8ak34ZZa35H
i9Vpt5u8fm+wGJK/kgyWyhOs88t4sNnD55e3V1GrQ9YrOzsGNFRBgHmhIyldoUZCgUcyD2sM
RbbO+1iQ0jRS7GBOtz4Szb087Y4/sWDBHvNAf90+mGGs9dMpJk30l5Z8aUHQPMbmfemhKaDH
flKtP2K9mnGczcfbm2l/vE/pZnw1/OV7cM7Sqb/fwDZmPXnvb6jiVrczmxYgCvczKwFiC4nu
7wXddouS+KtCSqHX4KB/A+oE+J3SoqkiXTlws76DVSbvTmpd9FCGn8pQX+BP2AGWT1TbCGIr
qzDtEGYbj+kM9Wwh/JvZhX5asNokTiYkbuqw3E1mJ17oQOSKTTUW+AF8rLrrCx4lxjx8JN+h
UAK5Gy0t3cU9W6WrQwqwBk4t9ltA5eehEw3X18myyKeuR4YHzvL67lYo7ksYSwWcqSNoufQE
mtWu8NKWzxccUIzF4rXOGoVcyQV3ZI2A76OpwBhJgwuVBedxeDXQvmmeZHt8JDtI+Fc66eti
sSpMt+yMPbGHQT/7tSN1I/zdqxtFzSDj4CHptfYctnVjreoBdJ7jIiSAxlLu47obLBop9FES
CguaO7HPWrHc79vj9gHZtM761nChheHysjTe3dXqPp0IKCJuWZmYw1KXi9WwDfC6ZsxPaBcl
wrxydyDRFBujb50HUmzU9Qs+Xlzf2MsGvHyilf+eWJm3mive/FcXB+NdNeBq0sUlOlHLX95D
09BKtDvutz85fqWe4bRXN077dB2ePxDgpB8nlpsxOdZ9lE5eCBJ5jUHFJHXV1KceiFTUT4M+
lesmgpxSY4yVWq9R6t3/qXDmOMd/gfouWs7TihocqKiKsvc6oVzOpRD4APtJlzzhSVYWh3XJ
Ld7GAJt7pJpFfnnHVlym/GlklTRF4bVu95fK3tyFC38yhnu9cLldgs3samS8eKjgHfl3sz0Y
dZpQ4AmYMTObVWhRv1HdutcDlQBrntLQIps8/Dw8/GC7K7Lq/Ho61cWXBj3XEoRWP1HRrkTK
KWWIEtvHR8qJDQeMBj79aQ45z8JU8i1bnbPNOsmoI8TYaygwMcKdqeFYbTDiGb/FKmYzoaIB
IraZirqJEvlS7UBMoMExWA1ik0FvnqJF189AOleWJYBDDJww165E/FFiHiE/Lap19a8fqVcV
a+SIlr3mOXlWDOLoeyIC6hzpr3fH/Jev9f99HR/YgkH+W+0V4sLhBSp1eXW2xs18fLJumVYm
Rtfl1NKeN20DzmqIkYAUspGyM7VYAzswTXCF2VkeD9+GwlhHZ9KgaLsZU2eN4tRWq3EkbzUO
B1qLdxmL1DKrupy5KTrH88xzq5U3ZLDa18+OO6wkeACxdH6AFXg+9NUW9TKCeFMnw8Jtwl3l
amamUNbsxeF5/3CaqP3P/cPheTLbPvx4+bl9trIQK8WZ8OD2dgbdzY6H7ePD4Wlyetk9YIzO
xIlnjuUD2Cvxq/Xxbz9f91/fnql++Zi2P/DkXbco0NNPhe4l/4Xg2Xs/ziKhQAWA4+Lm8u5W
BKv4+oyn285sfX12Jk+Nnt4oV6o6AOAirJz48vJ6XRUKdqQgRCJiLPDquhiQRBFIocfVw9Vu
v8fty3fcCMzV6eVDRgGox+Q35+1xf5i4h6xxyfp9EAptdoJSD8PaEFZw3D7tJn+/ff0KEoU3
9OcTXBjQSTci0SxyPe7lOr333KEEIkNB5vB8OvwkvznY+L/qXcetA3TRiB3c4Zqjn9UKJzCU
WbSj4Xgz/BuVMUhE0zMenqcrZONa8SWdW7ZA/A1LnJRrENQTfosYOPA257wV10Byo7K4YMtJ
ExK+c41iWSVBmhqmwl+E3lAhuggtbdkCK707BTDyG4rfwLRAzOCAhrKymU0ce2cRG6/mluAh
YYKrDh9gKAw+4VyJyh4Cu3nJCy0EzaTYAIKWqB4XwTM/ug+FWBsAu3Cr5wJrR+AQfo3AiQbI
4I1cMQfhsObzNMlDwTcSUfxYVQEfakHgyHcFuYbAX6TAMv0d41koSOEED3K5a+hY1o0RwkZ+
qxWIloKzNg28yeWCgoiA9li592IVJgvB9KCnniiQOyTNMKJEbiZGchLcT9IlTxEInM7D0R0f
O/PQJe3fCMomiKRaY4RA9lNg2GSMFE1cIzuAwsXHPyNQX5+XuxGaOQkyxlE6so0yv3CiTSIf
8AwOWSR4IBIclcV5mvT00TZO3o97ssDKCcdeo/ZokeGZ73uiwy9hFL4foS5DKj0ZknEAzfci
PJdkfDwSqLEFVkwmNhhNX3xKN6NDFOHIroUjqXyhGhbBF3mpCh1XKSKVeJFUmeJZRn34x0jW
OkxieYpf/DwdfUG0YsKxkE+2jmOoFkJ1VLpSeKNKCcx+unBDuMmLArgHPwHab7gCIrxmmOzG
tlTdwrXu5p62X1sMoY3zgcT27Puv0/4Bbtpo+wvVxMO7FkcTnSnSjOBr1w95Kx5C5443F5Qh
CC6jLBT1dOWKX9M4FnhvuNxEewZwfkBlhVQouphpOANZtOA8Q3IQXHRZOKOBEvTaTQu3SNWG
b6wDtj7+5/j6cPYfEwHr38JGsJ+qG3tPdaJE4QqRoABhzcP4RJgUgRbm7cGo3Y6NbZt1pBXT
WpWhT+oLcw/SvPIlBb6xykucXm8vopJSaEY9n/BU9nP7isWaerDBTOBa5E5fA/bU+cX0hnsF
gFyf89KkiXLNUyYD5WZ6XQVOHAo6PwPz9oq3/3QoF1dnvHGwQVHF/flt4UxHkeKraTHlZQsT
5ZJPgmOiXN+No6j45uKdl5p9vpqejaPk2bUrCPYNyvLy7GJoZTk8f8A8tcz2QelC7Z4xTEnY
QF7sMDGW2oM8dmZlYJRc6iQrDPXE0qE8nSnXXqiA/+B3QinoDaiyb10xbTCX5f4Is+BeAB8L
UyCXdrd1WN7D8XA6fH2dLH697I4flpNvb7vTK2uBKhwhhobqaMHbFEGax1UXKtE+Ok8jLwht
ntO27qqX/TNZBHqfx6VGdXg7PjAO+W50r3K3rfHWtfrLgmmdRd6wHhx5hwGvKJiRdALRHMjH
OwhxUQqG3wajiPmKIn5cIyihJlLshNEsZV110jguDe7Aigwn4CTbftvpunbKtsLku6fD6w6j
9Fiy6cdpgWGOw1DO/OXp9G1ApQHxN/Xr9Lp7mqTPE/f7/uX3TrfYi/RrlY/qwB454GjXoRyv
CWNVwlIh6ItQmIoKxy2D3BeiSNcY5iJxFKkgzofCWc1WXIiAA+cDJDQy+CX5x/P2O8KuvDPi
sfLP+lAB0bKc0LBym8gnkb1JiLTp9HPx8IMia6fe/j7R17MMY3WcucT7ocktWzvVxTSJ0WQo
pGEwsYDb448Juobfp4lDGPKIKD67gt9c7A4Z3wwYICzl+Az04+nwvH89sCrD3BlSVOf58XjY
P1rO5omXp6Ec+SwlOOHbtV91MSSLFAFsaWi58peENXi0C/e0cBl7btCEGDMGmzZLA7wT54FY
7L4dt0aQshUFHGABTb2bDGIdKCRXjhG6AyfuAkNVn6xDiE3VGiMYmQME8MvKZFvrBrRvhGtg
4KMhSPluiQWbLchVv5cruZerXi/mbK8w+hwztUh6JcKR3JQ/zTyrThP+FpFhEvGsST5inPpQ
+TnAhOLunwagGrAmQOeEgL91xnGr4KKxKGz/iCGo8hEEm4hfFwTKIaDzAF3r+DeaFSOvm4TR
yKPBhbQa0sfHizVQ9kfXbbrwuBBaTlXjEW65PFERoQKukj7cOKfCfmrhSVpgNZjONNFvCHWD
rrppdu1oANNr89nNn22OLfJnDxw7WpD8ZmpE/MShoOXSGNKO1lCshGbSgM9Yx3bJpVnSkItu
z1IHbmF8Macs0kBdWTs7QG9Im864kooUU2IAX14xdm532y9CEqhBdg0Npqj6v7ylR7RwQApD
ld7d3JxZk/yURqEZWvoFkEwSVXqBhY+/k66Gr5eqvwKn+Csp+CEBZj2u66ObLcs+Cv5uy2Gn
np85c//j1eUtBw9Td4E+7cXH/+xPh+n0+u7DuZm9x0Ati4CXSpNicDj1FX7avT0eqCzz4LW6
bAdmw70djE1taNU1Nwo14iuhOjvEPDbW9gaguwgjL/e5Y4iJi8xRe7oUSqHU+8mRFw2gu84y
rpVzOHszmh27UvofiZShly0RGNQd+bFFvFKqHSKTT8cbgQUyzNfZygToQn4QQBR7JtH6kbnO
pAXwm5utWzAQJYRe1OfSUQsBuFzLi4xlka0TVbdQeNlyqMdN48G0Fpn8dp+T9dUo9EaG5vVY
PAutCsn7ATbMkn/dcjB33aLrx/NaDO6Cb4567bNn79IG2GNM8LdJ9On3Zf93fbI6aoKtUmEB
YOdWDl82T3lWzx4MbR9a3Xg5aGAm4FVsjYE5ORxn6MttDIbcQP8nPG+vC4zRivvWAuhEVgZF
KpM8M3Lp6t/V3KyWAg3A1WJbdZ/Pri3XYI0uM2iUkI/dKm7YO3shLnfhCKk8CbzynXsQmSn9
oNBlVWauY8fpU7MkKRCQ5j94hFp5KVTD29FkHBULcmziZsK6pJ7TO0OORF3wYn8yfjSXp3W7
GuDmeq7gerYfbCG3MuT2WoBMr89EyIUIkXuTZjC9Ece5ORch4gxuLkXIlQgRZ31zI0LuBMjd
pfTMnbiid5fS+9xdSeNMb3vvAzwj7o5qKjxwfiGOD6DeUjvKtZLcGP2f880XfPMl3yzM/Zpv
vuGbb/nmO2HewlTOhbmc9yZzn4bTKmfaSjsZDebjdvEaltJF1xiuHxWC1qxDAfmrzIX88w1S
ngLT8d5gmzyMpKi3BmnuiIFxLQrIa4JxtcYIXQzEE9RkDU5SCjp3a/nee6mizO9D9tJADJQ1
mlQS97vj8+7n5Pv24YdVO0GH/4T55yBy5qqvTH857p9ff5AB8vFpd/rGGXt0EAkp8Vm6r70C
o3ROabdaWt4KUrGvFB7BAcaVwexiHq56IM/vWY5q/8inFxCRPqAP8gQk1YcfJ5r2g24/cjPX
SUyx2D3HRicUT4DiPSBmue86hW+EfdbwuFR1UdsOFAC/rZ/UUcOGKjQPM6AsMfCasaTGdjzq
2BHitcoEo46xg1kqZPkmikZ1+liwfm325tX1aFT7Qr1ngF9CzQzKWFI+/T6KXsA0iTbD7oI0
R3924n7QyJTxFiJy60LuPOdqcOiu2ly62q63ezocf0283d9v3771coXT4vjrAt3VBKWl7hIR
KXpBXuMsBVIpan90N+kM6+aMZdFVkcM5rlMUZ/12FHbvMF+kgYx1X6DZpFSSOK2xlpzBRoO0
/YdSzhkhj93saADUHFGBh+GmMcFj81z0MpxqzQ5+w0l0ePjx9qJP9GL7/M06xigrlBn0UlBG
XmEIBFaLMsF0d4pfr9Xn8eCJDAiyC3u5Snm1pwWvlk5UYhJxC1hHPnTNVOVmyKnr5j5pssGy
VKGf1h8eBHF9nEeWHmd17/tZbyfTIuPSdydp8tuptlWf/pg8vb3u/reD/+xeH/7888/fh7Q1
L4BAFv56NIu0gnH70W49lPc7Wa00EpwmrDlU8L6XGpc01yNHO4fd2qinWQzqAJd/ZBCnSGMk
WxGs6ztzgWEqJwuBdkYBugzx70mDwv4uMNVv37Oo28PtOtSdCTY52Bp09Y9M7V6TrrHJh0L/
NQUN38NQY5STFPahL2QE1Thu7ns+JrmKhprT3C2FK4A+MILZtaH0JAiuKNeCcIu++yWoA6B6
4xj/qhv5SyHU/zxmS6qPx+f6ts3le1ZjarsOVoDAbPg891l/mMrPc0r580lf+rzRSWvIR3Ei
YK0Sd9PzXjdvmqBMNF9BS5H37qEWOs+dbMHjeJvEwQMZ6KruvQ40GxxTgD1WBE7NtCmEghp0
oBm6c9oYqofh1g/qXgw9NzyBR3zgxtpOpVss+zXZxYJbUqVBMIai6f8IwmIFSz6GUHO3jdVC
YwpWxTqDgF4fIdicnq9U4mRqkbIJk3MnoRJsKRkHE11owTyy1O4ksPmQEa8fEO6EFh0T4Y8h
6jtyZCGalM1hOnIKqZxBRcUgRt6fNk01g52+6BdB0vTq7Zmkl2JY4IYqKCAtrZQUOUYoInTW
0Hu6F0aozQztkf/X2LEtJ67DfqWfUGDp6T46jiFZEpLmspS+ZFiW2fLQsgN09vTvj2TnYkcy
e2Y6w1RSfJVly9bFj9fyEE42zW0ykHuYncGLN5vjw5fbu5TuUqSeMX3FjT7rRNltTgzP8CPd
CgirjPdm0ARav+S9gjQ+iCtfzCqNr2uPbYzGFni7q33Ub/TV55mCqSzwhOAX84ZDVp4YH7p5
6Lots5w3LTI99OTv0kguXNuoBqKaDzqcSm9Ps06KLtEByvPchaoUaOKYuAGEbFH7bU5M3htv
yHvtOLBahoET/wr+5zm10DosLOymDkqxBsmk82vwujlS8LfmKXq6KLzISMjCLw/7j/Px+mnd
UXTNUlvnARM5HKQAJp0BFPK950HSWFGo0D+ggGhCzFyrjFuYRz62dj/AgarURnaw2jxnwo72
JpK/dsB5iUQBRzloMjIq8ukQO2C00bauHyNy5w15jPQJf+Q5pEmzUBkJwqrBZhccBkNYPgJj
LCbu6WYdJyHrbiXk+fP39XS3P50Pd6fzkMvcIYZOL2GlW5a7NnhK4UrY6VEGICWFrUzGeWSH
Xhlj6EcoklggJS3siO8DjCXsL/lI070tWeU5032ZpbljRNbV4Ums26I98fVbrJIh+xBnsKlY
i6V9vnThXGtqPreb+2ETxqWJYYI6ICl+uZhMH9HRZDxkKI5YIB0ufHZ+qlWtCEb/OJkqu8YZ
jL/1oq4ikDfMp6z7i/i4vh7goLPfYeR59b7HVYE2nn+O19c7cbmc9keNCnfXHVkdUqakq0uZ
MpXLSMDf9D7Pku1kdj/3d6BUT/F3UqqCr+O1RhirbW2L/3b6absTdXUFknwvK7rOpJ0lvK8n
ILCk2BBYzlXyXJVM10G0bwrGbDXaXV77HpDx4sNSdys+tUVeV7tp0rik76OSzD3e8Rcca+nI
FXI2lcyK0Qh/ewBdTe7DeEG5QUss2qq/80EafiGlpeGcrvMYWEMl+EvlXRrCKmXB9ivvAJ7O
HzjwbEqpy0hMOCBXBIDnkykzDICY+YegWhaTr1NS2iY3hRm2Of5+df1Quk2nZOYRoCNvhRF+
XQcxXRWwxdPJCJJsg440XkRnB0LWnUhVksSCQeDrje+jspqzUDrcoaJdWOhfAl5F4oXZskuR
lEJPuk+Q3RJgiilQFTmcEwm8UnQYqk3GjmsLH0aof2o7Hy4XJ6t1PxALvMyhEu0lY7r26HGK
6z/iLZgGdMT45+zef57e7tYfbz8OZ+MNRKK89LyHaZPygnXr6jpUBKi9rGs654hp5SI5Xmic
T5uziSRvvjNQkHq/xRh4RKGfS75lBlXreags/q3+nrBsz1z/i7jw3ImP6fAMeosw4t+CRLlN
U4VKhtZQqm3OGBgfzleTWP1w0WHZL8df7zudtUa//I4uT4J4LYoto96b943jj/Pu/Hl3Pn1c
j+/25g76Pib4LNy4aYMGMuCZGeychzDRRF3FTr73bHAtknETZzoYj+Mb4uJZVJy5fCfhbASc
wTKTnDzYu5hs6N4JBVZ144gL2IBHVcym7IWNS4Ap04PtI/OpwfjWtCYRxUZ4LCoNReAxmwDs
P0ybkjhojxjOQpG8Dbaow7gyk4t6hai60ebvynSMqNtj8oLBpOL1SChqKBGVICN1tTr8swMN
lQXv639+QQTbNINqAvmNaVOl4NiosJfWHXUPa1Z2PmYLHqQseFFacFGWmYyNBbAoCmE5ZmCo
BmBllY5BlPsRPsoPiBdg6yzLxw4nDoH2EOafZsMn24Y1aW3OR0uqu5V0WDcrQs/8h6H3gr4Z
5wRrURkGJFHLuKwKK7/GIltXzOsAQh//tZeuBqGPR4khipwo4CU+XCVstO4SHQczx3a0D54B
OK3ncJ+Z+077MxxgnbmNBBL6D85mpx/p1QAA

--J2SCkAp4GZ/dPZZf--
