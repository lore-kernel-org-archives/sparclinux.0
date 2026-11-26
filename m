Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685494;
	b=XZ6mPMsO9v64zYoKuQ8fQ9vaqTWAmr6FX7LH4FUEGN738rs62iF21+fIR1kuNbVkPwMw
	 GrpIfjmcPA+4gjoItyi1UhK7uTCho9CE2Pez6klSMqvgR0ylABf+dPOX8pIVToZuz+vz+
	 aiKko13JMnnHpUApVcAc66L18BeE+RC5C2/dJdjm3ngHzJyaEssIDEkOW9kUJIC0HrSvH
	 LCaFRclekzbp/oOvYgICZq48haFoZfXEKgbBju9YXGIm9TyZghZzGZZjuRW+qc31bugzg
	 uoixwil3IvH+EkH/K16CkzpSE1H3AYFiKO+At4gu1c2MQAIudNvxDFZuHacFWJEh1zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685494;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dhgAqUexAx0akPEBmUx3hg120Mv0CqmUceKuUJMrsi0=;
	b=nFJB5PADVstjdl/6MtrAusMI/vC6pCsmR1m9aY/22pFsCwOUT3AqK85F0x7JVSkzsXzC
	 zFclaImBxy4k6oINl6H21z8kpU6n4cqbPg+oTasrCoH5mkLp5VNK6lDiFkITuPyI5aaOs
	 BLohEJ730suo6nndXhDpLAWLGSgNsq9z+F9fDlgnbHMcIVMJdLTAWll364XQfBfzJmtDR
	 jxYEGKHY7Ys+3Es1wbMwKXjIbLYvLUzy+d8GTsBwU7U63z0V95GI2g+uvFWZ7WMJ/wnuT
	 jFMVNB1vDlYbxkLjNMzOKIiGlkaFe8ZMFApb/QrLHRuYQkPKBkcPNBIRXne2HyBmYdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Av0yqfyZ;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026B0606A32E
	for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 09:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 026B0606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Av0yqfyZ
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b887ca9f5cso9722075a12.0
        for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 01:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685492; x=1796290292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dhgAqUexAx0akPEBmUx3hg120Mv0CqmUceKuUJMrsi0=;
        b=Av0yqfyZcYlX+Fh5ia0aHAJtb28S0HSUkwzadwTS5Rq4pxD+iSdrILbcNmqqJboiO9
         CwBElEeTynjw7uchu4gLjIBMwJ0iabqCeTtdzUo332zlHn0WRYKsyOY567GoxmVcvCBc
         K1wqwx8mlF5B38PwtMWIyrRYKW5Rh8Yvzr15dIFlhWiayLTy0yhwi7Ne9yBVjhGP3Mgf
         OBIspfhQk8hzqhXBDL9FXEyLPyk/y/3t/YCYA7pn4HomwuwUAxyF46Cc1pTMqa+hw547
         PN0biVvHzjtNis67EZ+V4fxVrXOTQ1C4tKfSfFeR9NQeHOqrwGW+VoGzEKnfWQFswtUx
         k/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685492; x=1796290292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dhgAqUexAx0akPEBmUx3hg120Mv0CqmUceKuUJMrsi0=;
        b=cfKo91CwULRTnSzBSH5290zJHg+iM0YDE9I/nddbpBXuSZgLCJKj+dFjSbdQdhHknP
         nvIBntA2QlYbaHuk7fQYbwfm0BtaOEoePrOcBrclFF+hc9c/Qp96D0uH2NJPB4Z14Cox
         8SCsBT1inZBQs9M2Hf5VBaOL2r9k08jyr1kvV7JhIJMvyxpNvW5E7KjG6owlkmeGFv5r
         AmjpPLza0uwAhlNG2i9HRTouSBo0BACGX+JGZRIgEbEnv2sxyA+15KqHB62pRQVF7Gz0
         mLOc9TVIf+UP3T5v8D6nso9JHI4HE8qoWdGhWPclO2USmJ1dyWbvOZJ3nJzwfi2uPYcF
         +mkQ==
