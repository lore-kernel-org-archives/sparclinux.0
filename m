Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1AD25B087
	for <sparclinux@vger.kernel.org>; Tue,  8 Sep 2026 05:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788846589; cv=none; b=Rnto1ATDIG4/0KVYGUGt6VcILGmSqRO4WV6GhgwSTDSPp39zf0bxbbtichmAWvp13gTsCxaq89yobmchmE2fiErclDaEyz4i8ze89uqbI0gwwsWJ2/pUWh+VM4mzxfxpjoZqm0tqXpjGZjNOif/e8peTYfoWStXPumYzOBMfChk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788846589; c=relaxed/simple;
	bh=UErhiAlzr8WjMoBRENwt/AEHPbueyU1pd5tdq23Ux3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQhAeyl/nKGcvGR+oQSonyqEvgg0nAReQVZyr/JzCmpsKY/Z8aNAMCo3I7zibUqoxMcLxncWknUi/1BMAcp1gNcnewdU7NkPn4C41FSr5Qg79uw1nzPs5KElM9yiF+1F/Y/Kjd6IaQ8wmza/jOQ3rmdrJWV7GBtW1dEwlOZB47M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J15fXLeF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J15fXLeF"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso2817464b3a.1
        for <sparclinux@vger.kernel.org>; Mon, 07 Sep 2026 22:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788846587; x=1789451387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/3KV6RuBnnb3kSlImB7scYqnTaYm6MjcG3VOHCy4kfM=;
        b=J15fXLeFVUS1CUuUZ7W+Mo/WIXCmF+aELwslfsuCrGJDc2gTNfcReGITZmVVDPs0FC
         kENOlOT8Wcdp+QO54GuJ5ct1jStvpe1Q81hXPfzNrbaDbUTdB3qP0JZmqXTMFgKlO4c3
         bqUAcNqcxoh+qzZTeirh89hAY2kcskVCUKHEQC5YAMWM97uFXViXBXml8OMOrWmDrTSs
         ssA1MA1G7kCvlACsFipBdj7njMx5GCVh6AFDqiN+rxLDQ3/3Zrh2mha7byX+ob0E9bUS
         1B07FUic/kSkVgw0soVn8N2jESUEj4dZGtk7kfRx473P6+n9dzb2ybWd0wxBxEPOiavb
         y9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788846587; x=1789451387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/3KV6RuBnnb3kSlImB7scYqnTaYm6MjcG3VOHCy4kfM=;
        b=A5RtRTMOoMTFRfOxtxN+0D19edIM2v/gVIGBqKPKp0q/2C408myALD8+5FdRXQPPvU
         7yJSo4vnhT6Nlj/yS5Oua5vz35+uhpL+/0bTDZZwvfvdy/CHmWfU7u97Z7q9BSbZVmzq
         dsuoiW/05Ctzaed2poIgseOyYYZd3iuLaowGvjuDwe6em2Ia747HsHHsHGYdg7hbLVWc
         kToQKlKkECHP4SLlX0fL9O94siAXe6Es1WM9VCVq8gNjw25ftIEPuitMDFf5buLU9RPb
         bDFxu9ext8FurxeeyyXOdmt7vDn2dFB3uEFKr4ys5/tbBvUwEo+4Xvcp+WujDQkguqCN
         J0iQ==
X-Forwarded-Encrypted: i=1; AKwUvBwIVjsZzJUjaWrBh06keAV5XMzp9Zpg+9W8YWDb1TbeBdS/LRiRqYNsrilw8Ti72pEBKGXeQJkcqYYQ@vger.kernel.org
X-Gm-Message-State: AFuF++mgw7BHtLgOWuhaupjL5VH+jebu5gKnoUqqRCeviA6mtSoIT3xg
	wXgB3TNIDA0H3MNwKPD+Y39gJaNDEYKUTQ4V3j3xXteg+cbr2BlbVEWS
X-Gm-Gg: AYBFou0cWNwEb+emHnwOesxnyjed5JC02x4+J7rMvZXJroNukC7IwyXs0ImLy9oiZFU
	hFqIIWVpSJQVryDk2reL8EWg+KVzjth2vOYNWXpw2VY8S3OHAQQe6ZdXl8TpY2JN3t2oTQfVSKu
	nseUQENc+76R7aJytbjeTr+9OJBgsL8TBEWezwxoFdMQ+2AP7T0dBHW83yoI8GBDl08LJ+3L/1G
	LaG7dMSxKboj3LBKaCb+7dImSrdsydLZ7D9e/uRE0/fQ3SmjbN+q1v8WMxqsv/1BQZyO6TRjghB
	m+zgi1B8Z8giAz+wH0pa9Pb1lvB4TysYInkJ2MlQx6sXqZvnEQr22z41KiIhduWzoAZP1r/cr+r
	Fgy6rXKeLYb7whA2d9gI9vyH/p35E4UWHsasgDK1Jujc6PQVJseOZqxyd26sqAUpnkrp12bFlPu
	lk/o67WIpDS+YK6/OcT0zjgyaZIs9+POGy0UDL6DV2R1LW8TskKwnjqhnATIFtfBDrPm904MmUo
	/E5P5AgGUdg9g==
X-Received: by 2002:a05:6a21:9204:b0:3d1:60d3:99f8 with SMTP id adf61e73a8af0-3da39b7183emr44883342637.5.1788846587447;
        Mon, 07 Sep 2026 22:49:47 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-334fbd5e6f6sm25690109eec.23.2026.09.07.22.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:49:47 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Russell King <linux@armlinux.org.uk>,
	Puranjay Mohan <puranjay@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH bpf-next v4 5/7] sparc: net: fix typo "evalute" in comment
Date: Tue,  8 Sep 2026 11:18:51 +0530
Message-ID: <20260908054853.13820-6-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260908054853.13820-1-hemanth.selam@gmail.com>
References: <20260908054853.13820-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "evalute" to "evaluate", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Only touches comments, no
code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/sparc/net/bpf_jit_asm_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/net/bpf_jit_asm_32.S b/arch/sparc/net/bpf_jit_asm_32.S
index a2e28e0464a3..81430f065ac9 100644
--- a/arch/sparc/net/bpf_jit_asm_32.S
+++ b/arch/sparc/net/bpf_jit_asm_32.S
@@ -195,7 +195,7 @@ bpf_error:
 	/* Make the JIT program return zero.  The JIT epilogue
 	 * stores away the original %o7 into r_saved_O7.  The
 	 * normal leaf function return is to use "retl" which
-	 * would evalute to "jmpl %o7 + 8, %g0" but we want to
+	 * would evaluate to "jmpl %o7 + 8, %g0" but we want to
 	 * use the saved value thus the sequence you see here.
 	 */
 	jmpl	r_saved_O7 + 8, %g0
-- 
2.48.1

