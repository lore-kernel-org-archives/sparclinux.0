Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443831A680C
	for <sparclinux@vger.kernel.org>; Wed, 29 Jul 2026 00:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285201; cv=none; b=ch2DdU8LTXz1FBfWzHlRrj1XPyK9k50NXOktQ5/j+OpnW4WTHtFh68gRg6eCMJ5CahfQNAhTaRlgz+k/J+rZlbc3zIZc8UK3ChwSpgeG2j3QY5KPshHydkSiWuLMkYRthb1J9ffOXmdhXUjB39asVNqrMMvr8KMcEtqMOw5hBJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285201; c=relaxed/simple;
	bh=6rfrrWiyQuoMd30AJTwY93WChcXraypHfGW2Pj0oKq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LH/Q/LeAwpnjOFlBV0dHtUqEUjesKhW9jUCqCggT4vzywkNZpiM7/S7Ypy9ErQjOaPTPLMEsvq2EOxpntu1HidHnlxaQynnqc+s8k7lRQXpceS5iO7QjB89H7VHgisHueCEuBqEIg4858DYJXKVoJeUgsDeFiBN8Y5bUMGnh3wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anvAnLz1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anvAnLz1"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso343336a91.1
        for <sparclinux@vger.kernel.org>; Tue, 28 Jul 2026 17:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785285200; x=1785890000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d/Zd5STtXdTAMiAnTPj7JWPFpUYj9bNHGw37yl42REA=;
        b=anvAnLz1coFoc97CpkrE0iIUQHIMQKc67PephshEcQdVUjuNZS5IRNyG7zd+ExQXAw
         VvSmQZZEUBGUEpI/R0J0iB8E+9QGlHjEKa+hOGqoDH+7Rxlkg344Iu5Vv66uLuRW0Mva
         c6U+BafVcHt3Mubk0oyX9fTtP4KKTeE1ybyq3mhQNJOnRwWn9H82RPbjX29M9ChBdhmo
         Fetk4N+mSmrVfRpPXFim4iUHSyUvEvSxwaAf2mQcmYuJZgxxp8gF5b8Q5lAhZLDp/0fO
         N+6O88KTTgLWjA+D56MfWR1j97EH6/QGT/10OIviLtwtq5SmE3SBhYbO5j/nWoZYG4k/
         +oVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785285200; x=1785890000;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d/Zd5STtXdTAMiAnTPj7JWPFpUYj9bNHGw37yl42REA=;
        b=BMLO3uUUhH0QvAtg7wr+ZL0tCQIljdIg0jxjRI7QyA2dGrRobldYcWbuShu1o4xzPq
         +NTAtbV2UBhPXLmMKIFvnPvfK3g6aO9m5N68tHSd37pWz6UQdSvHMY31l9gZL2MPI6v+
         sIJllhAFW7Raljkbxl0AlDr2L9La1RUch8mn/fp6mWQpDtsPBePKyL2RVQoi3p7L8OJw
         zT4Y3ylh8yZTqbLP9r0kdEtMoGIBoTobE4L0u4LLRqq9Htq0AnsOg6bqMD41Pzl58eBZ
         2k4umXCH/Ox2Th5jqWwA1QNRf/IGv4klhibIxfzDgOIJ2AzeSLb9eRlam/foy/cPPXgy
         UPLA==
X-Forwarded-Encrypted: i=1; AHgh+RqU1eBEo5xFLisaOPU3eixU/s5UXBt+Grgkott8ijZ/A9W0SnLXOg17qY5P+vkzHRmp6qdO/z9ABJ7O@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvsg+UgHUbim7mHXIU1AJ3USfjVtgd08ksoWG7KAhCq/SA9omO
	2PzJ3FIimypyzdTWvlhoSxJskUK4t6iTSxT128PqrFddjOQhzAHXNYig
X-Gm-Gg: AR+sD11rG7y/xkNCdAXm8M95xlW0WqjuN1zUuP3Ft0UDtm24zhkoS85SIv7BzOkCgKV
	RvnxegRNdOixHWKCKWVRGKvZpn9brln0OOS2MTJIh+tougX7NC/SrVk2mrPjwMeGfo/UqYKBVA4
	CaiEFmq+muhzPwDKep5INRkMUqgrXivuqXZyTJV+yAyRQ+u2QC2OinkVpcs62ON/+Iskcz1aDCq
	WiWNTfWIfwe0i5ort3XWu9BfrpsrZdnb6adzVnvdFh3pe3xd5I60Jmsh60Dfr05f7WyjhPoGrx4
	1IWE5nAUiIR2hWMPAAiB22cPhtYLdYPE4FdQycI2Z2G/RCZC7+jnT07A1DMhl/SOph/75PIdBrj
	PsG+mxJHl1PVGRQe2Jt7XA6Z7gOjiS7cg1AV+c68JjJHUU3jmQh0Jew1/6Uu/mRIcQvBA50EGdM
	KVu8jUXpuyDypULKI09tpu4Cqp4yeR6+kKOBCy42hWI1xlHFTPMT+U5uxmlpdP
