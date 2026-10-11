Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C2745FFA4
	for <sparclinux@vger.kernel.org>; Sun, 11 Oct 2026 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791747768; cv=none; b=Yu3jaK5lYFLch9dS/TmXWwdJJebRA0fos6RE6RXT0nX4qbKEIEJwDrI5IMixji54+D6FqaTT+z4lrylnpvJRIUiyqUjU9q7M/jFqKoDdFzZxL9x+6qounoU7ukiZfK0HUt2ZT9979zlg7jUJGGeR2t88eJZXsxx6YBXqwsUbmx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791747768; c=relaxed/simple;
	bh=duwhY6Tg9tFTL1XOXarBBsKmWEqDi2jVDN3dH3CmJ4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mVvLAyH+9MqtM0yYjXf/HPWFWl/ol1CK2WFJta0KD5F/Is5dIqgcRtASlno2Fs4jz5bo5zJzeInDvVYjuSboLsBuHyYUqWnajvBALWHh6WpFFnPGTvsUenLkqohw1KanQxqfVZHVKuxXqoRDLKXwOAGY5D9XlOL/aEEedtMMXGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h50CcZEV; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h50CcZEV"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2e4df2e26fso166733966b.2
        for <sparclinux@vger.kernel.org>; Sun, 11 Oct 2026 12:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791747760; x=1792352560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P57ESlsV9SvC7jAyaXBqTiZZ0EEN4K1kw22rWzkVaQw=;
        b=h50CcZEVKgMXP+VS13OBpeU9Qm+RLcRIl957khv4EIB90D/wHkS3s23xF6jwkK/gOr
         nu8PZbvUu8eHVE/u3Jzww8RN2G0GTDREMEamlkoPW+2Cfm9V2JlGIVTU3eBYiAB9c4rS
         V8qnLW2I2wy/7gZQhoB6RP3MClVrQ/tauQlx8poQbxfNkXYAVJHmc8fNwGRrQt5tXhTf
         XcDNRViDF4fvuZfT9tPR9nIHtiP1hBQ8Et2AvcfxiSOGc3PznsoIzO65fIPXpV6msB8M
         c8Ok3O55SpKc0/sFZfDPug60j6bvzaz+6l4fWLcZnIKDiwLGYZQZUNP5PV9xlOts8G2z
         DPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791747760; x=1792352560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P57ESlsV9SvC7jAyaXBqTiZZ0EEN4K1kw22rWzkVaQw=;
        b=1Sz/IdQLcgV0fvHFaPY5iMj6wTFPx/0IwSotNA+0lKFunskriDE3uOZWZMvrMmA9bP
         oPB482S0DqJvhgcUHaeL6Q9XWHgFTWwG+3jOkhRvRw/1axKA5tFBLluLV1ZB/6FR8a9j
         zR/iL78bmj4KGiSYFkBJQ9ThlRonxwCVJMuIfgyei44+4B37kz0Jxt+X+W9HaHARKL7a
         sI61tdHZc870iLlRd4K/GUxokEMwuyMgTSxQbCJrcF8XF4t7aD0jWafsZxCw+6YtTDN9
         JWnw7JPS0uYJOVp4P8z9+j3TNe+BfuttvC0yKf4CXk1Qk3YjSDMf37T0BxdEU9sMHjkD
         aYBw==
X-Forwarded-Encrypted: i=1; AKwUvBzO+icQQDAmRJsuuYIh6ui4xNTQnjdXGNqfueiuhMykpco7O2557S1VzcaAQlFpo5ePWtPV4q46t/+o@vger.kernel.org
X-Gm-Message-State: AFq9FYJc0iCD0i9Xdw6C10X2T381zQpZ7bXCIEX4+mj6rMS7kAVqlWl8
	1PdisriQEHOwvFRN79z3/SqDWkhHj65u3Wk01K1dD2+OZbU/QhWS8kTD
