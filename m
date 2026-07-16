Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D5242BE92
	for <sparclinux@vger.kernel.org>; Thu, 16 Jul 2026 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214689; cv=none; b=lA6u4mk+PQAFrcTxTrtoFyyF8A9qgq0fig7nv95VBF4YwwHKwRcQuJJBX4H7DiCVp27Ktwn9S+VbcqaTsIP41cz+4+SKaBZ+z/Ja3Ty745yM3Nkp0eBr5ldZK+FdZpf9yD43BYC0pUxIYXJC/jD3tz8gdGaS9FCbkxSCmdrNue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214689; c=relaxed/simple;
	bh=psHxBjl481gjYQhTwo0qzwWBgo7H74fRjJSrZGRHig8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xx06v1FiR3CZ7SlFTudKv7du0YeJEZFK30Ev1zxXMyELVvDPCKMuU6TgfkrrzYwP1Gl91K6wilh5d4NRSr2PXb/PqPr08egqxqVKxIZmLS3Dag7hO0EbfZQFndMhnN3U7zTO3eXUtQAzVJhA4omeJorFhNhXGLAo+58DD9Ui3XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZ+EExFV; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ+EExFV"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f0e5e36912so55381396d6.2
        for <sparclinux@vger.kernel.org>; Thu, 16 Jul 2026 08:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784214687; x=1784819487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BSYGiZH98e8TFqFguafqMMr46lLxQiNCXi6OZDZdQ5Y=;
        b=TZ+EExFVObcdbV8vK6hdbejC/IMMyJnAFWdyPG3Nm8o4Oi9Q0Coe+kUaDhNMJ2h4uR
         z91wqujxK515LZ4Cvdh4YbKEgiTvYRaJL/uHix3Tt238G8Lxqm7HhlGSaVb24HH2mAqf
         +WyompAtUMizoq3HQdN0SoE/Wq6Wnn919vVxMERUI4TeUxW6VUxSrgxe9DHVGo/mQEKl
         zfEfiCqJmpAxAvDZmYEpl8MbPop+9rQjfj4OjPic6L4rP9eMfKDE0CklbtH+GUApK8An
         bOud0O4OyNpX4tlFUj62wwIHoGBw7LsZo9MtWLgmmPw9TsdKxKVDhZXz1CtFa3U7tHjX
         DUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784214687; x=1784819487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BSYGiZH98e8TFqFguafqMMr46lLxQiNCXi6OZDZdQ5Y=;
        b=X+l+e4q7KSyvyQGwx1GjVu/wCOZ0vX2wgevTDmyxL0rPVSZs8UDNvUvK8PB1wCSn5H
         0A2hK1pDKqVmF4dG5dgQX0XJn7yNYkm2JMRYFDHfkG9o9b+a5+PMc+vqBJ7cKd53n8ux
         sdF/D6dOsAwn/VNHMP82VRuUSz1/JuR6lQvqk93OsB9xaN6/ku2JcWz6UVGL7Z3i/HhC
         DZixL2/DgL3j8UI1LcDIcY4e09NsZYzKRpJo8z1UbhuBrn7/yv36n09kpqRbV9BgjWZa
         to5rvsKChTe89/NiXpoK1LXasFSY4aRBVxIuwbclCFjb338eHzs+LFSqEcX4XD8fwYPn
         K+Zw==
X-Forwarded-Encrypted: i=1; AHgh+Ro01Yk6AFc4bEo/q6UOjyyAOlXXhtSzcEc4JTGsXywTQ801mz7FL19e8bn7wwE5qp74TXij6oaVgNZB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1xhnKTTjgJjqjiMzcMc0Onk0+CquBsCwdSC3r1vXNgzVArWcm
	9ldPMukUe3n0RHx5egbGUMXlJoLUF0enIsVwUGVUmj34n31KNfuLMA1k
X-Gm-Gg: AfdE7ck/3cJXihxYc/bHhgbacxsVl+atVbiOwogamTHPZ2goas/aJcS6FhnxMf6j3fn
	oNYCZCyB1Dv7OO9BftbLjVuWz8ODnaiduG7x2XpFN/Z4cHgSAi5JbSvmpSXNE3r+NcqJJBpDXB2
	hUUzkC9nVS+Gow0u7WBdhb8cc5Qss641EDSMQO/UVz2sybvBNWMm38sWWWUXNRp1hrTUjyFsCSy
	S7BchxKAOSv+A4p56t0FQDXvXdbOk3H9ho8tzWCl+MuwPFPwSOOx5HLhmxnHu/Dcr649H1HO23z
	GFu72OW0dmPkGb3EkOVVrx9AjDEuFxK0kgAW8t0J53eMYFumGflGtAry/Tjm/sBspekmUJOXCTp
	qJE0ujETqn8PdhLZn+CQCOMWQcFe3MhPfiXtHE0aCDn916ga07adKd6dARhh2+ftdKm0tr12UPX
	7RBiEpmDyR
