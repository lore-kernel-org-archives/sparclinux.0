Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657056;
	b=R/5v981O6sawkiQX0dHYRiEP2jSdDL/0H8GGWGiraJpprVGuKYziKBBLRYG0v9RZMDqB
	 xLctdW4vqwjXQIWJtz55HwfGwyCSgOSQQUEmFvFrapAuw49Pl6EkrSJSRgJlnjoklwYvK
	 p+VcESV+InkhrjsVk717nmh/FTATIQKTJ68wDgI/sQJPUe2jic/Gq6XnwpG7AYb3N3yDl
	 VatzrmG9V3Se6e6NPhq7yvjS8bOpFjv7CiDTAVa/j1bxsKoqqHygg3sa8XsPWC0WL5eOO
	 YaAAC3XqIpJUSAPgHwW/fBWbi2EAzdUCaSlrT3FaYrhalte6ONQuDQF3m0Sp/FgNWRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657056;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oE/Svadsbdj6oQXdKG7hcZ3poCMNUec1eSQbhzMWx9k=;
	b=GuN64sfdQZNaLX8ykLXtdp8OYWJISOjOKX0PEimCvNYixCYijQHALnqfRf2aYyL2SPff
	 DnE521TcUEKsAjReCpoJmKZP6A/L/sVWk6MQZFYkBlh+mFq7V84+oeyKjUz6V0q7R0apE
	 ub2KctmGNhFE1B4SyyrO/biMVctmWT61USq+sG9qUF0iFLEt/+yHMd5mqqc1minX/D/Y2
	 rvS16wPsvfSt4/HjRgiDjDxg1Y0aeUOAs3hnBpBPhqlrWmAhcLTiagAohFdwIzxO7ZDc5
	 3wkSm1RHTrSpja/5sZG6ZwpsYKzT/i5WhrrgwXpZ0BUofrFnwdAWJ+DrWL5gH24LkeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y31fijMy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F254606A326;
	Mon,  2 Nov 2026 22:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y31fijMy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA981F00A16;
	Mon,  2 Nov 2026 22:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793657055;
	bh=oE/Svadsbdj6oQXdKG7hcZ3poCMNUec1eSQbhzMWx9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y31fijMy2mILdKMztSzQ8maS5sknd28YcnFiQLOilulQvPnCIxucObXaqT6Vv5qHi
	 nxPv78JcN7UU9xlROPpTx/AmzUJ5KwY8qbFLTDVTYTLBO9sSdiby7tSFMJYb3ifjd7
	 Jrixehe3ASuLjP4yomib3B5NtrvdddBNWACj+Xi+HUjNoxcDPKEyfP04J8OSS7DDe7
	 zUejJpFKmZvext9wg8OQ0hWpl443QaSjmzl9V7KINHahQH/MFE6KWrd7s4mMeRAl2x
	 oQX/6YbT8wI7yVMKdwpOlk70uRv28X9apEz/8Sir+cH2bAh25EQpzyq8JcbNsEvo6H
	 bihnZMG3tXu0w==
From: Imre Kaloz <kaloz@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] math-emu: fix wrong word index in _FP_FRAC_CLZ_4
Date: Mon,  2 Nov 2026 23:02:58 +0100
Message-ID: <20261102220258.15264-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927005630.8202-1-kaloz@kernel.org>
References: <20260927005630.8202-1-kaloz@kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andreas,

include/math-emu has no MAINTAINERS entry, so this one has no obvious
home. sparc is the only user of the quad code in op-4.h, and the bug
only shows up there. Would you be willing to take it through the sparc
tree?


Thanks,
Imre
