From: David Miller <davem@davemloft.net>
Date: Fri, 17 Jul 2009 17:23:48 +0000
Subject: Re: [2.6.29.4] Blade 2000
Message-Id: <20090717.102348.267553979.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4A1C36B5.6040707@systella.fr>
In-Reply-To: <4A1C36B5.6040707@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND Jo=EBl <joel.bertrand@systella.fr>
Date: Mon, 22 Jun 2009 12:34:21 +0200

> 	When I've tried to investigate, kernel oopses :

This will fix the oops, but not the probe failure:

sparc: Fix cleanup crash in bbc_envctrl_cleanup()

If kthread_run() fails or never gets to run we'll have NULL
or a pointer encoded error in kenvctrld_task, rather than
a legitimate task pointer.

So this makes bbc_envctrl_cleanup() crash as it passed this
bogus pointer into kthread_stop().

Reported-by: BERTRAND Jo=EBl <joel.bertrand@systella.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/sbus/char/bbc_envctrl.c b/drivers/sbus/char/bbc_envctr=
l.c
index 15dab96..7c815d3 100644
--- a/drivers/sbus/char/bbc_envctrl.c
+++ b/drivers/sbus/char/bbc_envctrl.c
@@ -537,8 +537,12 @@ int bbc_envctrl_init(struct bbc_i2c_bus *bp)
 	}
 	if (temp_index !=3D 0 && fan_index !=3D 0) {
 		kenvctrld_task =3D kthread_run(kenvctrld, NULL, "kenvctrld");
-		if (IS_ERR(kenvctrld_task))
-			return PTR_ERR(kenvctrld_task);
+		if (IS_ERR(kenvctrld_task)) {
+			int err =3D PTR_ERR(kenvctrld_task);
+
+			kenvctrld_task =3D NULL;
+			return err;
+		}
 	}
=20
 	return 0;
@@ -561,7 +565,8 @@ void bbc_envctrl_cleanup(struct bbc_i2c_bus *bp)
 	struct bbc_cpu_temperature *tp, *tpos;
 	struct bbc_fan_control *fp, *fpos;
=20
-	kthread_stop(kenvctrld_task);
+	if (kenvctrld_task)
+		kthread_stop(kenvctrld_task);
=20
 	list_for_each_entry_safe(tp, tpos, &bp->temps, bp_list) {
 		list_del(&tp->bp_list);
