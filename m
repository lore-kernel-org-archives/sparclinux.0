From: David Miller <davem@davemloft.net>
Date: Sat, 03 Apr 2010 08:16:32 +0000
Subject: Re: Kernel panic - not syncing: Irrecoverable deferred error trap
Message-Id: <20100403.011632.111570804.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1270240845.1783.52.camel@deblnxsrv254.localdomain>
In-Reply-To: <1270240845.1783.52.camel@deblnxsrv254.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans van Berckel <fberckel@xs4all.nl>
Date: Sat, 03 Apr 2010 09:09:41 +0200

> On Fri, 2010-04-02 at 23:47 -0700, David Miller wrote:
>> Frans, please retry your test case, but please add
>> "of_debug=1 ofpci_debug=1" to the kernel command line
>> options.
>> 
>> Send the kernel log you get as a result, thanks!
> 
> Attached the boot log

I see the problem.

The XVR-1200 has extra PCI subfunction devices representing secondary
and further monitors attached to the card.

These nodes are special and we should not try to drive them.

Out of curiosity do you have multiple monitors hooked up to the
XVR-1200 device, or just one?

I bet this might explain the XVR-600 failures I could not reproduce,
as seen by Paul Cao, CC:'d.  Paul if you had two monitors hooked up to
your XVR-600, try next time installing with just one monitor attached.

Frans, if you could test the patch below I'd really appreciate it.

Also, once you get this working, please send me "prtconf -pv" output
for this machine with both of these graphics cards in it.

Thanks again for your reports and all of your help so far!

--------------------
sunxvr500: Ignore secondary output PCI devices.

These just represent the secondary and further heads attached to the
card, and they have different sets of PCI bar registers to map.

So don't try to drive them in the main driver.

Reported-by: Frans van Berckel <fberckel@xs4all.nl>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/video/sunxvr500.c b/drivers/video/sunxvr500.c
index 4cd5049..3803745 100644
--- a/drivers/video/sunxvr500.c
+++ b/drivers/video/sunxvr500.c
@@ -242,11 +242,27 @@ static int __devinit e3d_set_fbinfo(struct e3d_info *ep)
 static int __devinit e3d_pci_register(struct pci_dev *pdev,
 				      const struct pci_device_id *ent)
 {
+	struct device_node *of_node;
+	const char *device_type;
 	struct fb_info *info;
 	struct e3d_info *ep;
 	unsigned int line_length;
 	int err;
 
+	of_node = pci_device_to_OF_node(pdev);
+	if (!of_node) {
+		printk(KERN_ERR "e3d: Cannot find OF node of %s\n",
+		       pci_name(pdev));
+		return -ENODEV;
+	}
+
+	device_type = of_get_property(of_node, "device_type", NULL);
+	if (!device_type) {
+		printk(KERN_INFO "e3d: Ignoring secondary output device "
+		       "at %s\n", pci_name(pdev));
+		return -ENODEV;
+	}
+
 	err = pci_enable_device(pdev);
 	if (err < 0) {
 		printk(KERN_ERR "e3d: Cannot enable PCI device %s\n",
@@ -265,13 +281,7 @@ static int __devinit e3d_pci_register(struct pci_dev *pdev,
 	ep->info = info;
 	ep->pdev = pdev;
 	spin_lock_init(&ep->lock);
-	ep->of_node = pci_device_to_OF_node(pdev);
-	if (!ep->of_node) {
-		printk(KERN_ERR "e3d: Cannot find OF node of %s\n",
-		       pci_name(pdev));
-		err = -ENODEV;
-		goto err_release_fb;
-	}
+	ep->of_node = of_node;
 
 	/* Read the PCI base register of the frame buffer, which we
 	 * need in order to interpret the RAMDAC_VID_*FB* values in
