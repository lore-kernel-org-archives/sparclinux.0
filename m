Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D132F3C4544;
	Sat,  1 Aug 2026 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785611453; cv=none; b=uz4tY4HLJMGTcmmMzrBfMlFesweMqCUlENzVDMslV/brsgsQfoTQvKMMUEIi0JnDeGMO3YZApkuzsERbit6OpUzK4pCwbiQJSlUZ6UR9K7qYk0zuiAK9SRi35V/W3wJ/zw8fB6NbDi4TcZS8DPOeLaO3VA9wBZtSenJPbJRIOK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785611453; c=relaxed/simple;
	bh=NWFT+Ag/ZHwA1ayllRYI+8H7laTtSZil0XgSxtsiIxA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H76z+FBVnnCRh0rbl8bADO1aTmCMomL8LvlDfaO9o83ZjTCDkL5+N98ifBiY+CrI+dTL/qRNIgsL+qPzIh8YuCdCpqEtO6Tnn5bDuPvTnCIGTy6rRFLGe2o8im4JWcOHwOX3/EYGmY3/uuzQ6wvTP+S7d64WzlJ4BhBZNWfFtpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=JS6mohkW; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="JS6mohkW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zndR+/IrwYAnFwh8an3Nuw7RqNmw3xtqNyrLVv7BjFg=;
  b=JS6mohkWgErOAmgo8cz89ZffrqmMkkao7c/xjFD8LwXUCymv8plNiVbM
   nvOPoXUE0vViNsJiYd+85l8grdWSDZ5hdujEnmhAnDsPf6nEtkERpolTp
   hTl4MnGParA34/CM17E8wK5wIVuCCd6wnVraUG3/MwRZx/SYDrsO1+zyh
   I=;
X-CSE-ConnectionGUID: FGBl7buPQ1WZgKz5H+Avdg==
X-CSE-MsgGUID: r2N096gdTVCI3xAFyCjjrQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.25,198,1779141600"; 
   d="scan'208";a="288769015"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2026 21:10:09 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Alexei Starovoitov <ast@kernel.org>
Cc: kernel-janitors@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	bpf@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/bpf_jit: SPARC: drop unneeded semicolon
Date: Sat,  1 Aug 2026 21:09:59 +0200
Message-Id: <20260801191002.1383835-13-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a function-like macro expands to an expression, that expression
doesn't need a semicolon after it.  All uses have been verified to
have their own semicolons.

This was found using the following Coccinelle semantic patch:

@r@
identifier i : script:ocaml() { String.lowercase_ascii i = i };
expression e;
@@

*#define i(...) e;

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/sparc/net/bpf_jit_comp_32.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
index bda2dbd3f..632002681 100644
--- a/arch/sparc/net/bpf_jit_comp_32.c
+++ b/arch/sparc/net/bpf_jit_comp_32.c
@@ -262,13 +262,13 @@ do {	*prog++ = BR_OPC | WDISP22(OFF);		\
 	*prog++ = (SUBCC | RS1(R1) | RS2(R2) | RD(G0))
 
 #define emit_cmpi(R1, IMM) \
-	*prog++ = (SUBCC | IMMED | RS1(R1) | S13(IMM) | RD(G0));
+	*prog++ = (SUBCC | IMMED | RS1(R1) | S13(IMM) | RD(G0))
 
 #define emit_btst(R1, R2) \
 	*prog++ = (ANDCC | RS1(R1) | RS2(R2) | RD(G0))
 
 #define emit_btsti(R1, IMM) \
-	*prog++ = (ANDCC | IMMED | RS1(R1) | S13(IMM) | RD(G0));
+	*prog++ = (ANDCC | IMMED | RS1(R1) | S13(IMM) | RD(G0))
 
 #define emit_sub(R1, R2, R3) \
 	*prog++ = (SUB | RS1(R1) | RS2(R2) | RD(R3))

