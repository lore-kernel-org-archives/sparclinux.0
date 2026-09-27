Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1553BFE24;
	Sun, 27 Sep 2026 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790542241; cv=none; b=QRsVXn+8GPP/gNh9Hjzj74prDzLDSNAy0D9u6675ccPKqB3ajrlOlTv50K6yT9BPqCzRVdXbzFe58WyUNco7SpCZNDiSALZVsKBknIDxxlLG9ZxHRwA5f0eE5Fh2CGeiKvNXI+A8nxM2W77u2+UaLKGd1fqBiv0WT/UJYw+4ImA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790542241; c=relaxed/simple;
	bh=iK6Mq55bOxoPcwOvm9ueRFCLxA1tQAGYFmafb+shAmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+VGWlfcCTO7HbApeD52pkrhQ+MFSl3QvT4Ym2T443UMZbw5aO1LM6Q7KElNFZdVRC6puN/i0lb8gsDrx/C9UD5iHy8vOB3r7ewBBcecwN9yv/Q2pIw9GDYZsou5l0EwrJnswHmo1EdmDUp8fil9TkPa8QRrOP71A3fZAtns++o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnA6twM1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnA6twM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985341F000FF;
	Sun, 27 Sep 2026 20:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790542240;
	bh=R+KXCODWxRkPE9qxRSyL7ovsRtx70gk4IpEo2Dyqkvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TnA6twM1O3KAaq9HpOyhj8AYqQ7otANXORWu2KV4pzwwCTvMtxw25OUmlPbgGMVau
	 siNr3a6qAwlce7NiZMW1CTtJSLsBB2axXv8gM+kc+RyqPtB1lfJA2eJciOrDX8JFmZ
	 DvevxF2/Xnn/VfoGkKyt/8iNXaXWONmTeG0FzMOUyqvXzthibJysBAddhKLretn650
	 j3zOMinnKdQ8aujtChIdpPcc0y8aseHKw3J2WbBcSEYDB8pCKpcWVXXTAWBYWyb3nT
	 UeCcmap5j3575LqjOfSqseLOrUERGpR+uUQI3J0s7ZpHJUhmoiyy/zT7dzhYMKXpNT
	 ySR880AlSEQZg==
From: Imre Kaloz <kaloz@kernel.org>
To: Stian Halseth <stian@itx.no>
Cc: davem@davemloft.net,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	glaubitz@physik.fu-berlin.de
Subject: Re: [PATCH 0/3] sparc64: fix a window fill fixup lockup and two fault bugs
Date: Sun, 27 Sep 2026 22:49:37 +0200
Message-ID: <20260927204937.3814-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828123707.1852437-1-stian@itx.no>
References: <20260828123707.1852437-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 28 Aug 2026 14:37:04 +0200
Stian Halseth <stian@itx.no> wrote:

> A register window fill that faults is mishandled in three ways on
> sparc64.  The first wedges the CPU in kernel mode and takes the
> machine with it; the other two corrupt what the kernel reports
> about the fault, and were found while chasing the first.

Hi Stian,

Confirmed on a Sun Ultra 45. With the series applied it never faulted
through 80 iterations, without them 60 out of 60.

Tested-by: Imre Kaloz <kaloz@kernel.org>


Best,
Imre
