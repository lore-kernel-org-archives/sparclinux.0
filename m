Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799676;
	b=m6QPLYxcZNfz1LmhaRN0JS3Bcj3+fmWbLZJ/LkJxjInd0yIoiI3hbdZn9GJRx8QmYlmW
	 ecRrDP9aHB/2sC6pxsQiZXIJCLbPN0rIK0l0PEVNIVNqXzgi4/kYhHl4527nOAvxT04zb
	 GVY66eHHwPyBeNTLOQrh+q3c7e0Yzqh+JpYM6HvvSWgBjQ1EbNMmydGSlYjOQ/SO2GoMU
	 bh8TeO4JPctnY5izgu+DpXOia9lAyRsAxiIy9s0OFP3PMPTd3P4r/LCWG/gMvbh/5Hcih
	 GrzSqI2r+9xQwme3Zp64gTFcZ1ssARyUVin1szlQnsna45lTqgQ0W4/GxLGNfeqM+DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799676;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=d0fx3jue6yBdKZwD4p5LcxlMdLny64B3v9Q+ZGMsubA=;
	b=bbBEjnp76vmr/BgrrNGShlN2OYRGXbere99SDhW8lKP3L4woGI9oAnowlKoXIKZ1CWb2
	 g6N7/gTvsoDIq+e4X73YUUmTMcDSz1J/KT0nVz0hIzvLYQykZPtwJI7uDgwdCDPaJRuur
	 0mKDwiOVcWJktZ32BoosHvYMeH0aLIAYZ+BcZtORQ0X4XRPF7b3wMooZxH/BMvXOF6Aol
	 0UKKHmN13HAsYASK4lc4i0DoW/BAYJGnlOMatw20DG3InbBvmUmseM7mOPom9DMc1TfTl
	 hELFdumwq9Qwihk8gCxIx3BAViHZA1DWG4sGwmCXpDo0uEVXXMJMKomuJjCGY/jsQTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=M1Dvvfjm;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hJ+fAk3O;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=M1Dvvfjm;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hJ+fAk3O;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501EB606A31B;
	Wed,  4 Nov 2026 13:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 501EB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=M1Dvvfjm;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hJ+fAk3O;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=M1Dvvfjm;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hJ+fAk3O
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 64F091F795;
	Wed,  4 Nov 2026 13:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793799673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d0fx3jue6yBdKZwD4p5LcxlMdLny64B3v9Q+ZGMsubA=;
	b=M1DvvfjmuOl6MeDPykrHeEITAQNrJbxTmMnti13XKWSzJysAKC/6g0Bz71SUbYPC6zrqLW
	1gf2frwtAvxm99smHRiskyxL1chC7OclWFaFZlgBIjvlA+zKkcJNICW3LFBKO4ClGtLnlY
	R7zaPHsJtd1MCowUCA/we7gL+8XKkJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793799673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d0fx3jue6yBdKZwD4p5LcxlMdLny64B3v9Q+ZGMsubA=;
	b=hJ+fAk3O0waErwrATsWzqvdGxQn4P02zc0ezttMXg1V/DtCfNTP7PLYZmBWnN6UAiVKk6s
	WWLHsT0wIb554nCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=M1Dvvfjm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hJ+fAk3O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793799673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d0fx3jue6yBdKZwD4p5LcxlMdLny64B3v9Q+ZGMsubA=;
	b=M1DvvfjmuOl6MeDPykrHeEITAQNrJbxTmMnti13XKWSzJysAKC/6g0Bz71SUbYPC6zrqLW
	1gf2frwtAvxm99smHRiskyxL1chC7OclWFaFZlgBIjvlA+zKkcJNICW3LFBKO4ClGtLnlY
	R7zaPHsJtd1MCowUCA/we7gL+8XKkJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793799673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d0fx3jue6yBdKZwD4p5LcxlMdLny64B3v9Q+ZGMsubA=;
	b=hJ+fAk3O0waErwrATsWzqvdGxQn4P02zc0ezttMXg1V/DtCfNTP7PLYZmBWnN6UAiVKk6s
	WWLHsT0wIb554nCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29E34134A5;
	Wed,  4 Nov 2026 13:41:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +ybCOPc162reOwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 04 Nov 2026 13:41:12 +0000
Date: Wed, 4 Nov 2026 13:41:10 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Imre Kaloz <kaloz@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] sparc64: replace move_pte() with a D-cache flush in
 flush_cache_range()
Message-ID: <aus13nY84jxvzOHF@pedro-suse.tail5790ac.ts.net>
References: <20261104105300.16260-1-kaloz@kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104105300.16260-1-kaloz@kernel.org>
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[15];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 64F091F795

On Wed, Nov 04, 2026 at 11:52:58AM +0100, Imre Kaloz wrote:
> mremap() can move a page to an address of the other D-cache color,
> leaving lines of the old color in the virtually indexed D-cache of
> Spitfire and Cheetah CPUs.  move_pte() flushed the page for each PTE
> moved, which is only correct while move_ptes() handles one PTE at a
> time.
> 
> Drop move_pte(), which no other architecture defines, and flush the
> whole D-cache in flush_cache_range(), which mremap() calls on the old
> range before moving the PTEs.  This keeps the fix in sparc64 without
> a page table walk.
> 
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Link: https://lore.kernel.org/all/409079fe-ab52-4389-9fe0-d7246eb27bad@kernel.org/
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>

yay!

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro
