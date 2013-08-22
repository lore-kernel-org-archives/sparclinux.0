From: Kirill Tkhai <tkhai@yandex.ru>
Date: Thu, 22 Aug 2013 11:49:13 +0000
Subject: Re: [sparc64] Question about loop interations in trampoline_64.S
Message-Id: <42401377172153@web13h.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <1211376700742@web12h.yandex.ru>
In-Reply-To: <1211376700742@web12h.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

21.08.2013, 23:30, "David Miller" <davem@davemloft.net>:
> From: Kirill Tkhai <tkhai@yandex.ru>
> Date: Sat, 17 Aug 2013 04:52:22 +0400
>
>> =9A%l5 iterates from 0 to %l6, where %l6 is (num_kernel_image_mappings +=
 1).
>>
>> =9AThe loop is equal to:
>>
>> =9Afor (l5 =3D 0; l5 < num_kernel_image_mappings + 1; l5++).
>>
>> =9AIs there no error? Looks like we don't have to lock 4MB page, which =
=9Anumber
>> =9Ais num_kernel_image_mappings. Or prom call has any side effect?
>
> That definitely looks like an off-by-one error, could you test the
> following obvious fix?

This had worked for me, but I doubted about all of TLB types...

So, now I confirm the patch.

> diff --git a/arch/sparc/kernel/trampoline_64.S b/arch/sparc/kernel/trampo=
line_64.S
> index e0b1e13..ad4bde3 100644
> --- a/arch/sparc/kernel/trampoline_64.S
> +++ b/arch/sparc/kernel/trampoline_64.S
> @@ -129,7 +129,6 @@ startup_continue:
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aclr %l5
> =9A=9A=9A=9A=9A=9A=9A=9A=9Asethi %hi(num_kernel_image_mappings), %l6
> =9A=9A=9A=9A=9A=9A=9A=9A=9Alduw [%l6 + %lo(num_kernel_image_mappings)], %=
l6
> - add %l6, 1, %l6
>
> =9A=9A=9A=9A=9A=9A=9A=9A=9Amov 15, %l7
> =9A=9A=9A=9A=9A=9A=9A=9A=9ABRANCH_IF_ANY_CHEETAH(g1,g5,2f)
> @@ -222,7 +221,6 @@ niagara_lock_tlb:
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aclr %l5
> =9A=9A=9A=9A=9A=9A=9A=9A=9Asethi %hi(num_kernel_image_mappings), %l6
> =9A=9A=9A=9A=9A=9A=9A=9A=9Alduw [%l6 + %lo(num_kernel_image_mappings)], %=
l6
> - add %l6, 1, %l6
>
> =9A1:
> =9A=9A=9A=9A=9A=9A=9A=9A=9Amov HV_FAST_MMU_MAP_PERM_ADDR, %o5