X-Received: by 2002:a17:90b:394a:b0:38e:895f:25fc with SMTP id 98e67ed59e1d1-38f6a4b6e16mr5151857a91.38.1785285199508;
        Tue, 28 Jul 2026 17:33:19 -0700 (PDT)
Received: from google.com ([118.150.148.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f2b690fsm552834a91.13.2026.07.28.17.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 17:33:19 -0700 (PDT)
Date: Wed, 29 Jul 2026 08:33:15 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Nicholas Dudar <main.kalliope@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, davem@davemloft.net,
	andreas@gaisler.com, bpf@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf, sparc: Add support for BPF_SDIV and
 BPF_SMOD in the sparc64 JIT
Message-ID: <amlKS9s1YYh5mOEi@google.com>
References: <20260716151110.1716607-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716151110.1716607-1-main.kalliope@gmail.com>

On Thu, Jul 16, 2026 at 11:11:10AM -0400, Nicholas Dudar wrote:
> build_insn()'s div/mod emit sites pick DIV/UDIVX by ALU width only,
> never by insn->off, so the sparc64 JIT does not implement signed
> BPF_SDIV and BPF_SMOD (off == 1). Signed ALU32 and ALU64 div/mod get
> an unsigned quotient and remainder rather than the verifier's and the
> interpreter's signed result for negative operands.
> 
> Emit SDIV/SDIVX on the signed path across the ALU32 and ALU64, X-form
> and K-form div/mod sites. The 32-bit signed divide takes a 64-bit
> dividend from %y:dst, so sign-fill %y from dst before SDIV where the
> unsigned path zeroes it; the 64-bit SDIVX skips the %y write. Route the
> signed ALU32 result through do_alu32_trunc, since SDIV does not leave
> bits 63:32 clear the way unsigned DIV does.
> 
> The verifier and bpf_do_misc_fixups() remove the zero divisor and
> INT_MIN / -1 cases before the JIT runs.
> 
> Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> ---
>  arch/sparc/net/bpf_jit_comp_64.c | 92 +++++++++++++++++++++++++++-----
>  1 file changed, 80 insertions(+), 12 deletions(-)

I saw that your bpf jit patches span multiple architectures.
Assuming you don't have access to all these different hardware platforms.
Just out of curiosity how were these patches tested?

Regards,
Kuan-Wei

> 
> diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
> index 2fa0e9375127..6de9fb29944c 100644
> --- a/arch/sparc/net/bpf_jit_comp_64.c
> +++ b/arch/sparc/net/bpf_jit_comp_64.c
> @@ -149,6 +149,8 @@ static u32 WDISP10(u32 off)
>  #define MULX		F3(2, 0x09)
>  #define UDIVX		F3(2, 0x0d)
>  #define DIV		F3(2, 0x0e)
> +#define SDIV		F3(2, 0x0f)
> +#define SDIVX		F3(2, 0x2d)
>  #define SLL		F3(2, 0x25)
>  #define SLLX		(F3(2, 0x25)|(1<<12))
>  #define SRA		F3(2, 0x27)
> @@ -941,32 +943,69 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
>  	case BPF_ALU64 | BPF_MUL | BPF_X:
>  		emit_alu(MULX, src, dst, ctx);
>  		break;
> -	case BPF_ALU | BPF_DIV | BPF_X:
> +	case BPF_ALU | BPF_DIV | BPF_X: {
> +		const bool is_signed = (off == 1);
> +
> +		if (is_signed) {
> +			const u8 tmp = bpf2sparc[TMP_REG_1];
> +
> +			ctx->tmp_1_used = true;
> +
> +			/* Sign-extend dst into %y for 32-bit sdiv. */
> +			emit_alu3_K(SRA, dst, 31, tmp, ctx);
> +			emit_write_y(tmp, ctx);
> +			emit_alu(SDIV, src, dst, ctx);
> +			/*
> +			 * SDIV does not guarantee the zero-extension that
> +			 * the unsigned DIV path relies on, so clear bits
> +			 * 63:32 through the shared truncation instead of
> +			 * consuming the verifier's zext marker, as the
> +			 * other ALU32 ops do.
> +			 */
> +			goto do_alu32_trunc;
> +		}
>  		emit_write_y(G0, ctx);
>  		emit_alu(DIV, src, dst, ctx);
>  		if (insn_is_zext(&insn[1]))
>  			return 1;
>  		break;
> +	}
>  	case BPF_ALU64 | BPF_DIV | BPF_X:
> -		emit_alu(UDIVX, src, dst, ctx);
> +		if (off == 1)
> +			emit_alu(SDIVX, src, dst, ctx);
> +		else
> +			emit_alu(UDIVX, src, dst, ctx);
>  		break;
>  	case BPF_ALU | BPF_MOD | BPF_X: {
>  		const u8 tmp = bpf2sparc[TMP_REG_1];
> +		const bool is_signed = (off == 1);
>  
>  		ctx->tmp_1_used = true;
>  
> -		emit_write_y(G0, ctx);
> -		emit_alu3(DIV, dst, src, tmp, ctx);
> +		if (is_signed) {
> +			const u8 tmp2 = bpf2sparc[TMP_REG_2];
> +
> +			ctx->tmp_2_used = true;
> +
> +			/* Sign-extend dst into %y for 32-bit sdiv. */
> +			emit_alu3_K(SRA, dst, 31, tmp2, ctx);
> +			emit_write_y(tmp2, ctx);
> +			emit_alu3(SDIV, dst, src, tmp, ctx);
> +		} else {
> +			emit_write_y(G0, ctx);
> +			emit_alu3(DIV, dst, src, tmp, ctx);
> +		}
>  		emit_alu3(MULX, tmp, src, tmp, ctx);
>  		emit_alu3(SUB, dst, tmp, dst, ctx);
>  		goto do_alu32_trunc;
>  	}
>  	case BPF_ALU64 | BPF_MOD | BPF_X: {
>  		const u8 tmp = bpf2sparc[TMP_REG_1];
> +		const unsigned int mod = (off == 1) ? SDIVX : UDIVX;
>  
>  		ctx->tmp_1_used = true;
>  
> -		emit_alu3(UDIVX, dst, src, tmp, ctx);
> +		emit_alu3(mod, dst, src, tmp, ctx);
>  		emit_alu3(MULX, tmp, src, tmp, ctx);
>  		emit_alu3(SUB, dst, tmp, dst, ctx);
>  		break;
> @@ -1096,33 +1135,62 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
>  	case BPF_ALU64 | BPF_MUL | BPF_K:
>  		emit_alu_K(MULX, dst, imm, ctx);
>  		break;
> -	case BPF_ALU | BPF_DIV | BPF_K:
> +	case BPF_ALU | BPF_DIV | BPF_K: {
> +		const bool is_signed = (off == 1);
> +
>  		if (imm == 0)
>  			return -EINVAL;
>  
> -		emit_write_y(G0, ctx);
> -		emit_alu_K(DIV, dst, imm, ctx);
> +		if (is_signed) {
> +			const u8 tmp = bpf2sparc[TMP_REG_2];
> +
> +			ctx->tmp_2_used = true;
> +
> +			/* Sign-extend dst into %y for 32-bit sdiv. */
> +			emit_alu3_K(SRA, dst, 31, tmp, ctx);
> +			emit_write_y(tmp, ctx);
> +			emit_alu_K(SDIV, dst, imm, ctx);
> +		} else {
> +			emit_write_y(G0, ctx);
> +			emit_alu_K(DIV, dst, imm, ctx);
> +		}
>  		goto do_alu32_trunc;
> +	}
>  	case BPF_ALU64 | BPF_DIV | BPF_K:
>  		if (imm == 0)
>  			return -EINVAL;
>  
> -		emit_alu_K(UDIVX, dst, imm, ctx);
> +		emit_alu_K((off == 1) ? SDIVX : UDIVX, dst, imm, ctx);
>  		break;
>  	case BPF_ALU64 | BPF_MOD | BPF_K:
>  	case BPF_ALU | BPF_MOD | BPF_K: {
>  		const u8 tmp = bpf2sparc[TMP_REG_2];
> +		const bool is_signed = (off == 1);
>  		unsigned int div;
>  
>  		if (imm == 0)
>  			return -EINVAL;
>  
> -		div = (BPF_CLASS(code) == BPF_ALU64) ? UDIVX : DIV;
> +		if (BPF_CLASS(code) == BPF_ALU64)
> +			div = is_signed ? SDIVX : UDIVX;
> +		else
> +			div = is_signed ? SDIV : DIV;
>  
>  		ctx->tmp_2_used = true;
>  
> -		if (BPF_CLASS(code) != BPF_ALU64)
> -			emit_write_y(G0, ctx);
> +		if (BPF_CLASS(code) != BPF_ALU64) {
> +			if (is_signed) {
> +				const u8 tmp3 = bpf2sparc[TMP_REG_3];
> +
> +				ctx->tmp_3_used = true;
> +
> +				/* Sign-extend dst into %y for 32-bit sdiv. */
> +				emit_alu3_K(SRA, dst, 31, tmp3, ctx);
> +				emit_write_y(tmp3, ctx);
> +			} else {
> +				emit_write_y(G0, ctx);
> +			}
> +		}
>  		if (is_simm13(imm)) {
>  			emit(div | IMMED | RS1(dst) | S13(imm) | RD(tmp), ctx);
>  			emit(MULX | IMMED | RS1(tmp) | S13(imm) | RD(tmp), ctx);
> 
> base-commit: d1f4b56417a3dc1a0600f960b14f46bd25eda89d
> -- 
> 2.34.1
> 
