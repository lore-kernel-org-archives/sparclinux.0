From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
Date: Sun, 27 Jul 2014 13:04:04 +0000
Subject: [PATCH] Fix BBC I2C envctrl on SunBlade 2000
Message-Id: <201407271504.05258.cat.schulze@alice-dsl.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Boot bus I2C based temperature and fan control does not currently work=20
on (at least) SunBlade 2000 systems. This is caused by the resource bbc_i2c=
_bussel
missing on the second BBC I2C bus the temp and fan sensors are attached to,=
 only
bbc_i2c_regs is present. While older drivers (2.6.24 era) could cope well w=
ith that
situation, the present drivers refuse to attach. This seems to be a regress=
ion
caused by the conversion to pure OF drivers on 2008-08-30:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/driv=
ers/sbus/char/bbc_i2c.c?id=E21e245bcd9d5244735799387d14421789b20557

(look for the check "if (edev->num_addrs =3D 2)")

This patch restores the old behavior by checking num_resources before tryin=
g to
remap the bbc_i2c_bussel resource. If num_resources !=3D 2, only the bbc_i2=
c_regs=20
resource will be mapped. (The env & temp driver in bbc_envctrl still works =
well
with i2c_bussel_reg set to NULL as it did before in older kernels.)

In addition, INIT_LIST_HEAD invocations are needed to set up bbc_cpu_temper=
ature and
bbc_fan_control. The fact that these were missing was hidden by the fact th=
at the
bbc_envctrl driver obviously did not load at all anymore on the systems whe=
re this
hardware exists due to the bbc_i2c_bussel problem as discussed above.

With these patches, the SunBlade 2000 seems to work fine.

The patch was originally developed against a 3.13 backport kernel from Debi=
an.
Both the patch against 3.13 and a recent 3.16-rc6 are included below. Pleas=
e note
that I could only test the 3.13 version as I do not have access to the affe=
cted
machine anymore.

PATCH 1 - KERNEL VERSION 3.13 #############################################=
########

