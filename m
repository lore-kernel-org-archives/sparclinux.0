From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Mon, 07 Sep 2009 14:19:22 +0000
Subject: Re: SunFire V240 hangs
Message-Id: <20090907141922.GC12766@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20090408200711.GA1142@frankengul.org>
In-Reply-To: <20090408200711.GA1142@frankengul.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Sun, Sep 06, 2009 at 11:48:05PM +0200, Sbastien Bernard wrote:
> David Miller a =E9crit :
> >From: S=E9bastien Bernard <seb@sfrdev.fr>
> >Date: Tue, 28 Apr 2009 14:52:54 +0200
> >
> > =20
> >>Unfortunately, this kernel hangs in the same way as the others.
> >>Same place, same symptom.
...
> Hi, the problem is still present in the 2.6.30 kernel and, since=20
> distributions are
> pushing new kernels, I'm now unable to boot any kernel released either=20
> by debian or Ubuntu.

tried 2.6.30.5 on my Sun Fire 880 (uses qla2xxx) with the nmi patches=20
(see below), but the kernel still hangs after the famous=20
"NET: Registered protocol family 16" line.

Any other patches I can try (or what else) ?

Thanks,
 greetings
  Hermann

diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
index 1ae8cdd..62b2b9c 100644
--- a/arch/sparc/kernel/pcr.c
+++ b/arch/sparc/kernel/pcr.c
@@ -123,6 +123,9 @@ int __init pcr_arch_init(void)
=20
 	if (err)
 		return err;
+#if 1
+	return -ENODEV;
+#endif
=20
 	switch (tlb_type) {
 	case hypervisor:

diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 2c0cc72..b75bf50 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -103,7 +103,7 @@ notrace __kprobes void perfctr_irq(int irq, struct pt_r=
egs *regs)
 	}
 	if (!touched && __get_cpu_var(last_irq_sum) =3D sum) {
 		local_inc(&__get_cpu_var(alert_counter));
-		if (local_read(&__get_cpu_var(alert_counter)) =3D 5 * nmi_hz)
+		if (local_read(&__get_cpu_var(alert_counter)) =3D 30 * nmi_hz)
 			die_nmi("BUG: NMI Watchdog detected LOCKUP",
 				regs, panic_on_timeout);
 	} else {


--=20
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres=20
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