X-Received: by 2002:a05:6214:3385:b0:8fd:6e12:9710 with SMTP id 6a1803df08f44-90747d1cbf4mr139771886d6.62.1784214686754;
        Thu, 16 Jul 2026 08:11:26 -0700 (PDT)
Received: from TurinLinux.. ([184.144.109.221])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56c4b78sm220031906d6.18.2026.07.16.08.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 08:11:25 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	davem@davemloft.net,
	andreas@gaisler.com
Cc: bpf@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	visitorckw@gmail.com
Subject: [PATCH bpf-next] bpf, sparc: Add support for BPF_SDIV and BPF_SMOD in the sparc64 JIT
Date: Thu, 16 Jul 2026 11:11:10 -0400
Message-Id: <20260716151110.1716607-1-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

build_insn()'s div/mod emit sites pick DIV/UDIVX by ALU width only,
never by insn->off, so the sparc64 JIT does not implement signed
BPF_SDIV and BPF_SMOD (off == 1). Signed ALU32 and ALU64 div/mod get
an unsigned quotient and remainder rather than the verifier's and the
interpreter's signed result for negative operands.

Emit SDIV/SDIVX on the signed path across the ALU32 and ALU64, X-form
and K-form div/mod sites. The 32-bit signed divide takes a 64-bit
dividend from %y:dst, so sign-fill %y from dst before SDIV where the
unsigned path zeroes it; the 64-bit SDIVX skips the %y write. Route the
signed ALU32 result through do_alu32_trunc, since SDIV does not leave
bits 63:32 clear the way unsigned DIV does.

The verifier and bpf_do_misc_fixups() remove the zero divisor and
INT_MIN / -1 cases before the JIT runs.

Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
 arch/sparc/net/bpf_jit_comp_64.c | 92 +++++++++++++++++++++++++++-----
 1 file changed, 80 insertions(+), 12 deletions(-)

diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index 2fa0e9375127..6de9fb29944c 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -149,6 +149,8 @@ static u32 WDISP10(u32 off)
 #define MULX		F3(2, 0x09)
 #define UDIVX		F3(2, 0x0d)
 #define DIV		F3(2, 0x0e)
+#define SDIV		F3(2, 0x0f)
+#define SDIVX		F3(2, 0x2d)
 #define SLL		F3(2, 0x25)
 #define SLLX		(F3(2, 0x25)|(1<<12))
 #define SRA		F3(2, 0x27)
@@ -941,32 +943,69 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_ALU64 | BPF_MUL | BPF_X:
 		emit_alu(MULX, src, dst, ctx);
 		break;
-	case BPF_ALU | BPF_DIV | BPF_X:
+	case BPF_ALU | BPF_DIV | BPF_X: {
+		const bool is_signed = (off == 1);
+
+		if (is_signed) {
+			const u8 tmp = bpf2sparc[TMP_REG_1];
+
+			ctx->tmp_1_used = true;
+
+			/* Sign-extend dst into %y for 32-bit sdiv. */
+			emit_alu3_K(SRA, dst, 31, tmp, ctx);
+			emit_write_y(tmp, ctx);
+			emit_alu(SDIV, src, dst, ctx);
+			/*
+			 * SDIV does not guarantee the zero-extension that
+			 * the unsigned DIV path relies on, so clear bits
+			 * 63:32 through the shared truncation instead of
+			 * consuming the verifier's zext marker, as the
+			 * other ALU32 ops do.
+			 */
+			goto do_alu32_trunc;
+		}
 		emit_write_y(G0, ctx);
 		emit_alu(DIV, src, dst, ctx);
 		if (insn_is_zext(&insn[1]))
 			return 1;
 		break;
+	}
 	case BPF_ALU64 | BPF_DIV | BPF_X:
-		emit_alu(UDIVX, src, dst, ctx);
+		if (off == 1)
+			emit_alu(SDIVX, src, dst, ctx);
+		else
+			emit_alu(UDIVX, src, dst, ctx);
 		break;
 	case BPF_ALU | BPF_MOD | BPF_X: {
 		const u8 tmp = bpf2sparc[TMP_REG_1];
+		const bool is_signed = (off == 1);
 
 		ctx->tmp_1_used = true;
 
-		emit_write_y(G0, ctx);
-		emit_alu3(DIV, dst, src, tmp, ctx);
+		if (is_signed) {
+			const u8 tmp2 = bpf2sparc[TMP_REG_2];
+
+			ctx->tmp_2_used = true;
+
+			/* Sign-extend dst into %y for 32-bit sdiv. */
+			emit_alu3_K(SRA, dst, 31, tmp2, ctx);
+			emit_write_y(tmp2, ctx);
+			emit_alu3(SDIV, dst, src, tmp, ctx);
+		} else {
+			emit_write_y(G0, ctx);
+			emit_alu3(DIV, dst, src, tmp, ctx);
+		}
 		emit_alu3(MULX, tmp, src, tmp, ctx);
 		emit_alu3(SUB, dst, tmp, dst, ctx);
 		goto do_alu32_trunc;
 	}
 	case BPF_ALU64 | BPF_MOD | BPF_X: {
 		const u8 tmp = bpf2sparc[TMP_REG_1];
+		const unsigned int mod = (off == 1) ? SDIVX : UDIVX;
 
 		ctx->tmp_1_used = true;
 
-		emit_alu3(UDIVX, dst, src, tmp, ctx);
+		emit_alu3(mod, dst, src, tmp, ctx);
 		emit_alu3(MULX, tmp, src, tmp, ctx);
 		emit_alu3(SUB, dst, tmp, dst, ctx);
 		break;
@@ -1096,33 +1135,62 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_ALU64 | BPF_MUL | BPF_K:
 		emit_alu_K(MULX, dst, imm, ctx);
 		break;
-	case BPF_ALU | BPF_DIV | BPF_K:
+	case BPF_ALU | BPF_DIV | BPF_K: {
+		const bool is_signed = (off == 1);
+
 		if (imm == 0)
 			return -EINVAL;
 
-		emit_write_y(G0, ctx);
-		emit_alu_K(DIV, dst, imm, ctx);
+		if (is_signed) {
+			const u8 tmp = bpf2sparc[TMP_REG_2];
+
+			ctx->tmp_2_used = true;
+
+			/* Sign-extend dst into %y for 32-bit sdiv. */
+			emit_alu3_K(SRA, dst, 31, tmp, ctx);
+			emit_write_y(tmp, ctx);
+			emit_alu_K(SDIV, dst, imm, ctx);
+		} else {
+			emit_write_y(G0, ctx);
+			emit_alu_K(DIV, dst, imm, ctx);
+		}
 		goto do_alu32_trunc;
+	}
 	case BPF_ALU64 | BPF_DIV | BPF_K:
 		if (imm == 0)
 			return -EINVAL;
 
-		emit_alu_K(UDIVX, dst, imm, ctx);
+		emit_alu_K((off == 1) ? SDIVX : UDIVX, dst, imm, ctx);
 		break;
 	case BPF_ALU64 | BPF_MOD | BPF_K:
 	case BPF_ALU | BPF_MOD | BPF_K: {
 		const u8 tmp = bpf2sparc[TMP_REG_2];
+		const bool is_signed = (off == 1);
 		unsigned int div;
 
 		if (imm == 0)
 			return -EINVAL;
 
-		div = (BPF_CLASS(code) == BPF_ALU64) ? UDIVX : DIV;
+		if (BPF_CLASS(code) == BPF_ALU64)
+			div = is_signed ? SDIVX : UDIVX;
+		else
+			div = is_signed ? SDIV : DIV;
 
 		ctx->tmp_2_used = true;
 
-		if (BPF_CLASS(code) != BPF_ALU64)
-			emit_write_y(G0, ctx);
+		if (BPF_CLASS(code) != BPF_ALU64) {
+			if (is_signed) {
+				const u8 tmp3 = bpf2sparc[TMP_REG_3];
+
+				ctx->tmp_3_used = true;
+
+				/* Sign-extend dst into %y for 32-bit sdiv. */
+				emit_alu3_K(SRA, dst, 31, tmp3, ctx);
+				emit_write_y(tmp3, ctx);
+			} else {
+				emit_write_y(G0, ctx);
+			}
+		}
 		if (is_simm13(imm)) {
 			emit(div | IMMED | RS1(dst) | S13(imm) | RD(tmp), ctx);
 			emit(MULX | IMMED | RS1(tmp) | S13(imm) | RD(tmp), ctx);

base-commit: d1f4b56417a3dc1a0600f960b14f46bd25eda89d
-- 
2.34.1