diff -Naupr linux-source-3.13-orig/drivers/sbus/char/bbc_envctrl.c linux-so=
urce-3.13-patched/drivers/sbus/char/bbc_envctrl.c
--- linux-source-3.13-orig/drivers/sbus/char/bbc_envctrl.c      2014-04-14 =
15:48:24.000000000 +0200
+++ linux-source-3.13-patched/drivers/sbus/char/bbc_envctrl.c   2014-07-27 =
14:29:58.000000000 +0200
@@ -452,6 +452,10 @@ static void attach_one_temp(struct bbc_i
        if (!tp)
                return;
=20
+       /* Need to initialize some fields of bbc_cpu_temperature */
+       INIT_LIST_HEAD(&(tp->bp_list));
+       INIT_LIST_HEAD(&(tp->glob_list));
+
        tp->client =3D bbc_i2c_attach(bp, op);
        if (!tp->client) {
                kfree(tp);
@@ -497,6 +501,10 @@ static void attach_one_fan(struct bbc_i2
        if (!fp)
                return;
=20
+       /* Need to initialize some fields of bbc_fan_control */
+       INIT_LIST_HEAD(&(fp->bp_list));
+       INIT_LIST_HEAD(&(fp->glob_list));
+
        fp->client =3D bbc_i2c_attach(bp, op);
        if (!fp->client) {
                kfree(fp);
diff -Naupr linux-source-3.13-orig/drivers/sbus/char/bbc_i2c.c linux-source=
-3.13-patched/drivers/sbus/char/bbc_i2c.c
--- linux-source-3.13-orig/drivers/sbus/char/bbc_i2c.c  2014-04-14 15:48:24=
.000000000 +0200
+++ linux-source-3.13-patched/drivers/sbus/char/bbc_i2c.c       2014-07-27 =
14:29:58.000000000 +0200
@@ -301,13 +301,20 @@ static struct bbc_i2c_bus * attach_one_i
        if (!bp)
                return NULL;
=20
+       /* Need to initialize some fields of bbc_i2c_bus */
+       INIT_LIST_HEAD(&(bp->temps));
+       INIT_LIST_HEAD(&(bp->fans));
+
        bp->i2c_control_regs =3D of_ioremap(&op->resource[0], 0, 0x2, "bbc_=
i2c_regs");
        if (!bp->i2c_control_regs)
                goto fail;
=20
-       bp->i2c_bussel_reg =3D of_ioremap(&op->resource[1], 0, 0x1, "bbc_i2=
c_bussel");
-       if (!bp->i2c_bussel_reg)
-               goto fail;
+       if(op->num_resources =3D 2) {
+               bp->i2c_bussel_reg =3D of_ioremap(&op->resource[1], 0, 0x1,=
 "bbc_i2c_bussel");
+               if (!bp->i2c_bussel_reg) {
+                       goto fail;
+               }
+       }
=20
        bp->waiting =3D 0;
        init_waitqueue_head(&bp->wq);

PATCH 2 - KERNEL VERSION 3.16 #############################################=
########

diff -Naupr linux-3.16-rc6-orig/drivers/sbus/char/bbc_envctrl.c linux-3.16-=
rc6-patched/drivers/sbus/char/bbc_envctrl.c
--- linux-3.16-rc6-orig/drivers/sbus/char/bbc_envctrl.c 2014-07-27 11:49:21=
.000000000 +0200
+++ linux-3.16-rc6-patched/drivers/sbus/char/bbc_envctrl.c      2014-07-27 =
14:28:12.000000000 +0200
@@ -452,6 +452,10 @@ static void attach_one_temp(struct bbc_i
        if (!tp)
                return;
=20
+       /* Need to initialize some fields of bbc_cpu_temperature */
+       INIT_LIST_HEAD(&(tp->bp_list));
+       INIT_LIST_HEAD(&(tp->glob_list));
+
        tp->client =3D bbc_i2c_attach(bp, op);
        if (!tp->client) {
                kfree(tp);
@@ -497,6 +501,10 @@ static void attach_one_fan(struct bbc_i2
        if (!fp)
                return;
=20
+       /* Need to initialize some fields of bbc_fan_control */
+       INIT_LIST_HEAD(&(fp->bp_list));
+       INIT_LIST_HEAD(&(fp->glob_list));
+
        fp->client =3D bbc_i2c_attach(bp, op);
        if (!fp->client) {
                kfree(fp);
diff -Naupr linux-3.16-rc6-orig/drivers/sbus/char/bbc_i2c.c linux-3.16-rc6-=
patched/drivers/sbus/char/bbc_i2c.c
--- linux-3.16-rc6-orig/drivers/sbus/char/bbc_i2c.c     2014-07-27 11:49:45=
.000000000 +0200
+++ linux-3.16-rc6-patched/drivers/sbus/char/bbc_i2c.c  2014-07-27 14:28:12=
.000000000 +0200
@@ -300,13 +300,20 @@ static struct bbc_i2c_bus * attach_one_i
        if (!bp)
                return NULL;
=20
+       /* Need to initialize some fields of bbc_i2c_bus */
+       INIT_LIST_HEAD(&(bp->temps));
+       INIT_LIST_HEAD(&(bp->fans));
+
        bp->i2c_control_regs =3D of_ioremap(&op->resource[0], 0, 0x2, "bbc_=
i2c_regs");
        if (!bp->i2c_control_regs)
                goto fail;
=20
-       bp->i2c_bussel_reg =3D of_ioremap(&op->resource[1], 0, 0x1, "bbc_i2=
c_bussel");
-       if (!bp->i2c_bussel_reg)
-               goto fail;
+       if(op->num_resources =3D 2) {
+               bp->i2c_bussel_reg =3D of_ioremap(&op->resource[1], 0, 0x1,=
 "bbc_i2c_bussel");
+               if (!bp->i2c_bussel_reg) {
+                       goto fail;
+               }
+       }
=20
        bp->waiting =3D 0;
        init_waitqueue_head(&bp->wq);

Regards,
Alexander Schulze
