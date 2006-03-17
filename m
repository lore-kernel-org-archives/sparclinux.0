From: "Daniel 'NebuchadnezzaR' Dehennin" <sparc@asgardr.info>
Date: Fri, 17 Mar 2006 18:28:15 +0000
Subject: Re: bbc, envctrl and sun blade 2000
Message-Id: <87acbpncxs.fsf@thorr.asgardr.info>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <sparclinux.vger.kernel.org>
References: <87k6auqm68.fsf@thorr.asgardr.info>
In-Reply-To: <87k6auqm68.fsf@thorr.asgardr.info>
To: sparclinux@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Le 4580 Septembre 1993, David S. Miller a tapoté:
> Only if you can do the heavy lifting of building new kernels,
> modifying the conditional, testing the result and sending
> a working patch after the testing.

Ok, I modify the test in bbc_i2c_init to include cheetah_plus:
From dmesg:

bbc: module license 'unspecified' taints kernel.
EBUS i2c-0: Regs at 000007fe7e00002e, 6 devices, own a0, clock 10.
i2c-1: Regs at 000007fe7e000030, 8 devices, own a0, clock 10.
bbc_envctrl: kenvctrld starting...

So it works, fan follow the cpu usage, is there a place to look at
temperature and fans speed ?

The module envctrl do not load: "no such device".

Follwing, the inlined patch.

Regards.
-- 
Daniel 'NebuchadnezzaR' Dehennin
Récupérer ma clef GPG:
gpg --keyserver pgp.mit.edu --recv-keys 0x2A408F69

--=-=-=
Content-Disposition: inline; filename=bbc_i2c.diff
Content-Description: bbc_i2c.diff

--- drivers/sbus/char/bbc_i2c.c.orig	2006-03-17 19:24:49.138423606 +0100
+++ drivers/sbus/char/bbc_i2c.c	2006-03-17 19:25:14.652914637 +0100
@@ -440,7 +440,7 @@
 	struct linux_ebus_device *edev = NULL;
 	int err, index = 0;
 
-	if (tlb_type != cheetah || !bbc_present())
+	if ((tlb_type != cheetah && tlb_type != cheetah_plus) || !bbc_present())
 		return -ENODEV;
 
 	for_each_ebus(ebus) {

--=-=-=--
