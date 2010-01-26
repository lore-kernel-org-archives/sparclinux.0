From: David Miller <davem@davemloft.net>
Date: Tue, 26 Jan 2010 12:12:53 +0000
Subject: Re: [GIT]: Sparc
Message-Id: <20100126.041253.189819572.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100125.165644.197238824.davem@davemloft.net>
	<a4423d671001260123r7013a92fqb007e4f255e8b3ba@mail.gmail.com>
In-Reply-To: <a4423d671001260123r7013a92fqb007e4f255e8b3ba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: a.beregalov@gmail.com
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Tue, 26 Jan 2010 12:23:06 +0300

> Hi David
>=20
>> 7) IRQ ->set_affinity() using wrong cpu mask, thanks to Ben H. for
>> =A0 noticing.
>> =A0 =A0 =A0sparc64: Fix IRQ ->set_affinity() methods.
>=20
> This commit breaks UP build

Sorry, I'll fix this, thanks for the report.

sparc64: Fix UP build.

Can't reference irq_desc[].affinity when !SMP.

Reported-by: Alexander Beregalov <a.beregalov@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index f2179cc..e1cbdb9 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -268,10 +268,8 @@ static int irq_choose_cpu(unsigned int virt_irq, const=
 struct cpumask *affinity)
 	return cpuid;
 }
 #else
-static int irq_choose_cpu(unsigned int virt_irq, const struct cpumask *aff=
inity)
-{
-	return real_hard_smp_processor_id();
-}
+#define irq_choose_cpu(virt_irq, affinity)	\
+	real_hard_smp_processor_id()
 #endif
=20
 static void sun4u_irq_enable(unsigned int virt_irq)