X-Gm-Gg: AYBFou3YwemIaPQSwcStW/JJR+zgpzZqP04byUeGQ7Dl0MJwpm4AucUVgMHDb4jy7ly
	2NQv1XxYASJHBxuv2tt6F+A6o6c3LYLI+adRO10FZIDXefE62A1B0jYbAJH8K9Burh8kjfEGakC
	o5V18oxYWr7TRJ8FB5Jtx5HUf/z8wM08piI1yi85x6h4uCOf5Yh6MpOf3NRU6qFeOhsugLAiM43
	qWv0jawfvACS8+GIbN/Fav3AJtk8o+OxVMBK3QmJbUAW8sU67K0PtBIdD9aAQZRaHDdC5EG74mG
	ogQ0wSzzbqG5Fc4gGbdTDNEE6unirLcjOuRfrsVbdIsxRbugbzK6TdcpXF9iSkbiqeYteLBVzCr
	hiHbv7e4P9f1g/kle6MC8n+jVIk/KPUKMbJCE3vI42r34YNQLz33yduJjFjdMT6T01HaFmRQVxM
	UlPFm6HFgmU7VxTIRzeBTAokfWAq28NwpPVf7AU6hLQFo1DeRt3PRd0eGhgfjFnWP09kVnmDPaS
	vjLlx0PzNq5Oj9m2xX6xGkYEb7+DYDgbajDdf3e
X-Received: by 2002:a17:907:968f:b0:c31:8c48:e18b with SMTP id a640c23a62f3a-c31a9afb3b6mr819944966b.14.1791747760150;
        Sun, 11 Oct 2026 12:42:40 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a74bcbsm387266166b.38.2026.10.11.12.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:42:38 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: pavan.chebbi@broadcom.com
Cc: andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH net-next v3] tg3: normalize inherited BCM5718 register byte order
Date: Sun, 11 Oct 2026 21:41:58 +0200
Message-ID: <20261011194228.981141-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firmware can leave BCM5718 vendor registers byte-swapped while standard
PCI fields retain normal byte order. Detect this from the host-control
revision marker, byte-swap bit and swapped product ID, without matching
a platform model or PCI subsystem. Prefer the normal revision marker
so already-normal controllers do not enter the normalization path.

Hardware swapping can accommodate big-endian register accesses, but tg3
already initializes misc_host_ctrl with WORD_SWAP set and BYTE_SWAP clear
on both little- and big-endian builds. Its normal MMIO path uses
readl()/writel(); on SPARC64 these use little-endian accesses. Restore
that existing register mode rather than choosing a mode based on host
endianness. The swab32() on the initial write compensates for the device's
inherited state; subsequent accesses use the normal driver path.

DMA byte ordering is controlled separately through GRC_MODE. Leave those
settings, including the __BIG_ENDIAN handling for non-frame data,
unchanged. Check both register readbacks and keep this in probe so PCI
access or validation failures can abort initialization.

Limit detection to BCM5718, whose register layout and inherited state
were checked on M3000 hardware. Other controller families retain their
existing initialization path.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
Changes since v2:
- Expand the commit message in response to Andrew Lunn's review: explain
  the existing register mode on both host endiannesses, the purpose of
  the initial swab32(), and the separate big-endian DMA configuration.
- No code changes; the diff is identical to the tested v2.

Changes since v1:
- Detect BCM5718 register state without OF model or subsystem matching.
- Prefer the normal revision marker and retain checked PCI accesses and
  product-ID/readback validation. Use dev_dbg() for successful correction.

The unchanged v2 code was tested on big-endian SPARC64 with M3000 v2:
normalization at boot on all four ports, rebind without further
normalization, three active-link cycles and a 16 MiB bidirectional
transfer with matching SHA-256. Kernel taint remained zero. Standalone
SPARC and x86-64 CONFIG_OF=n driver builds passed; no little-endian
hardware runtime test was performed.

 drivers/net/ethernet/broadcom/tg3.c | 72 ++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 73a4b569b03e..ef0f6e5f6440 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -16248,6 +16248,65 @@ static bool tg3_10_100_only_device(struct tg3 *tp,
 	return false;
 }
 
