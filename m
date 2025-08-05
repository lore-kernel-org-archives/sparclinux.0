Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967FE194137;
	Tue,  5 Aug 2025 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386185; cv=none; b=NbD6GL+bnogGDRjMZCAGZrF6int6KT2dJY94TT0ynq+Nv5f5TU5k9gzbkWuJk0Yqaya72twjnkN32yW1diiCj/abAC1fLDTZ0PkxsRs6C8aEdi2YLQi2pV8Vvd1RRlNdt/mGXghuLWAomcIC8r+guca+76Po/zUD991dOcqfPP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386185; c=relaxed/simple;
	bh=dAKal5weIHM3HgsAzvyNpVMMpmVqe/TuB2uUgYihS1M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=orCcSFIltOBtooKxuW/p9MiKHxsClFiHbzCSQcVo9RoadUZfXTzopCtUX7s7abhUSRgdfVB3XDz973+G2CZ9Xj7j/+hHIl/PbKsdjXKCatTmOs85baqGa3SeWzaYOumkL9jYqHxcMBt3rA6eRD0EAYplzYRaZjZ6jkNlPhF2wVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QVIWglHK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qp16iOQi; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QVIWglHK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qp16iOQi"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 59E161D001F1;
	Tue,  5 Aug 2025 05:29:41 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 05 Aug 2025 05:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754386181;
	 x=1754472581; bh=dAKal5weIHM3HgsAzvyNpVMMpmVqe/TuB2uUgYihS1M=; b=
	QVIWglHKuSRibiBnW54EffYuyq8om2Fqrj97P7o9VFEBdVIUesTFC1w/FgcQJRCc
	+RYUPh+8cs388Lf+dJB3Fj/UMGsj7uOwgBvWB1jBySxsBrKB3RrWVDzHd9GYuRSw
	qQc38/kLITcZLvnHIX8yLrfqRLqlRTA77Ru9zNxCRVqvT79FapYhDjQMKqTRF/rL
	jg8HTzR0mzQph8hm+fmZRPMo8w5p/6+8QT87JH2V5l2VRh1WljjgWYZKbTUM0MsH
	UQ+2Xh7m3zEaxcbjyGPKrMNXF//taziNtlm1F+KY1a9vtFGQTA7DCX2y5Mwkmk+L
	JTg6dy79GyUPDfQrJOivVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754386181; x=
	1754472581; bh=dAKal5weIHM3HgsAzvyNpVMMpmVqe/TuB2uUgYihS1M=; b=Q
	p16iOQiSkI6whyWxvGtoNI0EQqqO0QpRs48tT6Plcz2QStaoBG2hLNf+u2rXwd08
	Vyvi89Ft1uuBKyZ0FgLQXp5U80u4Rhz5Yb2CfNylZy8SyE9eIvpasXX64YWuuzmJ
	b98CzV3R864UE03C5g32st+syqLZoy3qpBKMOHQTamissprIh2/cdluT6I7yjg3k
	aHbzUa18lyocvTziivXdPSjvtNkYOfimPcEctqYyE8YrnNzy6wXSi83XXIEhEXQV
	gQgQ2dktM4SDV9/E3diQF6XOYE/IfrD5GbEBowhxrdWoOAViKGz4yd4RDYuSoZ5y
	JAZvr6xRhp9NVsoyF9T0w==
X-ME-Sender: <xms:BM-RaNyCDgxiFC18A9ZKg1LIipXChoi4AChvUAWzIq9jpTgtzaUfmg>
    <xme:BM-RaNR7hd7AFhVX_dGXDrLcFH3_gG1wGFx1gKQksabdQbKfHAx-hzGK0JFgkSoKN
    jYvWST5i2e9icqL-p8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudegkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhope
    grnhgurhgvrghssehgrghishhlvghrrdgtohhmpdhrtghpthhtohepuggrvhhiugdrlhgr
    ihhghhhtrdhlihhnuhigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhlrghusghith
    iisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpthhtohepthhhuhhthhes
    rhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhprghrtghlihhnuhigsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BM-RaEUBrHGPK3QR0OjosS_85VsUg_b8HwJJoG3bS7pSjSjxx3HorA>
    <xmx:BM-RaFhGiYTVVcT6wnluuFWoV8o-ymJedzwj4uhSxzYsOqQF4JAaqg>
    <xmx:BM-RaEAhr2HpOgKSm8DBRBVpx-9ruDYIbSBwK3wmpoP9gvHd0OrezA>
    <xmx:BM-RaLs2rz6GTHqEEa0dNz86WEhU85Sx_r5okBOf-xJfrB1q0fRAaw>
    <xmx:Bc-RaOAOocCM0MIM7DD4fNL3Fa0L3AT6mVZDteQD84rAVVZcP-dFt9XJ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 41AA1700065; Tue,  5 Aug 2025 05:29:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tc7b70f1228ed2fe7
Date: Tue, 05 Aug 2025 11:29:10 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Huth" <thuth@redhat.com>, "Andreas Larsson" <andreas@gaisler.com>,
 "David S . Miller" <davem@davemloft.net>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David Laight" <david.laight.linux@gmail.com>
Message-Id: <5f29e6cc-fa37-454a-937b-e2bc47453057@app.fastmail.com>
In-Reply-To: <20250805092540.48334-1-thuth@redhat.com>
References: <20250805092540.48334-1-thuth@redhat.com>
Subject: Re: [PATCH] sparc: Drop the "-ansi" from the asflags
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Aug 5, 2025, at 11:25, Thomas Huth wrote:
>
> Since there does not seem to be any compelling reason anymore to use
> "-ansi" nowadays, let's simply drop the "-ansi" flag from the sparc
> subsystem now to get rid of those disadvantages.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
