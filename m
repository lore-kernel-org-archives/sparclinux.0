From: David Miller <davem@davemloft.net>
Date: Sat, 24 Jun 2006 07:15:52 +0000
Subject: Sparc driver changes afoot for 2.6.18
Message-Id: <20060624.001552.92583040.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


In the following tree:

	kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git

are some interesting changes for Sparc land.

Finally the SBUS, EBUS, ISA, etc. drivers can plug into the
generic device subsystem of the Linux kernel properly.

This means that there are proper device ID tables in the
SBUS driver modules and therefore things like UDEV should
be able to auto-load SBUS modules.

I converted most of the SBUS drivers.  All the networking and SCSI
SBUS drivers are converted.  There are some odds and ends left such as
the FC4 drivers but those are only half working anyways.

Unconverted drivers should still work as well as they did before the
new code, they just use the older interfaces and won't integrate with
the generic device subsystem.

I tested as much as I could on sparc64 and I tried hard not to
break things on sparc32 but I was not able to test things there.

Those changes should show up in Linus's tree in the next day or
so too.

If some sparc32 folks get a chance to test and help fix any
regressions, that would be really appreciated.

When it works you'll get device nodes under /sys/bus/{ebus,isa,sbus}/
and things like that.  It's pretty easy to convert the probing code
in an SBUS driver to the new stuff, and the documentation has even
been updated in Documentation/sparc/sbus_drivers.txt.  One can look
at one of the converted drivers as well for hints.

The main thing to watch for when testing on sparc32 is the build of
the in-kernel copy of the OBP device tree.  This is done right after
paging_init() is done, by calling
arch/sparc/kernel/prom.c:prom_build_devicetree().

If you get a hang early on in the boot process, it's probably
happening in there, or in sbus_init().

Notice there are no ugly ifdefs in drivers/sbus/sbus.c any longer :)
We can probably make sbus_init() a subsys_initcall() instead of
explicitly calling it from the sparc ports.

In fact there are a ton of cleanups and fixes possible with this
new stuff. :-)

In fact if some sparc32 person gets inspired, it's easy to convert
code that runs after prom_build_devicetree() to use the in-kernel
device tree for OBP device tree probing.  All of this kind of code
is very idiomatic and thus easy to convert:

	old				new


	prom_root_node			dp = of_find_node_by_path("/");

	len = prom_getproperty()	val = of_get_property(dp, "name", &len)
	val = prom_getint_default()	val = of_getintprop_default()
	nd = prom_getchild(x)		nd = x->child
	nd = prom_getsibling(x)		nd = x->sibling

You can find each OBP node with a given name using:

	for_each_node_by_name(dp, "the_name") {
	}

You can do the same for each OBP with a given "device_type" property
value:

	for_each_node_by_type(dp, "the_type") {
	}

If you have an old-style OBP node handle integer, you can get the
in-kernel device node pointer using:

	dp = of_find_node_by_phandle(prom_node);

You can see if a certain string is listed in a device node's
"compatible" property string list:

	if (of_device_is_compatible(dp, "compat_value"))

The new stuff is a lot more flexible, and also more streamlined since
no OBP firmware calls are made to do any of this stuff.  You don't
need to allocate local buffers, on the stack or dynamically, to get
property values either, as they are already in-kernel.

If you want to have a local copy, to make modifications such as to
adjust a reg property with ranges values, you do still need to
allocate some space to do that.  You can't make changes to the
in-kernel OBP tree copies of the properties! :-)
