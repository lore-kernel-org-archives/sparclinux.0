From: David Miller <davem@davemloft.net>
Date: Mon, 02 Feb 2009 20:50:38 +0000
Subject: Re: Sunfire V880 and 480R 2.6.27.x startup hangs
Message-Id: <20090202.125038.141240910.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Mon, 2 Feb 2009 15:27:57 +0100

> On Fri, Jan 30, 2009 at 04:00:10PM -0800, David Miller wrote:
> > > [   47.553935] calling  of_bus_driver_init+0x0/0x12c
> > > [   47.610180] Setting up of bus
> > > [   47.645596] In bus_register().
> > > [   47.682056] Doing kobject_set_name()
> > > [   47.724764] kset_register()
> > 
> > I suspect it's hanging in uevent generation, let's verify that.
> > Something really weird is going on in your box, I wonder if the bug is
> > surfacing because of all of the non-standard options you have enabled
> > in your build such as cgroups and stuff like that.
> 
> I CC this to the debian sparc people, as the config is derived from
> their default sparc kernel config. If I remember correctly, I only used
> "make oldconfig" to get to the newer kernel. Maybe one of those guys can
> comment on the sparc configuration choices.

I'm not saying the configuration choice is wrong, not at all.

I'm saying that since it's something most active kernel hacker's
don't enable, it may be a reason why myself and others have never
seen this problem.

> Here is the output with all patches and that default build of 2.6.27.13:
> 
> In bus_register().
> Doing kobject_set_name()
> kset_register()
> kset_register: kset_init()
> kset_register: kset_add_internal()
> kset_register: kobject_uevent()
> [halt sent]
> [halt sent]
> [halt sent]
> [halt sent]

I'm pretty certain it's call_usermodehelper() that's hanging.

Perhaps something with forking kernel threads or invoking exec
is failing on sparc64 on your machine for some reason.

New patch:

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 3f91472..2c30f6a 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -100,6 +100,9 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 	int i = 0;
 	int retval = 0;
 
+	printk(KERN_ERR "kobject_uevent_env: [%s] %p\n",
+	       kobject_name(kobj), kobj);
+
 	pr_debug("kobject: '%s' (%p): %s\n",
 		 kobject_name(kobj), kobj, __func__);
 
@@ -109,8 +112,8 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 		top_kobj = top_kobj->parent;
 
 	if (!top_kobj->kset) {
-		pr_debug("kobject: '%s' (%p): %s: attempted to send uevent "
-			 "without kset!\n", kobject_name(kobj), kobj,
+		printk(KERN_ERR "kobject: '%s' (%p): %s: attempted to send uevent "
+		       "without kset!\n", kobject_name(kobj), kobj,
 			 __func__);
 		return -EINVAL;
 	}
@@ -118,12 +121,14 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 	kset = top_kobj->kset;
 	uevent_ops = kset->uevent_ops;
 
+	printk(KERN_ERR "kobject_uevent_env: Checking uevent_ops->filter\n");
+
 	/* skip the event, if the filter returns zero. */
 	if (uevent_ops && uevent_ops->filter)
 		if (!uevent_ops->filter(kset, kobj)) {
-			pr_debug("kobject: '%s' (%p): %s: filter function "
-				 "caused the event to drop!\n",
-				 kobject_name(kobj), kobj, __func__);
+			printk(KERN_ERR "kobject: '%s' (%p): %s: filter function "
+			       "caused the event to drop!\n",
+			       kobject_name(kobj), kobj, __func__);
 			return 0;
 		}
 
@@ -133,16 +138,20 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 	else
 		subsystem = kobject_name(&kset->kobj);
 	if (!subsystem) {
-		pr_debug("kobject: '%s' (%p): %s: unset subsystem caused the "
-			 "event to drop!\n", kobject_name(kobj), kobj,
-			 __func__);
+		printk(KERN_ERR "kobject: '%s' (%p): %s: unset subsystem caused the "
+		       "event to drop!\n", kobject_name(kobj), kobj,
+		       __func__);
 		return 0;
 	}
 
+	printk(KERN_ERR "kobject_uevent_env: Allocating and filling env buffer.\n");
+
 	/* environment buffer */
 	env = kzalloc(sizeof(struct kobj_uevent_env), GFP_KERNEL);
-	if (!env)
+	if (!env) {
+		printk(KERN_ERR "kobject_uevent_env: env kzalloc() failed\n");
 		return -ENOMEM;
+	}
 
 	/* complete object path */
 	devpath = kobject_get_path(kobj, GFP_KERNEL);
@@ -171,6 +180,8 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 		}
 	}
 
+	printk(KERN_ERR "kobject_uevent_env: Checking uevent_ops->uevent\n");
+
 	/* let the kset specific function add its stuff */
 	if (uevent_ops && uevent_ops->uevent) {
 		retval = uevent_ops->uevent(kset, kobj, env);
@@ -207,6 +218,8 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 		struct sk_buff *skb;
 		size_t len;
 
+		printk(KERN_ERR "kobject_uevent_env: Sending netlink msg\n");
+
 		/* allocate message with the maximum possible size */
 		len = strlen(action_string) + strlen(devpath) + 2;
 		skb = alloc_skb(len + env->buflen, GFP_KERNEL);
@@ -234,6 +247,9 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 	if (uevent_helper[0]) {
 		char *argv [3];
 
+		printk(KERN_ERR "kobject_uevent_env: Invoking uevent_helper[%s]\n",
+		       uevent_helper);
+
 		argv [0] = uevent_helper;
 		argv [1] = (char *)subsystem;
 		argv [2] = NULL;
@@ -250,6 +266,7 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 	}
 
 exit:
+	printk(KERN_ERR "kobject_uevent_env: At 'exit', retval=%d\n", retval);
 	kfree(devpath);
 	kfree(env);
 	return retval;