X-Forwarded-Encrypted: i=1; AL+hErFDWdq6UdUAY6cMUihlt3Y07UfigTyHqcUI814wWDBzU8p4jswSr1w84TIN78nsA9r/3JYJRfOOcPIr@vger.kernel.org
X-Gm-Message-State: APuU4Z8KKAjAM00A7n22AJBBh50Ow/KJJRFNUzAoj1Oyr6xCPxJi0KyA
	5sG5aG5nGbAah5CXw2zu6YOQSx9mRSWSs3GU/RRSMrQnYmC9tWzcOxN1
X-Gm-Gg: AZFdTZcawt2m8c+QX9MdjTeBg23ecYyXq3eh4DChh9jhYylGBW7IUoXwRnaMBy1s6dp
	3wBq1hoHaidAElpPxP7SMiCgrQYfH7bSeObR9PcZwnjDwB9rlYxhIOpQknxeObWSU6XZtS3bu7j
	QBjskAGATxn9/zORDGH+sly2q9oraAHvni4RKKamVtB55M8OINZ2GRHQPP4UEfS3BsU74cvJvAv
	TWicP4UwO3lpDynFcdaJlo78uuvyGaLMk5x3V7VGW36KAnmf19HUt4NTVCNw2UJY9hJNWjqaPL7
	kPTlRFtPnha61RPbrspJL2EhhFexp9bZk/KK1RCyCCXvPk/Zn8N4KgoFGP51cauhNWi5sxDPmDO
	2Z4PWcEy05NHRdt/ImA+OeFf+ZSYAfdiPB9WTK6AT5jICUkLjlmJEhXOiVHSazJUNM8vWTGiVV/
	qeAzYKlYJlkReZl7ULcfDHUJiiU1wUyCexTfTyeu4b4EXZV+LD5IqMsQbNFSmEpTLZmzCEqUy0W
	eoFEWZin827E1Nnrm8RmuKIZezE05aOtWAcomZPvNTNtdKeRd1y2A9AEehKOQySN6nNW156ZuHO
	77+FYRcUhBhhRKRNt1o0WrqfQmlapO2OA52KINxB9mwL/acAFA1ebURH0AZkWSmfCEwAOiWu
X-Received: by 2002:a17:906:fa82:b0:c50:4b6e:329 with SMTP id a640c23a62f3a-c513a5eaea2mr1331141366b.15.1795685492298;
        Thu, 26 Nov 2026 01:31:32 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdee82sm597090066b.66.2026.11.26.01.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:31:31 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH 13/18] sparc32,leon: discover AMBA devices for legacy U-Boot PROMs
Date: Thu, 26 Nov 2026 10:30:18 +0100
Message-ID: <20261126093106.1345825-14-linmag7@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126093106.1345825-1-linmag7@gmail.com>
References: <20261126093106.1345825-1-linmag7@gmail.com>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factory LEON U-Boot supplies no AMBA device nodes. For its legacy PROM
signature, discover GRLIB plug-and-play buses and synthesize the missing
nodes, resources and clocks with bounded traversal.

Publish the system ID needed by the existing LEON4 idle workaround.
Reserve a conflict-free IPI only for SMP. Preserve firmware-supplied
trees; reject unsupported required topology rather than continuing
without usable interrupt and timer controllers.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/Makefile      |   1 +
 arch/sparc/kernel/leon_legacy.c | 343 ++++++++++++++++++++++++++++++++
 arch/sparc/kernel/prom.h        |   5 +
 arch/sparc/kernel/prom_common.c |   1 +
 drivers/of/pdt.c                |   9 +-
 include/linux/of_pdt.h          |   5 +
 6 files changed, 362 insertions(+), 2 deletions(-)
 create mode 100644 arch/sparc/kernel/leon_legacy.c

diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 497b5714fa8f..6bfc23ce3b08 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_SPARC64)   += prom_irqtrans.o
 
 obj-$(CONFIG_SPARC32)   += leon_kernel.o
 obj-$(CONFIG_SPARC32)   += leon_pmc.o
+obj-$(CONFIG_SPARC_LEON) += leon_legacy.o
 
 obj-$(CONFIG_SPARC64)   += reboot.o
 obj-$(CONFIG_SPARC64)   += sysfs.o
