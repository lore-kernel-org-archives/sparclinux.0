Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A057D15A848;
	Mon, 21 Jul 2025 04:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753070545; cv=none; b=cqFoqdmjSJZiMrIs0f8Gu8/9eNOcFhxfqjq0illWE2MXdTuSDrRPB3uijV+ayKPOlTiPmcRelLTFyAJSZ2N/edlq2S4GjdzniYC2W2vBEvN7v0J89mXstxN5Agbt0hm55CZK9Ev8GzoBYdYeZeBiz7U2dEPZhBWiH3OUMOL3/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753070545; c=relaxed/simple;
	bh=btpYYUIbFBEp+ktnsXZqqxkPFTnpTlE8q8VnCvyDrII=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=tULzA9XKWJaZurZP3rdDK9Ots6k4F3s1RSfJXkLMmpM2i/Gh7TFaLilvatjj6kC6VaP9rwZMUfiLtf5S6cf/9oehnb1s2hn+YExB7NE24hWZZwZQuJ6rXSJgrQks380sL//aR+nI7hBkWaGVdTn6COwUyZHTRT/RggE0Lb6AR6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fSCsDeW6; arc=none smtp.client-ip=43.163.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fSCsDeW6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1753070227; bh=sVN/AzOJY5mxP5MAX87gxt0LYQMkeR9l094mDeUFjL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fSCsDeW6IFaPxwpIgNQWIyFMY1gxIlE06HTDKgaCWabgAFkPdmUm2K0/NvG9dHU1N
	 w+GxeKt5WuwH0TCjyVCtgq1WzCtUWdhgM4esErGCV3Z87RxKnvMIJV+l0JxJ/SY7HO
	 e9fWCORfT8SKmiC03OaDp6gaRdue9ALnjdQN/2Vw=
Received: from VM-222-126-tencentos.localdomain ([14.116.239.37])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id E45ADA05; Mon, 21 Jul 2025 11:57:05 +0800
X-QQ-mid: xmsmtpt1753070225trb1aq2d2
Message-ID: <tencent_60B856B729FE434916EF57CDF5286D69A008@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JuabrtwEbzxQ/HVLD3ZsVD5dKnQlX7r66XxAWjbrGcYcT/FuZ7mn
	 FSm8+cK0sJlrzJuWSoAfMzMiLRZH7IVN0I29tuDktfJy/x3ZWP/ncuO7iLcIHy0ejcLzpVN2/K2x
	 fnV+OBcf/ndJFS4vyg33LPLTfnWmf5WDnXjBtsIES/5Ey02GyLFL0N3d8L1GfrprFy5e0lRZPbv+
	 pPUHIu2C09U2r5JI7dY3z2Da4eyQpzl7bVXJNw/YxKa0mEqpIe5KiUqAj34SsXBH1TAUSFSyLcyh
	 eFI20xXx+w2u6UH37wnhvqTHFJokkiugcnjJxmyaCjhFRJx7oFNDZ/MCKk5nC7BXiZS3NZiKQhJQ
	 BHK/nxE3bLsp5vF3iLw0/NpZyMp+bAPAjQ40cij2W/GWeHUUos+A0Quwu6zzEijUIq7C/SMXlozH
	 9gFY12I+IUKI/31jPc6oEfTxFXECHpx9uNxQsOaW9cgvQxcOT9SOIcOgTpenNcGASnDcQ2jbOTC4
	 zrCycx8phXC9uXI6MbZGq7/k5IbP4htFAZqbtkcRvDFvJFJZHcL3GLu52NII5gw0Lfd3UO+7EAhx
	 lqJ2n2VwePqdoLKE6Ygz+PFY4Xx3SiqrPyrvm1NdSTo/MsSmnCa5pGwDH6QNjts9DpK3Dvhfo8yg
	 UkvflGpkcpNb1rGDlS/nV9Bi8xW9cczmQ+faLNtl0d+8Viz+UfDESNi/m7m52AuGm4AwYZByVyXO
	 6T4DNprX/bLgUOoGFS0/0DOghOBz6TBn7XOijpB/wHxii/VTBlhtJrQKmp4HT/uxRNTBCQ552sm8
	 LuRHHh1h2dYdXuqkOWivKUBwIkPBsECBgzkqG4moi/wA6IFhfWRivxTr+0MVIjgCcsqGBMU6MPWP
	 OtX2uIsK+CS8DYC605gCD7KZ1MsajU88PWfvMVXWhcZdXur3bH05yO8k4EiS9SexYL9tdZc3MLV1
	 hz0+XgnYfecfKtuzfdSgcKftbZh8wjI/XFmm9nabpcQ86bm3W+10w5Uo7UsMgLP10HDjeO3v2FHH
	 cnOW0tOgRygTqVi0zEwKDeOw/PHpCy78MKC74Mjs9ycFE5CnJ/pcLVpqtBnkWgRHUioMeE8w==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: jackysliu <1972843537@qq.com>
To: markus.elfring@web.de
Cc: 1972843537@qq.com,
	andreas@gaisler.com,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH v2] arch: fix resource leak in jbusmc_probe()
Date: Mon, 21 Jul 2025 11:57:03 +0800
X-OQ-MSGID: <20250721035703.129102-1-1972843537@qq.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cc7db82b-0337-4342-aeaf-ec6376cbcc74@web.de>
References: <cc7db82b-0337-4342-aeaf-ec6376cbcc74@web.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Siyang Liu <1972843537@qq.com>

In the jbusmc_probe function, the device node mem_node fetched
via of_find_node_by_path("/memory") is not properly freed
on all code paths.
This can lead to leakage of device node reference counts,
which may result in kernel resources not being released.

This issue was detected by rule based static tools
developed by Tencent.

Signed-off-by: Siyang Liu <1972843537@qq.com>
---
 arch/sparc/kernel/chmc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/chmc.c b/arch/sparc/kernel/chmc.c
index d4c74d6b2e1b..fd20e4ee0971 100644
--- a/arch/sparc/kernel/chmc.c
+++ b/arch/sparc/kernel/chmc.c
@@ -412,7 +412,7 @@ static int jbusmc_probe(struct platform_device *op)
 	mem_regs = of_get_property(mem_node, "reg", &len);
 	if (!mem_regs) {
 		printk(KERN_ERR PFX "Cannot get reg property of /memory node.\n");
-		goto out;
+		goto out_put;
 	}
 	num_mem_regs = len / sizeof(*mem_regs);
 
@@ -420,7 +420,7 @@ static int jbusmc_probe(struct platform_device *op)
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (!p) {
 		printk(KERN_ERR PFX "Cannot allocate struct jbusmc.\n");
-		goto out;
+		goto out_put;
 	}
 
 	INIT_LIST_HEAD(&p->list);
@@ -473,6 +473,10 @@ static int jbusmc_probe(struct platform_device *op)
 
 	err = 0;
 
+out_put:
+	of_node_put(mem_node);
+	goto out;
+
 out:
 	return err;
 
@@ -481,7 +485,7 @@ static int jbusmc_probe(struct platform_device *op)
 
 out_free:
 	kfree(p);
-	goto out;
+	goto out_put;
 }
 
 /* Does BANK decode PHYS_ADDR? */
-- 
2.43.5

