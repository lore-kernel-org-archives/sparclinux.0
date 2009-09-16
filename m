From: Josip Rodin <joy@entuzijast.net>
Date: Wed, 16 Sep 2009 07:57:22 +0000
Subject: Re: Sparc release requalification
Message-Id: <20090916075721.GA20122@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Tue, Sep 15, 2009 at 12:05:30PM +0200, S=E9bastien Bernard wrote:
>> I was able to reproduce the hang with your originally posted config.
>>
>> It only triggers when CONFIG_PROM_CONSOLE is enabled
>>  =20
> Very good news.
> I had a lot of trouble because of this.
> I had to disable it for initcall_debug to work, but then, any kernel =20
> patched or not was working.
> I thought I messed up between patches and built kernels.
> I realize now that I had the explanation under my nose.
> Duh....

I had just recompiled and booted my SMP kernel without the dreaded
PROM_CONSOLE, and yet the machine got stuck in the same place in the
NMI code. I then removed initcall_debug, and it still doesn't work.
What am I missing?!

The .config diff between the working UP kernel and this one is:

--- /boot/config.old    2009-09-14 12:08:04.000000000 +0000
+++ /boot/config        2009-09-16 07:44:16.000000000 +0000
@@ -4 +4 @@
-# Mon Sep 14 11:47:09 2009
+# Tue Sep 15 09:59:03 2009
@@ -35 +35 @@
-CONFIG_BROKEN_ON_SMP=3Dy
+CONFIG_LOCK_KERNEL=3Dy
@@ -113,0 +114 @@
+CONFIG_USE_GENERIC_SMP_HELPERS=3Dy
@@ -129,0 +131 @@
+CONFIG_STOP_MACHINE=3Dy
@@ -152 +154,2 @@
-# CONFIG_SMP is not set
+CONFIG_SMP=3Dy
+CONFIG_NR_CPUS2
@@ -163,0 +167 @@
+CONFIG_SPARC64_SMP=3Dy
@@ -166,0 +171 @@
+# CONFIG_HOTPLUG_CPU is not set
@@ -172,0 +178 @@
+# CONFIG_NUMA is not set
@@ -193,0 +200,2 @@
+CONFIG_SCHED_SMT=3Dy
+CONFIG_SCHED_MC=3Dy
@@ -1141 +1149 @@
-CONFIG_PROM_CONSOLE=3Dy
+# CONFIG_PROM_CONSOLE is not set

--=20
     2. That which causes joy or happiness.