diff --git a/arch/sparc/kernel/leon_legacy.c b/arch/sparc/kernel/leon_legacy.c
new file mode 100644
index 000000000000..a9364708e231
--- /dev/null
+++ b/arch/sparc/kernel/leon_legacy.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Written by Magnus Lindholm, linmag7@gmail.com
+ *
+ * Build the AMBA device tree omitted by the factory LEON U-Boot.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_pdt.h>
+#include <linux/string.h>
+
+#include <asm/leon.h>
+#include <asm/leon_amba.h>
+#include <asm/oplib.h>
+#include <asm/cpu_type.h>
+
+#include "prom.h"
+
+#define LEGACY_MAX_BUSES 8
+#define LEGACY_AHB_SLOTS 64
+#define LEGACY_APB_SLOTS 16
+
+struct legacy_bus {
+	u32 area;
+	u32 freq;
+	u32 bridge;
+	unsigned int parent;
+};
+
+static struct legacy_bus legacy_buses[LEGACY_MAX_BUSES] __initdata;
+static unsigned int legacy_bus_count __initdata;
+static phandle legacy_phandle __initdata;
+static u32 legacy_irqs __initdata = BIT(0) | BIT(15);
+
+static u32 __init legacy_read(u32 address)
+{
+	return LEON3_BYPASS_LOAD_PA(address);
+}
+
+static bool __init legacy_is(u32 id, unsigned int device)
+{
+	return (id >> 24) == VENDOR_GAISLER &&
+	       ((id >> 12) & 0xfff) == device;
+}
+
+/* GRLIB AHB memory and bus-relative AHB I/O BAR encodings. */
+static bool __init legacy_bar(u32 area, u32 bar, u32 *addr, u32 *size)
+{
+	u32 mask = (bar >> 4) & 0xfff;
+	u32 start = (bar & 0xfff00000) & (mask << 20);
+
+	switch (bar & 0xf) {
+	case 2:
+		*addr = start;
+		*size = -(mask << 20);
+		break;
+	case 3:
+		*addr = area | (start >> 12);
+		*size = ((~mask & 0xfff) + 1) << 8;
+		break;
+	default:
+		return false;
+	}
+	return *size && is_power_of_2(*size);
+}
+
+static void __init legacy_property(struct device_node *np, const char *name,
+				   const void *value, unsigned int length)
+{
+	struct property *p = prom_early_alloc(sizeof(*p));
+
+	p->name = prom_early_alloc(strlen(name) + 1);
+	strscpy(p->name, name, strlen(name) + 1);
+	p->value = prom_early_alloc(length + 1);
+	memcpy(p->value, value, length);
+	p->length = length;
+	p->unique_id = of_pdt_alloc_unique_id();
+	p->next = np->properties;
+	np->properties = p;
+}
+
+static void __init legacy_u32(struct device_node *np, const char *name, u32 val)
+{
+	__be32 cell = cpu_to_be32(val);
+
+	legacy_property(np, name, &cell, sizeof(cell));
+}
+
+static struct device_node * __init legacy_node(struct device_node *parent,
+					       const char *name, const char *path)
+{
+	struct device_node *np = prom_early_alloc(sizeof(*np));
+	struct device_node **tail = &parent->child;
+
+	of_node_init(np);
+	np->name = prom_early_alloc(strlen(name) + 1);
+	strscpy((char *)np->name, name, strlen(name) + 1);
+	np->full_name = prom_early_alloc(strlen(path) + 1);
+	strscpy((char *)np->full_name, path, strlen(path) + 1);
+	np->parent = parent;
+	np->phandle = ++legacy_phandle;
+	np->unique_id = of_pdt_alloc_unique_id();
+	legacy_property(np, "name", name, strlen(name) + 1);
+	legacy_u32(np, ".node", np->phandle);
+	/* Like the PROM builder, publish before OF device registration starts. */
+	while (*tail)
+		tail = &(*tail)->sibling;
+	*tail = np;
+	return np;
+}
+
+/* Follow version-1 AHB2AHB bridges, including reverse links, once per bus. */
+static int __init legacy_scan_buses(void)
+{
+	unsigned int b, slot, seen;
+	int cpu_bus = -1;
+
+	legacy_bus_count = 1;
+	legacy_buses[0].area = LEON3_IO_AREA;
+	for (b = 0; b < legacy_bus_count; b++) {
+		u32 table = legacy_buses[b].area | LEON3_CONF_AREA;
+
+		for (slot = 0; slot < LEGACY_AHB_SLOTS; slot++) {
+			u32 id = legacy_read(table + slot * 32);
+
+			legacy_irqs |= BIT(id & 0x1f);
+			if (legacy_is(id, GAISLER_LEON3) ||
+			    legacy_is(id, GAISLER_LEON4))
+				cpu_bus = b;
+		}
+		for (slot = 0; slot < LEGACY_AHB_SLOTS; slot++) {
+			u32 pnp = table + 0x800 + slot * 32;
+			u32 id = legacy_read(pnp);
+			u32 area;
+
+			if (!legacy_is(id, GAISLER_AHB2AHB))
+				continue;
+			if (((id >> 5) & 0x1f) != 1) {
+				pr_warn("LEON: unsupported legacy AHB bridge at %x\n", pnp);
+				continue;
+			}
+			area = legacy_read(pnp + 8);
+			if (!area || (area & 0xfffff))
+				continue;
+			for (seen = 0; seen < legacy_bus_count; seen++)
+				if (legacy_buses[seen].area == area)
+					break;
+			if (seen < legacy_bus_count)
+				continue;
+			if (legacy_bus_count == LEGACY_MAX_BUSES)
+				panic("LEON: too many legacy AMBA buses");
+			legacy_buses[seen].area = area;
+			legacy_buses[seen].parent = b;
+			legacy_buses[seen].bridge = legacy_read(pnp + 4);
+			legacy_bus_count++;
+		}
+	}
+	return cpu_bus;
+}
+
+/*
+ * This U-Boot puts CONFIG_SYS_CLK_FREQ / 1000 in the CPU property, but
+ * uses CONFIG_SYS_CLK_FREQ for its initial bus at LEON3_IO_AREA. It is
+ * the I/O-bus clock in kHz, not the actual CPU clock on a bridged LEON4.
+ */
+static bool __init legacy_clocks(int cpu_bus)
+{
+	struct device_node *cpu;
+	u32 freq, factor, config;
+	unsigned int b;
+
+	if (cpu_bus < 0)
+		return false;
+	cpu = of_find_node_by_type(NULL, "cpu");
+	if (!cpu)
+		return false;
+	freq = of_getintprop_default(cpu, "clock-frequency", 0);
+	of_node_put(cpu);
+	if (!freq || freq > U32_MAX / 1000)
+		return false;
+	freq *= 1000;
+	legacy_buses[0].freq = freq;
+	for (b = 1; b < legacy_bus_count; b++) {
+		freq = legacy_buses[legacy_buses[b].parent].freq;
+		/* AHB2AHB user[0]: FFACT at 7:4, direction at bit 8. */
+		config = legacy_buses[b].bridge;
+		factor = (config >> 4) & 0xf;
+		if (!factor)
+			factor = 1;
+		if (config & 0x100) {
+			if (freq > U32_MAX / factor)
+				return false;
+			freq *= factor;
+		} else {
+			freq /= factor;
+		}
+		legacy_buses[b].freq = freq;
+	}
+	return true;
+}
+
+static void __init legacy_device(struct device_node *bus, u32 id, u32 freq,
+				 __be32 *regs, unsigned int count)
+{
+	struct device_node *np;
+	char name[16], path[48];
+	u32 device = (id >> 12) & 0xfff;
+	u32 irq = id & 0x1f;
+	u32 addr = be32_to_cpu(regs[0]);
+	u32 config;
+	unsigned int timer;
+
+	legacy_irqs |= BIT(irq);
+	if (legacy_is(id, GAISLER_GPTIMER)) {
+		config = legacy_read(addr + 8);
+		if (config & BIT(8))
+			for (timer = 0; timer < (config & 7); timer++)
+				legacy_irqs |= BIT((irq + timer) & 0x1f);
+	}
+	if (legacy_is(id, GAISLER_IRQMP)) {
+		config = legacy_read(addr + 0x10);
+		legacy_irqs |= BIT((config >> 16) & 0xf);
+	}
+
+	snprintf(name, sizeof(name), "%02x_%03x", id >> 24, device);
+	snprintf(path, sizeof(path), "%s@%x,%x", name, irq,
+		 be32_to_cpu(regs[0]));
+	np = legacy_node(bus, name, path);
+	legacy_property(np, "reg", regs, count * 2 * sizeof(*regs));
+	legacy_u32(np, "freq", freq);
+	legacy_u32(np, "vendor", id >> 24);
+	legacy_u32(np, "device", device);
+	legacy_u32(np, "version", (id >> 5) & 0x1f);
+	if (irq)
+		legacy_u32(np, "interrupts", irq);
+	pr_info("LEON PnP: %s at %08x irq %u clock %u\n", name,
+		be32_to_cpu(regs[0]), irq, freq);
+}
+
+static void __init legacy_apb(struct device_node *bus, u32 base, u32 freq)
+{
+	unsigned int slot;
+
+	for (slot = 0; slot < LEGACY_APB_SLOTS; slot++) {
+		u32 pnp = (base | LEON3_CONF_AREA) + slot * 8;
+		u32 id = legacy_read(pnp), bar, addr, size, mask;
+		__be32 regs[2];
+
+		if (!(id >> 24) || !((id >> 12) & 0xfff))
+			continue;
+		bar = legacy_read(pnp + 4);
+		if ((bar & 0xf) != 1)
+			continue;
+		mask = (bar >> 4) & 0xfff;
+		addr = base | (((bar & 0xfff00000) >> 12) & (mask << 8));
+		size = ((~mask & 0xfff) + 1) << 8;
+		if (!is_power_of_2(size)) {
+			pr_warn("LEON: invalid APB mask at %x\n", pnp);
+			continue;
+		}
+		regs[0] = cpu_to_be32(addr);
+		regs[1] = cpu_to_be32(size);
+		legacy_device(bus, id, freq, regs, 1);
+	}
+}
+
+void __init leon_legacy_amba_init(void)
+{
+	struct device_node *bus, *np;
+	unsigned int b, slot, bar;
+	u32 systemid;
+	int cpu_bus, ipi;
+
+	if (sparc_cpu_model != sparc_leon || !prom_leon_legacy)
+		return;
+	np = of_find_node_by_path("/ambapp0");
+	if (np) {
+		of_node_put(np);
+		return;
+	}
+
+	cpu_bus = legacy_scan_buses();
+	if (!legacy_clocks(cpu_bus))
+		panic("LEON: cannot determine legacy AMBA clocks");
+	for_each_of_allnodes(np)
+		if (np->phandle > legacy_phandle)
+			legacy_phandle = np->phandle;
+	bus = legacy_node(of_root, "ambapp0", "ambapp0");
+	legacy_property(bus, "device_type", "ambapp", sizeof("ambapp"));
+	legacy_u32(bus, "#address-cells", 1);
+	legacy_u32(bus, "#size-cells", 1);
+	legacy_u32(bus, "freq", legacy_buses[0].freq);
+	/* The last four words of the AHB PnP area contain the system ID. */
+	systemid = legacy_read(legacy_buses[0].area | LEON3_CONF_AREA |
+			       LEON3_AHB_SYSTEMID);
+	legacy_u32(bus, "systemid", systemid);
+	pr_info("LEON PnP: system ID %08x\n", systemid);
+
+	for (b = 0; b < legacy_bus_count; b++) {
+		u32 area = legacy_buses[b].area;
+		u32 freq = legacy_buses[b].freq;
+		u32 table = area | LEON3_CONF_AREA;
+
+		pr_info("LEON PnP: bus %08x clock %u\n", area, freq);
+		for (slot = 0; slot < LEGACY_AHB_SLOTS; slot++) {
+			u32 pnp = table + 0x800 + slot * 32;
+			u32 id = legacy_read(pnp), addr, size;
+			__be32 regs[8];
+			unsigned int count = 0;
+
+			if (!(id >> 24) || !((id >> 12) & 0xfff) ||
+			    legacy_is(id, GAISLER_AHB2AHB))
+				continue;
+			for (bar = 0; bar < 4; bar++) {
+				if (!legacy_bar(area, legacy_read(pnp + 16 + bar * 4),
+						&addr, &size))
+					continue;
+				regs[count * 2] = cpu_to_be32(addr);
+				regs[count * 2 + 1] = cpu_to_be32(size);
+				count++;
+			}
+			if (!count)
+				continue;
+			if (legacy_is(id, GAISLER_APBMST)) {
+				legacy_apb(bus, be32_to_cpu(regs[0]), freq);
+				continue;
+			}
+			legacy_device(bus, id, freq, regs, count);
+		}
+	}
+	if (!IS_ENABLED(CONFIG_SMP))
+		return;
+	/* IRQ15 is reserved for cross-calls; avoid all peripheral IRQs. */
+	for (ipi = 14; ipi > 0; ipi--)
+		if (!(legacy_irqs & BIT(ipi)))
+			break;
+	if (!ipi)
+		panic("LEON: no free legacy AMBA IPI interrupt");
+	legacy_u32(bus, "ipi_num", ipi);
+	pr_info("LEON PnP: selected IPI IRQ %d\n", ipi);
+}
diff --git a/arch/sparc/kernel/prom.h b/arch/sparc/kernel/prom.h
index 26a1cca7c761..60ecbd064a4f 100644
--- a/arch/sparc/kernel/prom.h
+++ b/arch/sparc/kernel/prom.h
@@ -6,6 +6,11 @@
 #include <asm/prom.h>
 
 void of_console_init(void);
