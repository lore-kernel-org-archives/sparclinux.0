Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD72847D93F
	for <sparclinux@vger.kernel.org>; Thu,  4 Jun 2026 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579199; cv=none; b=BVgbTsTVVa6cS6tJnSz1SL5tfBSAFROGo0ihEGWA2qBtj29FsGC9+3+72F9w0bfumB6HApiQH58m/eDR6HDfcRMPcP7kHN5klgAdUYiQG6YuEPEEDlToe5Ganv09l0g2FfiBXsrNXUV13B7nKqfcWgxfTbJyLWd6GDGvHyfTPac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579199; c=relaxed/simple;
	bh=9eVs5ZEWu5PvYIeNWvEPYnAIntZhT6pYVPj8oRQzPMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=trAl9JDA8vtEy2+PdDyZIdSJmjFfofyyc/5TL5KRCkfnHq16aMVT/fFdV7liwHctOCRN0/UOFo2J9hrLkT4o26ezr7DIL93cfLP4ZYjfFekWt2ONUm0/+cL8qL2xoC6ifoAl7kR365aLvtG86dTqp3Spsb4XHhx/en3mYKg1HUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpZ3l25S; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpZ3l25S"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b3637b90so6593015e9.3
        for <sparclinux@vger.kernel.org>; Thu, 04 Jun 2026 06:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780579193; x=1781183993; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaZcDuR1/GVoL4knmseDPUzz2J8S5y/tkogd7uxcn0M=;
        b=mpZ3l25SQenUDvGZoaVJnEVxe1HXEkFpGlBhLdeOckjQjtO/yH+NAuqA2SLfFJetF/
         ZyV2JCse2h7PtuwvqwcegCR6ZJxJHTSRACPG53tdpFoPHfPDja/mt2JhBUmQqkEOu57D
         CjV8usPRapvIKuOdiiOoj77OOl2JHfNJOOGZe5ba9Dp8rI58KP1ibBxgzWW0SYp+en+q
         Z1Nhq9YqFJWmXE0Mcb8LErX+EKAxZSz/8uMOzjPVwf+Xx5m4WkzCtXHIag9xR+50hHxZ
         zU3f7CLKizV6i6r0lqWN9tJUEPS/iMAK1dqqyzhsZT972JyNStQUEMtzRVjsTKxXbUfs
         pjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579193; x=1781183993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aaZcDuR1/GVoL4knmseDPUzz2J8S5y/tkogd7uxcn0M=;
        b=KwTLY5ipur2/+AoureDJ9sftce/G/iYNrbTkAhaxyIdt29dDDgD9RW4Ho5x3Gbxg2m
         2iszpqnfQ7f0i9BdGeN+kcJl8repvegfOrmlbddvHG9Vkvp5ezj6ZYE1pPZHLMEKMl+G
         pK43Sgm3I+Hl6b4a5vktnWNTzIyltkps+zmrhfVCqnH6d8sr4jGq7wps985XTBe2+Jxt
         B2h3mgG4FsQOwUrDe+tF9hdyVNEnPNgHL+Q6NAhSi7EOfr8PPs8kTaIuD8Ujcahgt2Kx
         0vhTaawpvUwqJ+V72YHewoOD+4JQnArHeu6vk32JsvLVesB7HLUHKfLyowYdZ52NbJTn
         fl2w==
X-Forwarded-Encrypted: i=1; AFNElJ/dWSBy9kD9zBLjBgam8VkxO6RrMmjQ+NLQS2x50D/GFI0S4KtBBjGLz6a7EyOoKcEJR1/7UwgyOJnQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3XgNqvkFczKwCoIUMWgBk6wbTu+mAidjpdXvPfc9UoxbUkO51
	vOJmo6R7gSrZCX9el8q+DeH5DWXNT+iGdD2MXze5mmYflNpURY+z2FUa
