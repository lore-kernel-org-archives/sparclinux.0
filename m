From: David Miller <davem@davemloft.net>
Date: Mon, 04 Jan 2010 23:32:42 +0000
Subject: Re: BBC I2C doesn't work on V880
Message-Id: <20100104.153242.19213689.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200912021105.03604.pat@computer-refuge.org>
In-Reply-To: <200912021105.03604.pat@computer-refuge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Patrick Finnegan <pat@computer-refuge.org>
Date: Wed, 2 Dec 2009 11:05:03 -0500

> Going through the remaining problems I'm having with my V880, it looks 
> like the SPARC bbc i2c driver won't load.  This is with Linus's git 
> tree from a few days ago.  When I do a "modprobe bbc", I get this:
> 
> [ 3735.308284] i2c-0: Regs at 000007fc7e00002e, 2 devices, own a0, clock 10.
> [ 3735.388677] bbc_i2c: probe of f00bd100 failed with error -22
> [ 3735.456691] i2c-0: Regs at 000007fc7e50002e, 8 devices, own a0, clock 10.
> [ 3735.537696] bbc_i2c: probe of f00cd000 failed with error -22
> 
> And, when I try to rmmod bbc, I get a kernel NULL pointer bug:
> 
> [ 3878.082842] Unable to handle kernel NULL pointer dereference                 

Ok, the following patch should fix the crash.

But I can't see why kthread_run() should fail and that's the
only patch I can see which can return -EINVAL during the
probe.

Can you do me a favor after you make sure rmmod no longer causes
a crash?  Add some printk() diagnostics to kernel/fork.c:copy_process()
for all those checks there that return ERR_PTR(-EINVAL).  See if any
of them trigger, and if so which one.

Thanks!

commit c7c17c2779075e675cb3c7fe2ecde67e226771fb
Author: David S. Miller <davem@davemloft.net>
Date:   Mon Jan 4 15:31:10 2010 -0800

    bbc_envctrl: Clean up properly if kthread_run() fails.
    
    In bbc_envctrl_init() we have to unlink the fan and temp instances
    from the lists because our caller is going to free up the 'bp' object
    if we return an error.
    
    We can't rely upon bbc_envctrl_cleanup() to do this work for us in
    this case.
    
    Reported-by: Patrick Finnegan <pat@computer-refuge.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/sbus/char/bbc_envctrl.c b/drivers/sbus/char/bbc_envctrl.c
index 7c815d3..28d86f9 100644
--- a/drivers/sbus/char/bbc_envctrl.c
+++ b/drivers/sbus/char/bbc_envctrl.c
@@ -522,6 +522,40 @@ static void attach_one_fan(struct bbc_i2c_bus *bp, struct of_device *op,
 	set_fan_speeds(fp);
 }
 
+static void destroy_one_temp(struct bbc_cpu_temperature *tp)
+{
+	bbc_i2c_detach(tp->client);
+	kfree(tp);
+}
+
+static void destroy_all_temps(struct bbc_i2c_bus *bp)
+{
+	struct bbc_cpu_temperature *tp, *tpos;
+
+	list_for_each_entry_safe(tp, tpos, &bp->temps, bp_list) {
+		list_del(&tp->bp_list);
+		list_del(&tp->glob_list);
+		destroy_one_temp(tp);
+	}
+}
+
+static void destroy_one_fan(struct bbc_fan_control *fp)
+{
+	bbc_i2c_detach(fp->client);
+	kfree(fp);
+}
+
+static void destroy_all_fans(struct bbc_i2c_bus *bp)
+{
+	struct bbc_fan_control *fp, *fpos;
+
+	list_for_each_entry_safe(fp, fpos, &bp->fans, bp_list) {
+		list_del(&fp->bp_list);
+		list_del(&fp->glob_list);
+		destroy_one_fan(fp);
+	}
+}
+
 int bbc_envctrl_init(struct bbc_i2c_bus *bp)
 {
 	struct of_device *op;
@@ -541,6 +575,8 @@ int bbc_envctrl_init(struct bbc_i2c_bus *bp)
 			int err = PTR_ERR(kenvctrld_task);
 
 			kenvctrld_task = NULL;
+			destroy_all_temps(bp);
+			destroy_all_fans(bp);
 			return err;
 		}
 	}
@@ -548,35 +584,11 @@ int bbc_envctrl_init(struct bbc_i2c_bus *bp)
 	return 0;
 }
 
-static void destroy_one_temp(struct bbc_cpu_temperature *tp)
-{
-	bbc_i2c_detach(tp->client);
-	kfree(tp);
-}
-
-static void destroy_one_fan(struct bbc_fan_control *fp)
-{
-	bbc_i2c_detach(fp->client);
-	kfree(fp);
-}
-
 void bbc_envctrl_cleanup(struct bbc_i2c_bus *bp)
 {
-	struct bbc_cpu_temperature *tp, *tpos;
-	struct bbc_fan_control *fp, *fpos;
-
 	if (kenvctrld_task)
 		kthread_stop(kenvctrld_task);
 
-	list_for_each_entry_safe(tp, tpos, &bp->temps, bp_list) {
-		list_del(&tp->bp_list);
-		list_del(&tp->glob_list);
-		destroy_one_temp(tp);
-	}
-
-	list_for_each_entry_safe(fp, fpos, &bp->fans, bp_list) {
-		list_del(&fp->bp_list);
-		list_del(&fp->glob_list);
-		destroy_one_fan(fp);
-	}
+	destroy_all_temps(bp);
+	destroy_all_fans(bp);
 }
