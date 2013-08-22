From: David Miller <davem@davemloft.net>
Date: Thu, 22 Aug 2013 23:40:08 +0000
Subject: Re: [sparc64] Question about loop interations in trampoline_64.S
Message-Id: <20130822.164008.603624306883653128.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1211376700742@web12h.yandex.ru>
In-Reply-To: <1211376700742@web12h.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Thu, 22 Aug 2013 15:49:13 +0400

> 21.08.2013, 23:30, "David Miller" <davem@davemloft.net>:
>> From: Kirill Tkhai <tkhai@yandex.ru>
>> Date: Sat, 17 Aug 2013 04:52:22 +0400
>>
>>> =A0%l5 iterates from 0 to %l6, where %l6 is (num_kernel_image_mappings =
+ 1).
>>>
>>> =A0The loop is equal to:
>>>
>>> =A0for (l5 =3D 0; l5 < num_kernel_image_mappings + 1; l5++).
>>>
>>> =A0Is there no error? Looks like we don't have to lock 4MB page, which =
=A0number
>>> =A0is num_kernel_image_mappings. Or prom call has any side effect?
>>
>> That definitely looks like an off-by-one error, could you test the
>> following obvious fix?
>=20
> This had worked for me, but I doubted about all of TLB types...
>=20
> So, now I confirm the patch.

Thanks for testing, I gave it a quick test too, commited as follows
and queued up for -stable.

--------------------
[PATCH] sparc64: Fix off by one in trampoline TLB mapping installation loop.

Reported-by: Kirill Tkhai <tkhai@yandex.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/trampoline_64.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sparc/kernel/trampoline_64.S b/arch/sparc/kernel/trampoli=
ne_64.S
index e0b1e13..ad4bde3 100644
--- a/arch/sparc/kernel/trampoline_64.S
+++ b/arch/sparc/kernel/trampoline_64.S
@@ -129,7 +129,6 @@ startup_continue:
 	clr		%l5
 	sethi		%hi(num_kernel_image_mappings), %l6
 	lduw		[%l6 + %lo(num_kernel_image_mappings)], %l6
-	add		%l6, 1, %l6
=20
 	mov		15, %l7
 	BRANCH_IF_ANY_CHEETAH(g1,g5,2f)
@@ -222,7 +221,6 @@ niagara_lock_tlb:
 	clr		%l5
 	sethi		%hi(num_kernel_image_mappings), %l6
 	lduw		[%l6 + %lo(num_kernel_image_mappings)], %l6
-	add		%l6, 1, %l6
=20
 1:
 	mov		HV_FAST_MMU_MAP_PERM_ADDR, %o5
--=20
1.7.11.7