+static int tg3_fw_byteorder(struct tg3 *tp, u32 *misc_ctrl_reg)
+{
+	struct pci_dev *pdev = tp->pdev;
+	u32 prodid, expected_prodid, normalized, readback;
+	int reg, err;
+
+	/* Prefer the normal revision marker before testing the swapped state. */
+	if (pdev->device != TG3PCI_DEVICE_TIGON3_5718 ||
+	    (*misc_ctrl_reg >> 28) == ASIC_REV_USE_PROD_ID_REG ||
+	    (swab32(*misc_ctrl_reg) >> 28) != ASIC_REV_USE_PROD_ID_REG ||
+	    !(swab32(*misc_ctrl_reg) & MISC_HOST_CTRL_BYTE_SWAP))
+		return 0;
+
+	/* Standard PCI fields are normal; verify the swapped vendor registers. */
+	reg = TG3PCI_GEN2_PRODID_ASICREV;
+	err = pci_read_config_dword(pdev, reg, &prodid);
+	if (err)
+		goto config_error;
+	expected_prodid = swab32(prodid);
+	if ((expected_prodid >> 12) != ASIC_REV_5717) {
+		dev_err(&pdev->dev, "unexpected swapped BCM5718 product ID %08x\n",
+			prodid);
+		return -ENODEV;
+	}
+
+	normalized = (swab32(*misc_ctrl_reg) & MISC_HOST_CTRL_CHIPREV) |
+		     tp->misc_host_ctrl;
+	reg = TG3PCI_MISC_HOST_CTRL;
+	err = pci_write_config_dword(pdev, reg, swab32(normalized));
+	if (err)
+		goto config_error;
+	err = pci_read_config_dword(pdev, reg, &readback);
+	if (err)
+		goto config_error;
+	if (readback != normalized) {
+		dev_err(&pdev->dev, "BCM5718 host-control readback mismatch %08x\n",
+			readback);
+		return -EIO;
+	}
+
+	reg = TG3PCI_GEN2_PRODID_ASICREV;
+	err = pci_read_config_dword(pdev, reg, &prodid);
+	if (err)
+		goto config_error;
+	if (prodid != expected_prodid) {
+		dev_err(&pdev->dev, "BCM5718 product-ID readback mismatch %08x\n",
+			prodid);
+		return -EIO;
+	}
+	*misc_ctrl_reg = readback;
+	dev_dbg(&pdev->dev, "normalized firmware register byte order\n");
+	return 0;
+
+config_error:
+	dev_err(&pdev->dev, "BCM5718 PCI config access at %#x failed (%d)\n",
+		reg, err);
+	return pcibios_err_to_errno(err);
+}
+
 static int tg3_get_invariants(struct tg3 *tp, const struct pci_device_id *ent)
 {
 	u32 misc_ctrl_reg;
@@ -16272,8 +16331,17 @@ static int tg3_get_invariants(struct tg3 *tp, const struct pci_device_id *ent)
 	 * sure that indirect register accesses are enabled before
 	 * the first operation.
 	 */
-	pci_read_config_dword(tp->pdev, TG3PCI_MISC_HOST_CTRL,
-			      &misc_ctrl_reg);
+	err = pci_read_config_dword(tp->pdev, TG3PCI_MISC_HOST_CTRL,
+				    &misc_ctrl_reg);
+	if (err && tp->pdev->device == TG3PCI_DEVICE_TIGON3_5718) {
+		dev_err(&tp->pdev->dev, "PCI host-control read failed (%d)\n",
+			err);
+		return pcibios_err_to_errno(err);
+	}
+	err = tg3_fw_byteorder(tp, &misc_ctrl_reg);
+	if (err)
+		return err;
+
 	tp->misc_host_ctrl |= (misc_ctrl_reg &
 			       MISC_HOST_CTRL_CHIPREV);
 	pci_write_config_dword(tp->pdev, TG3PCI_MISC_HOST_CTRL,

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.43.0

