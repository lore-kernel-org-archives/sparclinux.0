Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579072;
	b=wqQAh4vr4QPFvNb3cCqV48KHAk4U9cXwpP69yHLNfTU1yQaq9is0FN/KMjeC7VaPIIxl
	 RLOCgZD+nuiB1eIx5WqhnuLfjdi2RIhArS8E25WHugvLcA3vfAuoIHC8KZV5Rnwgi2Dgy
	 RrdmyTWrw8xHbwWIeRbcCVSRRGFv1sVCmxdldLtRerRjziHV5HYjDa4N37jHr0+VJBtIG
	 GNWLPX1CDpJgl2IO3KR7yLVdHAWkfS99hJ8Sj9XFm5yMOn+bA2MCeNsWo7MvwYusdMTO2
	 0crOv1tpg4B9aSEriapNHLtGCCc0BRhE/uVBIF1oZHYdTHr6oVOaVaTouFxFM7hVg0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579072;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=IWiJ8oOcKXVdB6IJ4381jMA8VyAelQkRdlx5j9qXzdg=;
	b=KUsTtcfKzWy9uq2PZDqFcsJwzpREwLU7bpt+8AbI/D8/8wozBKdYX+xSU2bCXIDR/Pon
	 fSJO0U829ngTdyzFAhcPkD4Y7/ZfffuOfkxZmFyhP9Yu9rmcEeKDrz3oSyYV8kcBd0GAk
	 q6KSHkhS/8oZMlMzLBVc8kaT8HcSUmIqBGP6FWEmkK8PSasBW+S3fddccnPfaJEQF/9py
	 rOeuir6ObfX5dBIMWNB5loyA87Z/B2+eutOmvyAgHUxv0QNG2amiVT8HujoI2oMYTrhy3
	 heB5lbCDJz269m15sjkb71RwEmiD4X7zcl9Ht59YOCpYlMni0VWiMym4Uw7F0Xg1hgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hdBFGIvR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C185F606A319;
	Wed, 21 Oct 2026 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hdBFGIvR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EA61F000C9;
	Wed, 21 Oct 2026 10:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792579071;
	bh=IWiJ8oOcKXVdB6IJ4381jMA8VyAelQkRdlx5j9qXzdg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hdBFGIvR71o+bk7CtajQ+ITt4pS/5NHuFS9SIGY5M9a1FepJj9ZMVFVAUxnN8vZUJ
	 aRLL+4FoIatrorjljon+h59wB7uvrwUrkUze7k+OwZrW5/6ACS3G6g2WyKcjeb6zH/
	 kyHurUuT4hv4o/0Rtm+hJgvEiaVYBnl/xlUIvfsGGN3cyeEip1U+7fhbmZQOz88Ghi
	 fuLv8qHUnkZPAqvMPSQx3ESIHYPMOtVLrdDoj8EJsuBVKam0k4Ikt+9gZaEvV49Hqs
	 PawEJl95Wf5ZcuJ+k+G1RZRq/OLH8CJgPWyG1tut+bq7YeU3OXaWYbi3d6AEeCoska
	 xwafKhSv3jJpA==
From: Christian Brauner <brauner@kernel.org>
To: viro@zeniv.linux.org.uk, Stian Halseth <stian@itx.no>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, schwab@suse.de, 
 fweimer@redhat.com
In-Reply-To: <20260917151614.376867-1-stian@itx.no>
References: <20260917151614.376867-1-stian@itx.no>
Subject: Re: [PATCH 0/2] fs: honor FOP_UNSIGNED_OFFSET in llseek and
 positional I/O
Message-Id: <20261021-abgehackt-ausmachen-fallzahlen-9da5515aeaf3@brauner>
Date: Wed, 21 Oct 2026 12:37:47 +0200
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-3d1b8

On Thu, 17 Sep 2026 17:16:12 +0200, Stian Halseth wrote:
> Two generic VFS bugs found while fixing pldd(1) on sparc64, where
> userspace is mapped above 2^63 so file positions on /proc/PID/mem have
> the top bit set.
> 
> FOP_UNSIGNED_OFFSET declares a file's offsets unsigned, and vfs_llseek(),
> rw_verify_area() and the mmap path honor it.  Two sets of syscall
> wrappers do not:
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/2] fs: fix llseek() result for files with unsigned offsets
      https://git.kernel.org/vfs/vfs/c/34e5caa86b12
[2/2] fs: allow positional I/O on files with unsigned offsets
      https://git.kernel.org/vfs/vfs/c/8c5ba5aa0278

