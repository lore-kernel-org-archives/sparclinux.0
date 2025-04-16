Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA30224B1E;
	Wed, 16 Apr 2025 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831799; cv=none; b=RdwpaGPQ8DS83Zp0xBQ02gkUxnY+Z/pICD3uuHDjPBYskKHsqoT5gg5YpzXNkdWg3agAsTG0Ao6/uL0y26h87P0/iYKYfCEkcPGxunrCkI9r7NgGL57Z4A8pK73Xe7v+QFJi67NMkgTHAuFMuC4usS4zHBsC9cKXf6jc/wAsHzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831799; c=relaxed/simple;
	bh=9sY6DCWtr7YPqdYfhZSmX5pX6hWugboVd0TdthmIAT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JqvQP542AReUwNNjmO1ObDa0WFblmHgekpz63PudA5h+GLjfMIYkCvif3K38NuP1DkUTVuFw5ig2W1axzktCiO9fkM/L4+6fvoj3kqKwV1rOfpg1i/KfW5KsV4svDupm290KMUHJ271MQ2iPFOPNN/w49eRUOXSyf4ATquU2EGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1Zr762H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1Zr762H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25422C4CEE4;
	Wed, 16 Apr 2025 19:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744831799;
	bh=9sY6DCWtr7YPqdYfhZSmX5pX6hWugboVd0TdthmIAT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c1Zr762HmiwlRyaROFL9TdGg2RWeVVd5qO6DqvhsrOb3k/KQDjeD53EWNV9Giy6zX
	 gWOxJW8sqSckVZLwG5S6bljZd2X0KidDMG/sqnHbStwb3hkFzfjBPX8H+zExBCOEUl
	 v9E2pPvxFg1cPVomk3kPqJt3GXwf64ajHwwLFzcaXNxvQjuwLMX+kooZu2UcCdpWTK
	 ktFYxk3qWXAvLdlOboog/YqC22LhYwP8BI2VXqJn09B0PZESiUviN7OByJD8xAfbIG
	 n9k1r9nudRs+gbq/tHTlVLw/U68w8MMtrhMu/5tz9rCgqklcY1WtcfrwpQxB1aBjO5
	 JcjMFehOGZcyQ==
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Gow <davidgow@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org
Subject: Re: [PATCH] kunit/usercopy: Disable u64 test on 32-bit SPARC
Date: Wed, 16 Apr 2025 12:29:48 -0700
Message-Id: <174483177857.740549.4788353430727368438.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416-kunit-sparc-usercopy-v1-1-a772054db3af@linutronix.de>
References: <20250416-kunit-sparc-usercopy-v1-1-a772054db3af@linutronix.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 16 Apr 2025 14:44:19 +0200, Thomas Weißschuh wrote:
> usercopy of 64 bit values does not work on 32-bit SPARC:
> 
>     # usercopy_test_valid: EXPECTATION FAILED at lib/tests/usercopy_kunit.c:209
>     Expected val_u64 == 0x5a5b5c5d6a6b6c6d, but
>         val_u64 == 1515936861 (0x5a5b5c5d)
>         0x5a5b5c5d6a6b6c6d == 6510899242581322861 (0x5a5b5c5d6a6b6c6d)
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] kunit/usercopy: Disable u64 test on 32-bit SPARC
      https://git.kernel.org/kees/c/b2044b94a6a9

Take care,

-- 
Kees Cook

