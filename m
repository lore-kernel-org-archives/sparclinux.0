From: Josip Rodin <joy@entuzijast.net>
Date: Mon, 23 May 2011 23:05:14 +0000
Subject: Re: Sun4d boot crash in sun4d_init_timers
Message-Id: <20110523230514.GA20476@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1105231908050.7984@oizys.tordivel.org>
In-Reply-To: <Pine.LNX.4.64.1105231908050.7984@oizys.tordivel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Mon, May 23, 2011 at 02:59:49PM -0400, daniel@gaisler.com wrote:
> First of all you're right calling will NULL just can't be good. The
> LEON genirq build_device_irq has been split into two separate parts,
> one that takes a platofrm device and one that works with "real_irq"
> just because of this reason. Even though the OpenBoot PROM shuold
> deliver all information, I think we should be able to bypass it when
> needed, like in this case.
>=20
> Secondly, the return value from sun4d_build_device_irq() is a
> real_irq, and that is what causes the problem I guess. Try make it
> return the virtual IRQ instead, and give that VIRQ to request_irq
> instead.

Yeah, something like this (completely untested):

diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index a9ea60e..c18c5f2 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -305,7 +305,6 @@ unsigned int sun4d_build_device_irq(struct platform_dev=
ice *op,
 	struct device_node *dp =3D op->dev.of_node;
 	struct device_node *io_unit, *sbi =3D dp->parent;
 	const struct linux_prom_registers *regs;
-	struct sun4d_handler_data *handler_data;
 	unsigned int pil;
 	unsigned int irq;
 	int board, slot;
@@ -348,6 +347,19 @@ unsigned int sun4d_build_device_irq(struct platform_de=
vice *op,
 	else
 		pil =3D real_irq;
=20
+	return _sun4d_build_device_irq(real_irq, pil, board);
+
+err_out:
+	return irq;
+}
+
+unsigned int _sun4d_build_device_irq(unsigned int real_irq,
+                                     unsigned int pil,
+                                     unsigned int board)
+{
+	struct sun4d_handler_data *handler_data;
+	unsigned int irq;
+
 	irq =3D irq_alloc(real_irq, pil);
 	if (irq =3D 0)
 		goto err_out;
@@ -368,7 +380,12 @@ unsigned int sun4d_build_device_irq(struct platform_de=
vice *op,
 	irq_set_handler_data(irq, handler_data);
=20
 err_out:
-	return real_irq;
+	return irq;
+}
+
+unsigned int sun4d_build_timer_irq(unsigned int board, unsigned int real_i=
rq)
+{
+        return _sun4d_build_device_irq(real_irq, real_irq, board);
 }
=20
 static void __init sun4d_fixup_trap_table(void)
@@ -402,6 +419,7 @@ static void __init sun4d_init_timers(irq_handler_t coun=
ter_fn)
 	unsigned int irq;
 	const u32 *reg;
 	int err;
+	int board;
=20
 	dp =3D of_find_node_by_name(NULL, "cpu-unit");
 	if (!dp) {
@@ -414,12 +432,19 @@ static void __init sun4d_init_timers(irq_handler_t co=
unter_fn)
 	 * bootbus.
 	 */
 	reg =3D of_get_property(dp, "reg", NULL);
-	of_node_put(dp);
 	if (!reg) {
 		prom_printf("sun4d_init_timers: No reg property\n");
 		prom_halt();
 	}
=20
+	board =3D of_getintprop_default(dp, "board#", 0);
+	if (!board) {
+		prom_printf("sun4d_init_timers: No board# property on cpu-unit\n");
+		prom_halt();
+	}
+
+	of_node_put(dp);
+
 	res.start =3D reg[1];
 	res.end =3D reg[2] - 1;
 	res.flags =3D reg[0] & 0xff;
@@ -434,7 +459,7 @@ static void __init sun4d_init_timers(irq_handler_t coun=
ter_fn)
=20
 	master_l10_counter =3D &sun4d_timers->l10_cur_count;
=20
-	irq =3D sun4d_build_device_irq(NULL, SUN4D_TIMER_IRQ);
+	irq =3D sun4d_build_timer_irq(board, SUN4D_TIMER_IRQ);
 	err =3D request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
 	if (err) {
 		prom_printf("sun4d_init_timers: request_irq() failed with %d\n",


Passing around the 'board' property of 'cpu-unit' looks like it should be d=
one
because the same thing is used to seed board_to_cpu[].

http://git.kernel.org/?p=3Dlinux/kernel/git/davem/prtconfs.git;a=3Dblob;f=
=3Dss1000;h=F420dc005d6939b837134d146741316c024d5932;hb=3DHEAD
says both cpu-units have the same, zeroth board, but it might not hurt
to check just in case some other machine happens to use a different index.

--=20
     2. That which causes joy or happiness.
