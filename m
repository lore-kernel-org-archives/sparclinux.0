From: David Miller <davem@davemloft.net>
Date: Sat, 31 Jan 2009 00:00:10 +0000
Subject: Re: Sunfire V880 and 480R 2.6.27.x startup hangs
Message-Id: <20090130.160010.211744559.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Wed, 28 Jan 2009 09:45:18 +0100

> It's hanging in kset_register. Does this ring a bell to you ?
> Will move the full output to the usual place. Thanks.
 ...
> [   47.553935] calling  of_bus_driver_init+0x0/0x12c
> [   47.610180] Setting up of bus
> [   47.645596] In bus_register().
> [   47.682056] Doing kobject_set_name()
> [   47.724764] kset_register()

I suspect it's hanging in uevent generation, let's verify that.
Something really weird is going on in your box, I wonder if the bug is
surfacing because of all of the non-standard options you have enabled
in your build such as cgroups and stuff like that.

Anyways, add this patch on top of your tree and please send the tail
of the new output.

One thing you might want to try to do when it hangs is go:

1) Send a 'break' over the console then immediately type '8'.
   This will increase the kernel log level.

2) Send a 'break' then 'p', this will dump the current cpu's
   registers.

3) Send a 'break' then 'y', this will give a brief backtrace
   on all cpus.

4) Send a 'break' then 't', this will dump the state of all
   processes on the system.

Unfortunately, none of those will work if the cpu handling console
interrupts has cpu interrupts disabled for whatever reason :-/ But it
is definitely worth a try.

Thanks.

diff --git a/lib/kobject.c b/lib/kobject.c
index fbf0ae2..4553903 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -708,11 +708,17 @@ int kset_register(struct kset *k)
 	if (!k)
 		return -EINVAL;
 
+	printk(KERN_ERR "kset_register: kset_init()\n");
 	kset_init(k);
+	printk(KERN_ERR "kset_register: kset_add_internal()\n");
 	err = kobject_add_internal(&k->kobj);
-	if (err)
+	if (err) {
+		printk(KERN_ERR "kset_register: Got error %d\n", err);
 		return err;
+	}
+	printk(KERN_ERR "kset_register: kobject_uevent()\n");
 	kobject_uevent(&k->kobj, KOBJ_ADD);
+	printk(KERN_ERR "kset_register: Done\n");
 	return 0;
 }
 
