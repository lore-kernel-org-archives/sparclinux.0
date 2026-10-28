Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204890;
	b=d2/flO/U+UgNEwVvHHLUiT+bwjRzVdUI75e8P7kVgXmulSwHSy8kswXPzzN7cvDpmfwk
	 nANiPRHpz+uacc6qEaxTs3OGcZacvyp1qmT0XgdD5C3wxcKivRoP0F4VZEZtGl9hbCtPE
	 yaxlb/+kC8bDvOk48LJ/AeGIwLlqm08W4NIGnbgncgWSLrdduKFz7D8FywDeeuHnNtG2B
	 mk+pG+3CvxNqOFQUBy1Za7cS5/AkMi7V3zlmoxYDO66xqMLLTbfcNCnq071xiiip0mhkK
	 Ad8YlhdG2HdRyFr/yXme9Jfr2xWoPa86EsBRf26sgHO2fz8RaT2Sgi2SoVLruOAmpuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204890;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=weHQEUvevC22o/1CcsT9r9vuOkoHoFTUXMU102WBpQM=;
	b=dqelBcWgltvhI2PVncMLbltwi5pLUwiZwgmMsoBX0r4tqiTRwkor+dawAwvnpzhMlnpM
	 Gt+CDV2amLrZZDROC7lekh1CWytM6W3cIUtaBBTd4UB4/bauZga0EH1YvzLDsYb3CqdvX
	 ArrmTS3O3cjf8LeAG/z3iiirNVSeD/YkqMh/T1ZQsKHVR1G0WwBuFRKPAC1wwBWM2HbAj
	 R+gbNC0vHFRzuL/nl1Icx+Q2aHzRBfc3/KGqQPdHDNvFPZG1xAA6wp3UbQoB9uKaFQt6m
	 +yaLSJ0WasHroVTZBMpTAg3vjKpuS/s5Q4KJ0utO+35/Lw1s45f6Jlmu0aEiUT3pKrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZrLKNCL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0050D606A31C;
	Wed, 28 Oct 2026 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZrLKNCL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7151F01828;
	Wed, 28 Oct 2026 16:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793204889;
	bh=weHQEUvevC22o/1CcsT9r9vuOkoHoFTUXMU102WBpQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BZrLKNCL2RHaB1EVZDYOENe9cSd457C8UQPSaiWlb23MIV1EKRIgdEYyO+8CrwcWl
	 F2lL6lX73wzROZrJGCEX3cQIl61OxvFz+tcRb4ElS/iBIDLqk9vhu0H/y9TBdKYmLM
	 ohPuDlJuvc8ZWUnLuMBVjTd/WKZ7PD1giiXITQ0K/BVjAyKPxgCsi5MaDRmC5pWYiL
	 wlQRDVix/m2pWJ8e5o/p8HiSgYs5V9gl7G6kksjb4NX3p+ol5aFxZQVxHx+/b42hBJ
	 Rt2R6XA8HyeB4MTWROpTQZMIQdql927mNuCiM0BE58WAVQaR4/8h9Wwpq16JOXTCt4
	 8PuY9+nAdipFQ==
From: Imre Kaloz <kaloz@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: Re: [PATCH v3 4/4] mm: pass the number of PTEs to move_pte()
Date: Wed, 28 Oct 2026 17:26:50 +0100
Message-ID: <20261028162654.15694-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cc5c7066-b5cd-45df-b338-37944320da2f@kernel.org>
References: <cover.1792609488.git.kaloz@kernel.org> <2bc50d2a6829b49ee909e5bb943244859661a40b.1792609488.git.kaloz@kernel.org> <409079fe-ab52-4389-9fe0-d7246eb27bad@kernel.org> <20261027212610.6798-1-kaloz@kernel.org> <dfe06aef-540a-4450-88ba-300a460007b7@kernel.org> <20261028091631.8072-1-kaloz@kernel.org> <25f5cbed-9126-4870-a81e-65099155bc9d@kernel.org> <20261028101719.11918-1-kaloz@kernel.org> <4fba060e-c4f4-4d73-8efe-dbed0b5a7bc3@gaisler.com> <cc5c7066-b5cd-45df-b338-37944320da2f@kernel.org>
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

Hi Andreas, David,

On 10/28/26 14:59, David Hildenbrand (Arm) wrote:
> On 10/28/26 14:57, Andreas Larsson wrote:
>> I'm open to a solution like that, but it'll have to wait for the next
>> round as we are far too far into the merge window. Patch 3 stands on its
>> own legs as a bugfix in the current context. So send it as a separate
>> patch.
>
> Fully agreed.

Makes sense, no rush. I'll drop 4/4 and send the move_pte() removal as
a standalone patch once -rc1 is out.


Best,
Imre
