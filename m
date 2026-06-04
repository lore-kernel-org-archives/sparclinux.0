Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625DA47D95E
	for <sparclinux@vger.kernel.org>; Thu,  4 Jun 2026 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579198; cv=none; b=MwtomscGAA/4zwUnchaL5JoDUCRyrPK43ytmdv7qjW5lytdighwtOqEYqQPHBVUrmF2mhrhDTtCodn07q3tyWSmRHIU8MNnGqm2Weo+NP5jdFfH3VJh2zRtN1G3W5gXXgdumexvGGsJCeA6Sdd1fEv9v4unHtHWKZFu4OfugJMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579198; c=relaxed/simple;
	bh=G3Fe3cyAD+Z/AwWkMEKc9eOAUojByYfLbTKUe0Guf4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cj13HembxAM5PI71ZbxfP7LAT1oKPdk9YoYwuZSFQ4+3x38cveb0k1vqjQ33ZA+kx9MjZ6+WOhZHSAD3trrhCs2LlrjhSHy5u48jOGQmD439OfhcIK8fPYiNTEmXXBUzj6bS8le9qFoWMxQjZd+jNk/+HlEXJTnlmBkMFk6l+PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3m0C6HO; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3m0C6HO"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4602e2a0372so213773f8f.3
        for <sparclinux@vger.kernel.org>; Thu, 04 Jun 2026 06:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780579191; x=1781183991; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlT40SXHIDNPrvJ62EcqbeXntfzy9q6fgJPYwV1Z4jI=;
        b=J3m0C6HO7WZDSe0Ss8rjokQH6/fZB54wybzIDmklEpQH2oBZCqA+qRZr2qAd2xLEn6
         07NuHp+BaxOIRVNtNoPcaAih2qI5CilDwENEvlYD+2NJ5wJx0iH1g8Gb8yUyVly6VMx5
         fUlBqiGJg2LHpINrElR+Km/cgH5Sh8MSn5ELBxsxx2IfwlOqp/UXHZXtZ7HjCPNNJkIj
         yzi0cgGyNNJUYGW1fKcpcumgO/vxRaTnP22HKW9OtFY/FszTTWDCkuWa3XJV0+F9KXZU
         P6lfCSZXq1xJWnPK2GP7DNS8WCuibVopF+R0wUuFDC7cqT06gQfAwThr9n/5Urz6aNmz
         cN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579191; x=1781183991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KlT40SXHIDNPrvJ62EcqbeXntfzy9q6fgJPYwV1Z4jI=;
        b=LRY4SyPEd39MIiZoiDiT7OjxZ1LdcNmS68JIoxjejd177locznh2qE/tpbf4UMd5hs
         A/2q/Tif1mXeMdh4r6RN88R2gbgfDKaL3oF9FePosse2arqLzBotVs1VTHax6RNHZzIf
         UJnrf3a+a2kvFcjqZR/1GSSxo/CYfdMXnQrN4gvAAuqvRto9e2X/JNLb2Zz4UA7kmO1+
         hSC27NVknxVJtTzqHlJs59W4urWcjVMtb/3mWi2i4e2AP8FluQW3+J8fHSDFCag87/Q+
         OmX8dZC0kB0l8g/FS6G3x7K3yxlMSEZpbarCxJ8WKROs+Exyf7UsfSa3kHI7/QU9AlkH
         LmoA==
X-Forwarded-Encrypted: i=1; AFNElJ/uG4mKvY/HiKLQ+xCydqFn/M9d8ZAKblXu+bBUY0Y9ZHPxtstKUtBR5iv9bFQlkv3UsouuDoTwPE1J@vger.kernel.org
X-Gm-Message-State: AOJu0YyZi8xJ6EycpPit+DAe8BQkIw9ykDsP0IbPTQfM9i7DxT8Q4DBc
	jz9vnMC9HlJmZqWAGwS2kQkCOeJxdUl2Sm4f4MZAIY5meX0BOw3Zc/SO
X-Gm-Gg: Acq92OHIXTS6BYrww5xmNXIO/+BN4pKdODzEojSsh8UPEuzzgFGXv89YL5EqotQSMI6
	7xeUrc0p6Z0r1zDlCpyfC0yXb85j5zWq3iNscj56CK2uTRWCIIdtQtE2L6Yjbn0RAiPCQgu+RnJ
	QYqnuTRgvhLjYVpGfqva5Nbt1fdOXJrg0PGFK8wCmAwfhhUkFQg5ta5JM3c4yDavSVmweHQ+uX4
	xvdBmyi6W6sQC9ZuRP4JN3lInDHVAFlxvm35xvrm8O930BcOZh5iCtzE0eMJBTOibCy+Y84cOJ8
	900bkEFo5Cq460iqioJxq0anyjRdnH7EPTCB5iFzO/FGBa4vx+QBRePA1lXaohztz9UA1K1BJUN
	yAuLLztJ1PQxPdduNnQeeNE+OlT5fYYpdzcnneoYtkGuhuiMPbTpycyPh2kYj6JhpT4KcYz1KXB
	ab9P2RmW85S/BKNPZM+JqSTFgpi5eytMT2aS1YNVD7Sy4=
X-Received: by 2002:a05:6000:46d4:b0:460:194d:8df0 with SMTP id ffacd0b85a97d-460216bdec9mr8550288f8f.4.1780579190589;
        Thu, 04 Jun 2026 06:19:50 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4004sm16338165f8f.9.2026.06.04.06.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:19:50 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Thu, 04 Jun 2026 16:20:24 +0300
Subject: [PATCH v3 1/6] scsi: core: Remove remaining reference to the
 pktcdvd driver
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-remove-pktcdvd-references-v3-1-e2f06fb4eef4@gmail.com>
References: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
In-Reply-To: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Jens Axboe <axboe@kernel.dk>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org, 
 Catalin Iacob <iacobcatalin@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=966; i=iacobcatalin@gmail.com;
 h=from:subject:message-id; bh=G3Fe3cyAD+Z/AwWkMEKc9eOAUojByYfLbTKUe0Guf4M=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhizF6vVir19FLgtlrTKTWrz/dN+tx8/b3paudEw33v5iw
 bXHKZO0O0pZGMS4GGTFFFlenLvetmHPmYB7SXYtMHNYmUCGMHBxCsBEaq4y/HfOULHXvpc6y/do
 pN6xXynGrT7RcucdVm8Sqkl1P7TlwSJGhu1yi5fZJc4NvBrrpdCoPv3b3qyyTN7Z02ctmdxRfT/
 8LCsA
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind an
export that is now dead code. Remove it.

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
 drivers/scsi/scsi_lib.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 85eef401925a..b67f0dc79499 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2224,14 +2224,6 @@ struct scsi_device *scsi_device_from_queue(struct request_queue *q)
 
 	return sdev;
 }
-/*
- * pktcdvd should have been integrated into the SCSI layers, but for historical
- * reasons like the old IDE driver it isn't.  This export allows it to safely
- * probe if a given device is a SCSI one and only attach to that.
- */
-#ifdef CONFIG_CDROM_PKTCDVD_MODULE
-EXPORT_SYMBOL_GPL(scsi_device_from_queue);
-#endif
 
 /**
  * scsi_block_requests - Utility function used by low-level drivers to prevent

-- 
2.54.0

