Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686139;
	b=JBuBeG+w9o5f5v+6LXybVD63u7iUvk6EtxbDGmSXaCnkhhaTbZFhqNSEBg3ejQ4w49/R
	 ZLJJp2aYc9SHRIQv3Qya6zhs3dfHOud+fz25WbiXWDHJ8XxGYa/3/W93kzY19sbd/jsun
	 F7YX6kD7WaQj1d1F0g0tkPjyFdjeGuN8mBup5Wm08ylbQxtKeLlV9HeUQqa3iyO980n9x
	 PclmLFLxIp40y7K6p8XUaJ1AeHbBM0gwgjfUr6x9o1iCP72nO5YFF1GyCXj3K95GzybKa
	 CMxC4YMwTGuDGFMZzaRyH/LrcjCcypvxOFcKUIbQsHlqv0rB7XKPUvU/JbrlmXkJlXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686139;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LNq1qzmvnSmodfz50wCp8JrBqr/g9Lr6v+dEFdiRLdI=;
	b=HnVdEC0qX3GsGuitd6Ai6iAymUVCBsyz7tbyLS3Awb1Q8xGLh0ZoWX8DSDDb67QBu49I
	 zsm7GGBpjG9JxxTdwxoejQKKbLa3lYiJpjBnbbP1f1sKcvT7qCaJMNTwfCG2LuWPpNgq6
	 acHSv4nTgMhmT1vYR3K38n47KOTckBvB4VH73tk6cS4GUoZFf8z7kq4j+hOfAbOT2s30C
	 +3msGjrFJFaq91AnwOLVuGGfNRXkLWEStj9Xx1cuNdx05KFLJvNzHG1TDX8p9aTtCbdkv
	 icLMpoaq37p9TnrFPw2M5kHyJ7QuOFBnTKTIMmVtAnivHoNoqhTpZzDD88EDHZ6ioMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ayrv/FZe";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E482606A31C
	for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ayrv/FZe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE431F000C4;
	Thu, 26 Nov 2026 09:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795686138;
	bh=LNq1qzmvnSmodfz50wCp8JrBqr/g9Lr6v+dEFdiRLdI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ayrv/FZeysMShiaX6c+SWUI8rZPpKA65WiJcHLBr/Op0vVZoW4rN510UhxxcdgADc
	 bkw8J1GGMqdokVpCO3NVtiEicPbRn8KCgIzpZFSB2y15HEuY6Pj6o90K4SBzEHWJv2
	 n2YQWiQWo+5oH1BTaHtOwAVo1sRMKk/HcsS5Q7HiJTC1WNUQUYsTPfLj9o+luCYsPk
	 rmttHAOdssaFd4pLWjhY/Vjq8Pjnd7hn/p/LHhixB0hI5zoxzvXq8FJF5AIIV5tZjg
	 Whft7BBrQJ8aU85lp6uErjDvnLdGfbzRW0l3pwIWX8qB46SxdL5DjNsr+U0M8A6GoC
	 opoyAaSoqB/Ng==
Message-ID: <sashiko-outbox-235158@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/18] sparc32: tolerate firmware nodes without a name
 property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: sparclinux@vger.kernel.org
In-Reply-To: <20261126093106.1345825-7-linmag7@gmail.com>
References: <20261126093106.1345825-1-linmag7@gmail.com>
 <20261126093106.1345825-7-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 09:42:18 +0000
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] sparc32: missing Fixes: trailer for NULL dereference in
  build_path_component()
--

commit f438c40f8b6eebf1210958ddefc12bef550dbce9
Author: Magnus Lindholm <linmag7@gmail.com>

> sparc32: tolerate firmware nodes without a name property
>
> Factory LEON U-Boot omits device-tree name properties, causing
> build_path_component() to dereference NULL. Use an empty root component
> and phandle-based child names when the property is absent.
>
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>

[Severity: Low]
This fixes a NULL pointer dereference introduced when build_path_component()
switched from dp->name to of_get_property(dp, "name", NULL).  Should this
include:

  Fixes: bb31f9eb4abe ("sparc: prom: use property "name" directly to constr=
uct node names")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126093106.1345=
825-1-linmag7@gmail.com?part=3D6
