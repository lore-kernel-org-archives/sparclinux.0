Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5AC1CF9C;
	Thu, 30 May 2024 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717095061; cv=none; b=qY7Y2eXrbmFNKGiyLnA6Djgq/mRfCTfDMM9gj9PZ4+ljUrf5bO8dyQJ98l7Kf6u0QNE+ih4+7uwB6RwT1kKZQb2LKiCtCdzHHnVXhbnbiPse8hAFyzCuA1zEvTtHmSh0SSl/XJ2PxX7n+cOJOforkSbzNsx9YjN+/TtBFHtAXy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717095061; c=relaxed/simple;
	bh=8fVaAaz0nBL6sCELN6DFm76IC/rF/vDW/oIDjSMgjxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HVNpji5Y1actyJZDQMnrNAsKTsNkDfraTbIwzazN9hRE6wICUJQBjjB/Vn5V4eyfbNuMGrBQcJCITKb0JA7mDX3hhWMxz9+YU3IwQlmv2vNiH/WprWW3Grp+lXM6tXp7ssVuUp0C0gqDAKoyf7HM9TWvQ+jBsWp7bVkTGlweSOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VM4ZTOZl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VM4ZTOZl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BC1C2BBFC;
	Thu, 30 May 2024 18:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717095061;
	bh=8fVaAaz0nBL6sCELN6DFm76IC/rF/vDW/oIDjSMgjxE=;
	h=From:To:Cc:Subject:Date:From;
	b=VM4ZTOZliO7rqBRbkRKSrNspz9A4brezzKYrjEbCmvv1rMH/PeMQrGAMpfz7YWJfQ
	 hfwctQLSslWg6Cw1MKuLnqmsD6OJYKYPdnIGWhyu3+1ev83icN2mkcwsY6508O0bE8
	 u/20l6gVqhMHC1Y+RNnifo3I+P+FX/qQ1W5YE3/EEu3qAcVCRZcXfmE+vuyEBepKYG
	 BpVCt5AQgm5OJm5b8ia6D8nFlaenWeCyawPmPyi2yyEaZVY8XwERfyZF52SGrG/wkG
	 oJUqA2Q6ERhMoHbQBIWkQLz8kxqLMNBZPXKv5+L1LBi4Iv0WLVLiQrYEj6W44k0XRo
	 zhVmNgDe1TqwQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Andreas Larsson <andreas@gaisler.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	sparclinux@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] of: WARN on using default root node #address-cells/#size-cells
Date: Thu, 30 May 2024 13:50:48 -0500
Message-ID: <20240530185049.2851617-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While OpenFirmware originally allowed default values of #address-cells
and #size-cells, FDT has long required explicit values. It's been a
warning in dtc for the root node since the beginning (2005) and for
any parent node since 2007. Of course, not all FDT uses dtc, but that
should be the majority by far. The various extracted OF devicetrees I
have dating back to the 1990s (various PowerMac, OLPC, PASemi Nemo)
all have explicit root node properties.

I have no idea what exists for Sparc, so disabling the warning for it.
If any other platforms hit the warning, then the warning can be
disabled for them.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Sparc folks, If anyone can dump DTs from some Sparc systems it would be
helpful.
---
 drivers/of/base.c | 2 ++
 drivers/of/fdt.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 61fff13bbee5..6930aa29fec1 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -96,6 +96,7 @@ int of_bus_n_addr_cells(struct device_node *np)
 			return cells;
 
 	/* No #address-cells property for the root node */
+	WARN_ONCE(!IS_ENABLED(CONFIG_SPARC), "Only listed platforms should rely on default '#address-cells'\n");
 	return OF_ROOT_NODE_ADDR_CELLS_DEFAULT;
 }
 
@@ -116,6 +117,7 @@ int of_bus_n_size_cells(struct device_node *np)
 			return cells;
 
 	/* No #size-cells property for the root node */
+	WARN_ONCE(!IS_ENABLED(CONFIG_SPARC), "Only listed platforms should rely on default '#size-cells'\n");
 	return OF_ROOT_NODE_SIZE_CELLS_DEFAULT;
 }
 
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index a8a04f27915b..568a3fca4c27 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -961,11 +961,13 @@ int __init early_init_dt_scan_root(void)
 	prop = of_get_flat_dt_prop(node, "#size-cells", NULL);
 	if (prop)
 		dt_root_size_cells = be32_to_cpup(prop);
+	WARN(!prop, "No '#size-cells' in root node\n");
 	pr_debug("dt_root_size_cells = %x\n", dt_root_size_cells);
 
 	prop = of_get_flat_dt_prop(node, "#address-cells", NULL);
 	if (prop)
 		dt_root_addr_cells = be32_to_cpup(prop);
+	WARN(!prop, "No '#address-cells' in root node\n");
 	pr_debug("dt_root_addr_cells = %x\n", dt_root_addr_cells);
 
 	return 0;
-- 
2.43.0

