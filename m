Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A06823AB87
	for <sparclinux@vger.kernel.org>; Wed,  6 May 2026 03:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778037515; cv=none; b=ZSJgHXDKICPTH9Ui9sBpwjIczoZrYkHPwV3uuAcuUPooLeR4EnLI0xn+jyy/wDBZ1+YeqcF4d/vtsszyVicG3sFWv8ENAQ6kWDD07+7lXIj/DknETIgQqY4kePQ7dN+Spnw/oawRRhKJFdER32OazFLHFr0a6+CavrOBzxCeLzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778037515; c=relaxed/simple;
	bh=oFW9BUX/4Mla/eO++X5alZMZn6T/UsyDMMSKbSQM2go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A5cBEifCAr4Y/pEPT+E+vQRXMlvDSQfzKXiDQMMWqM9ouO98WK16RUhfg3U8rcHEKb3WRWcupmnUHz4lF1paV2GpfMAQl88rXJNNoNb2n0QySFXoE7wGmKXirpnWthPWSWjnmUcV2otZCv5E+y2zOjrOGUdIoW5xKWWr9p+/N5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lj22HMkk; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lj22HMkk"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a871daa98fso35588115ad.1
        for <sparclinux@vger.kernel.org>; Tue, 05 May 2026 20:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778037514; x=1778642314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4yyAt6acVktoGggLFhfqeecMgUcwrLK8LmcMk1I0ocs=;
        b=lj22HMkk8HAPuLChDT2OyDzHD6YZ1xUn7WBYaFXU0XhL2tiw6P1tg72DCtOSMWMWyJ
         SPlLPZqRZnjm2IZWNRzxJCszId7YAwXs/20sezGakPSoclBQ2pl5moBXJOyVLQ/27Bwb
         sVdZnKSwogguNgugj6ZVBOqlRBG5mu4HmGiyq1kMfyS2DlTolerZT1r9Ev9h47LtEf7O
         j/HUBrNI4SjQdYKySofmqv1/AA7THgRHU+yZf+ckZn/9KFYczJ1ahM6OB8p8B9GnhowA
         aGYtIMAOFjIW7S5rIkfJnUfnw2Sxg0ppSDF8VVrjFJjyqEFuw/+MrvWSHBJipXxHAH4+
         3+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778037514; x=1778642314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yyAt6acVktoGggLFhfqeecMgUcwrLK8LmcMk1I0ocs=;
        b=YZnUKq9qB5UzZtcX/rKFT7NPy00RmhyAY44/ygD3EfKRFfbJmtgSnyQjU70UulJWjp
         karv5fYjeQDctH9ZI0FH2ohlTQK9wPpyGREkuauUkQdo0A9AwDZe49trtlyWY7sdcc6g
         VdFxY5o4AJUzr4ehGJ1bCivz5tLiLPPINR9z/tbfbouah2q5J12X1jdAQ3jPuK4r9AkH
         gxaT2qwDOCrWGleSxJ4e0TA5TQA8rh+d5iD4aa0MgEBHBXe6L1/8yE45Ah2BO8xFEo0X
         5HIsgRwS2Zda9Kn0M3c3VayLlL8KCreXJRyyZZbZ70/Evq/eIqmXV92BGm4tMPT6lJHx
         /GAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Xl5aMO40jd4Q1Y4WQE8GDXoLqFJIJfyFTmcd0AQSEwAsMWDh1TR4KzeJQfALdM/pvTTd6SJwXY106@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2OdTxbyoAyyAg7PUglmgQBd3b7gaMXZdISQRagOwXahbd2WjT
	6IgL9sVzLkLD9ie0YTN30X3u/ZgIatLMd6ecyf1hxBpBWK6J4SH/9t6wWqeFUxzx
X-Gm-Gg: AeBDievRYjq+L3Z4iyYv5yfADlLA79obnUuBj8gQrB20xYlDen6JnrhCG3//xjeK+tf
	GMVfrNW27qo4xdc9Ej5Ew31DTqTXXmOljmDZ/Hr3pWOzS5ZWum5MwT/H9mij99oLnMuy5wp6kEx
	w3D3ObL4e+fMyCXOelfzzRSin+7v05t2ICfPvEuGJvTh6yWLILCNCX68Rc3UmaGoVk1uRhOfrbD
	+vkFsAbPdZRC0M+zGlEk0uX3Bxez51WU7DGmEfY8bP6RgnBDLTJn+TiFOH1R/Saa/ghJ5dlwnb4
	zv1W3ccflRoqk+eQpJFSM/FAI4E5H53wZuorHokC05KkV1DzV6UKiEFlH6r5HPaTtgSVkbSqzpi
	0QNzjWDOI8hswmZUPrUXiTa/pcvRyCvgurm/OPyrRFtpomaQSu4QwQsZeCp6HiPQwxpXKCB2Rs8
	3nluLDej6VaK9PfOpAuDfwIDeFvxWQ4mZEdx9T+L47dwZy9oSqCiuKKqzHE8VT73lV8I1kuZpT1
	OxVhONiFZ0eOXlh42RZKhdL573KUfs744H2qYJs3ndjCEPuDtUj1ye5
X-Received: by 2002:a17:902:74c2:b0:2ba:7354:7299 with SMTP id d9443c01a7336-2ba79bdb06emr11493905ad.27.1778037513560;
        Tue, 05 May 2026 20:18:33 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7bf330a0sm7799985ad.31.2026.05.05.20.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 20:18:32 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-trace-kernel@vger.kernel.org (open list:UPROBES),
	sparclinux@vger.kernel.org (open list:SPARC + UltraSPARC (sparc/sparc64))
Subject: [PATCH] sparc64: uprobes: add missing break
Date: Tue,  5 May 2026 20:18:15 -0700
Message-ID: <20260506031815.779909-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Missing fallthrough causes failure with newer compilers:

arch/sparc/kernel/uprobes.c:284:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
  284 |         default:
      |         ^
arch/sparc/kernel/uprobes.c:284:2: note: insert 'break;' to avoid fall-through
  284 |         default:
      |         ^
      |         break;

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/sparc/kernel/uprobes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/kernel/uprobes.c b/arch/sparc/kernel/uprobes.c
index 305017bec164..c8cac64e9988 100644
--- a/arch/sparc/kernel/uprobes.c
+++ b/arch/sparc/kernel/uprobes.c
@@ -280,6 +280,7 @@ int arch_uprobe_exception_notify(struct notifier_block *self,
 	case DIE_SSTEP:
 		if (uprobe_post_sstep_notifier(args->regs))
 			ret = NOTIFY_STOP;
+		break;
 
 	default:
 		break;
-- 
2.54.0

