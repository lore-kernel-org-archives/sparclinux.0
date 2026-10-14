Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6E4E80DF;
	Wed, 14 Oct 2026 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996020; cv=none; b=RqkqImNbBDSt+VaXGtE0aHghqjfY11SfsLscbUEsTFeXD9INESJKkNjeS7ue54ZTayy12eikGVaM24Q5luKb/aL48jutSeL0P0+NYcBE1nuFTNMyfE7wsQ3ZkA1I6lcm+VdzmakvK6BKVjTMr+AlEDJwE4PXqgro9jw6RWsdGec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996020; c=relaxed/simple;
	bh=QqiXVTDc+vi5m/s/C24T4brchJv/5GOEcJPdPUwyTdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lP/tUofylqVsiJyX81GdWh7RQMJwjd3GXei8MbVaGQ78su4Q1lI0+h7LDOxKoV8CNbznGZTtm5875/SwWsj9RvMS58+PdxzshIrx9F9AYEe3fw7WcjX804kaHgG+v78f9jFmOyB0xE3YhPlqQqoZFnK5B2V4Z4NIHRExc1Tqhig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PV9OGPHi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PV9OGPHi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F371F000C4;
	Wed, 14 Oct 2026 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791996019;
	bh=6ZRPxlDuBCP8AsPgwkAnKodX3L8r43UjQtEXmmaQBwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PV9OGPHi711nW2OiWgo/4xAwaefuc7nkFPSuHLBcZS6BNt1nEHhvLSETY/PnTgosu
	 IjDXjlmagUGCCjqpMkcj2bHlNHIrGDIe4C/p6jbPuW1jdKkC280eseUv/tUUqMOjEY
	 poYG+QQFPlhpJLPBQLZmGrkoFkW1WEnPUfgGZ8zotPDV0OAUerYkLcer8w2UsjbBmS
	 7N80OXjTvPK2neMDr/WLKm6GHK4y0fUogfrnSfZ/0Eme4OKpbuKcpzf6cf+lWVhY2E
	 ZPIJnTm3sbPfYB/cUq4mNsvQk4cr2fM06q774We5o7DaC0g7gn08M8P51gtmS5aMLU
	 6OHz6Bu1Ef9sA==
Date: Wed, 14 Oct 2026 09:40:19 -0700
From: Kees Cook <kees@kernel.org>
To: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Cc: Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Stian Halseth <stian@itx.no>
Subject: Re: [PATCH 3/3] selftests/seccomp: add sparc32 support
Message-ID: <202610140939.5C50FB1D@keescook>
References: <20261014080730.8817-1-ludwig.rydberg@gaisler.com>
 <20261014080730.8817-4-ludwig.rydberg@gaisler.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014080730.8817-4-ludwig.rydberg@gaisler.com>

On Wed, Oct 14, 2026 at 10:07:30AM +0200, Ludwig Rydberg wrote:
> Add SPARC32 definitions to seccomp_bpf selftest.
> 
> Reuse the sparc64 register handling on sparc32 but adapt the carry
> bit handling to use %tstate on sparc64 and %psr on sparc32.
> 
> Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>

LGTM from a seccomp test perspective. Please feel free to carry this via
the sparc tree:

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
