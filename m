From: Josip Rodin <joy@entuzijast.net>
Date: Mon, 14 Sep 2009 12:40:22 +0000
Subject: Re: Sparc release requalification
Message-Id: <20090914124022.GA24872@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Sep 14, 2009 at 02:36:48PM +0200, Josip Rodin wrote:
> > > 2) Try a UP kernel build, does it work even with all of the NMI
> > >    bits enabled on this machine?
> > 
> > Will try and report shortly.
> 
> It seems to work just fine without SMP.

Just in case it might matter:

--- /boot/config-2.6.31.old     2009-09-11 23:10:03.000000000 +0000
+++ /boot/config-2.6.31 2009-09-14 12:08:04.000000000 +0000
@@ -4 +4 @@
-# Fri Sep 11 18:23:35 2009
+# Mon Sep 14 11:47:09 2009
@@ -35 +35 @@
-CONFIG_LOCK_KERNEL=y
+CONFIG_BROKEN_ON_SMP=y
@@ -114 +113,0 @@
-CONFIG_USE_GENERIC_SMP_HELPERS=y
@@ -131 +129,0 @@
-CONFIG_STOP_MACHINE=y
@@ -154,2 +152 @@
-CONFIG_SMP=y
-CONFIG_NR_CPUS2
+# CONFIG_SMP is not set
@@ -167 +163,0 @@
-CONFIG_SPARC64_SMP=y
@@ -171 +166,0 @@
-# CONFIG_HOTPLUG_CPU is not set
@@ -178 +172,0 @@
-# CONFIG_NUMA is not set
@@ -200,2 +193,0 @@
-CONFIG_SCHED_SMT=y
-CONFIG_SCHED_MC=y

-- 
     2. That which causes joy or happiness.