+#ifdef CONFIG_SPARC_LEON
+void leon_legacy_amba_init(void);
+#else
+static inline void leon_legacy_amba_init(void) { }
+#endif
 
 extern unsigned int prom_early_allocated;
 
diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
index d258fd10db01..770d780bf830 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -154,6 +154,7 @@ static struct of_pdt_ops prom_sparc_ops __initdata = {
 void __init prom_build_devicetree(void)
 {
 	of_pdt_build_devicetree(prom_root_node, &prom_sparc_ops);
+	leon_legacy_amba_init();
 	of_console_init();
 
 	pr_info("PROM: Built device tree with %u bytes of memory.\n",
diff --git a/drivers/of/pdt.c b/drivers/of/pdt.c
index cb0cb374b21f..3c2d4684b7c4 100644
--- a/drivers/of/pdt.c
+++ b/drivers/of/pdt.c
@@ -24,10 +24,15 @@
 static struct of_pdt_ops *of_pdt_prom_ops __initdata;
 
 #if defined(CONFIG_SPARC)
-unsigned int of_pdt_unique_id __initdata;
+static unsigned int of_pdt_unique_id __initdata;
+
+unsigned int __init of_pdt_alloc_unique_id(void)
+{
+	return of_pdt_unique_id++;
+}
 
 #define of_pdt_incr_unique_id(p) do { \
-	(p)->unique_id = of_pdt_unique_id++; \
+	(p)->unique_id = of_pdt_alloc_unique_id(); \
 } while (0)
 
 static char * __init of_pdt_build_full_name(struct device_node *dp)
diff --git a/include/linux/of_pdt.h b/include/linux/of_pdt.h
index 89e4eb076a01..f89999ae68e5 100644
--- a/include/linux/of_pdt.h
+++ b/include/linux/of_pdt.h
@@ -32,6 +32,11 @@ struct of_pdt_ops {
 
 extern void *prom_early_alloc(unsigned long size);
 
+#ifdef CONFIG_SPARC
+/* Share the PROM node/property ID space with synthesized nodes. */
+unsigned int of_pdt_alloc_unique_id(void);
+#endif
+
 /* for building the device tree */
 extern void of_pdt_build_devicetree(phandle root_node, struct of_pdt_ops *ops);
 
-- 
2.43.0