X-Gm-Gg: Acq92OFUFUHew/gIi03DDWmzyZPsJNHld5k5IvP1l6woT6cYVCMoC4R+nv+deRlBcLU
	Xj9KU4V5GRrkzDIeYSW8hJIthyiIu8VHKju9HrTiZvSP8/iIBxeEgwX+B56MU5M31gUwJ75vGrN
	pwgsO0hDlDxel2FZACvQkDk1ZA8ZCNQNs6dchlVzOkXljkmTP5lbyzjLs91MDaK2SREUAtwJ3Tn
	ma3FHWLhLKR09Fm1sqomFZTf+OwFUqgvbZ9eJtoXSh0w0FpnYW4niPrc6LzJQ7eRdHZq35XzFtz
	9w7/DXlhcs2DhM9tWkBdf+2uXu0221znVKkXcdG6ek+T4exwFsiGxKPQGsTzBWAOFQ61BG2+Fox
	yVas7z2SA3qcQPLWTzGjcFcTiNIQDOJ1rfbLiKaeiHIF4HVoK8j8gcUC7mj7/EOMaC3gjW6VN+j
	Gai2jUXPHUtMGlEFqMS7wCJa+8KHjLph4L
X-Received: by 2002:a05:600c:a09:b0:490:958f:2a5c with SMTP id 5b1f17b1804b1-490b5ed6375mr133235845e9.17.1780579192962;
        Thu, 04 Jun 2026 06:19:52 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7a52dacsm7715545e9.1.2026.06.04.06.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:19:52 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Thu, 04 Jun 2026 16:20:25 +0300
Subject: [PATCH v3 2/6] scsi: core: Move scsi_device_from_queue() to
 scsi_priv.h
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-remove-pktcdvd-references-v3-2-e2f06fb4eef4@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1518;
 i=iacobcatalin@gmail.com; h=from:subject:message-id;
 bh=9eVs5ZEWu5PvYIeNWvEPYnAIntZhT6pYVPj8oRQzPMQ=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhizF6vU3LqT3G94r9cqys+vtuZina/9q/t07UmFefy8un
 b3PXWxjRykLgxgXg6yYIsuLc9fbNuw5E3Avya4FZg4rE8gQBi5OAZiI+zSGf0qLXDQLS2uXPT03
 Kf2kWOsWYcVL01cdWXVcSm7NuVPX+4MZGWZd0Pu7+WuqS5Kxo3SX/azfa+t/Oh0x/i7Au8Di5/Q
 djEwA
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

scsi_device_from_queue() is only referenced in drivers/scsi so move its
prototype to drivers/scsi/scsi_priv.h.

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
 drivers/scsi/scsi_priv.h   | 1 +
 include/scsi/scsi_device.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 7a193cc04e5b..37e5601be2b8 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -102,6 +102,7 @@ void scsi_eh_done(struct scsi_cmnd *scmd);
 
 /* scsi_lib.c */
 extern void scsi_device_unbusy(struct scsi_device *sdev, struct scsi_cmnd *cmd);
+extern struct scsi_device *scsi_device_from_queue(struct request_queue *q);
 extern void scsi_queue_insert(struct scsi_cmnd *cmd,
 			      enum scsi_qc_status reason);
 extern void scsi_io_completion(struct scsi_cmnd *, unsigned int);
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 9c2a7bbe5891..9f716497a959 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -407,7 +407,6 @@ void scsi_attach_vpd(struct scsi_device *sdev);
 void scsi_cdl_check(struct scsi_device *sdev);
 int scsi_cdl_enable(struct scsi_device *sdev, bool enable);
 
-extern struct scsi_device *scsi_device_from_queue(struct request_queue *q);
 extern int __must_check scsi_device_get(struct scsi_device *);
 extern void scsi_device_put(struct scsi_device *);
 extern struct scsi_device *scsi_device_lookup(struct Scsi_Host *,

-- 
2.54.0

