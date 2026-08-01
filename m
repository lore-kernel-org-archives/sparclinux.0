Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2542C29D291;
	Sat,  1 Aug 2026 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785613499; cv=none; b=QqeKgOP9dLM/LIwc/15jCCJ5vIAdXIqincmyZdUuLSbY9+9bLCQubT9/82CPDItR8drob2sb/cbiw8LdU5dRSO5Usqxy/vVY60M7GxAVU6eBoNmwyCR9YR91IOpyNTB8anUE8Kwy03Lp9dy0lWOdcJiMzluN9qBRP5iPNMtaFtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785613499; c=relaxed/simple;
	bh=MI5cmv+xw6xhCrOdsemZfa40yg0eBzYxV8uJU1Vh9W0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YsA2/U0DN2Qu/ioYpsv4PRxf5OQGQwk9YXCJ+ENoJSneR3wt2sYvlG45+MXRfbEzQFITXvdL9e3GiyFGwDcBZdf2lf5qVM+PYDzC8DymsiQShyKkP+rY23Nc3GB7TkwhtL+6VUmS0iakdn8gh5+V8NTdzgjWejlFgp/EZaCEGVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiUBA1jX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiUBA1jX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAEA1F00AC4;
	Sat,  1 Aug 2026 19:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785613497;
	bh=94vY6Y9FNFnjRzpmeE+IeX/dP3jar8aRF6KuNxVGOWY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GiUBA1jXCIUNx8SI7BPAJgFObQyYhZHKr6nCsbZtWSS5cRC47FwcjEo1/HrBKZMTn
	 92I/P262mueUg+Lj/km1ma+CjUbc46C8ayIDZh1k1Vqb1YvdOVn9MTzL/DduPL6/3+
	 n8dMdmFedrv7zJquEhZR3iA1zxfpDtrEdZnvr5b9OyI81hYFZmpSgCxdJkShWGnVqb
	 nnbhFwSNHJ+dfwnPbCNAaLny7+SMkWpsbKXki+kvvdhrtxBcJ5nbNPww31155sCx6Y
	 IwWwIn2bUkmHk0GU/q9z+DrfIl5tNYVWbDjDJ9yo6OhUVhObXJpBYnSFE9+WylgpZw
	 1Rngv9Lc+4K+Q==
Content-Type: multipart/mixed; boundary="===============7729938306852420091=="
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bf0ce87a4c9b050b1e438612e78517d5c321624fd09303341cc07bd172d2c627@mail.kernel.org>
In-Reply-To: <20260801191002.1383835-13-Julia.Lawall@inria.fr>
References: <20260801191002.1383835-13-Julia.Lawall@inria.fr>
Subject: Re: [PATCH] net/bpf_jit: SPARC: drop unneeded semicolon
From: bot+bpf-ci@kernel.org
To: Julia.Lawall@inria.fr,ast@kernel.org
Cc: kernel-janitors@vger.kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,davem@davemloft.net,andreas@gaisler.com,bpf@vger.kernel.org,sparclinux@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat,  1 Aug 2026 19:44:56 +0000 (UTC)

--===============7729938306852420091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> net/bpf_jit: SPARC: drop unneeded semicolon
>
>     When a function-like macro expands to an expression, that expression
>     doesn't need a semicolon after it.  All uses have been verified to
>     have their own semicolons.
>
>     This was found using the following Coccinelle semantic patch:
>
>     @r@
>     identifier i : script:ocaml() { String.lowercase_ascii i = i };
>     expression e;
>     @@
>
>     *#define i(...) e;
>
>     Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

The change itself looks right.  Both emit_cmpi() and emit_btsti() are
only used from bpf_jit_compile(), and every one of those six call sites
already ends in its own semicolon, so the expansions stay well formed.

This isn't a bug, but would a prefix like "bpf, sparc:" fit better here?
The changed file is arch/sparc/net/bpf_jit_comp_32.c rather than anything
under net/, and earlier patches touching this file used prefixes along
the lines of "bpf, sparc:", "bpf, sparc64:" or "sparc: bpf:".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30714427730
--===============7729938306852420091==--
