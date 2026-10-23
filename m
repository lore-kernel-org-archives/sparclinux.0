Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792775878;
	b=FRndZAd2vlOdcz+m+aOmV6mQ01sz1cxzDqrjuB7gRKOSiv9lvcvCVc0LKgmjOZW3QggE
	 CdAmmkzwWCA7wGHpozHOqNRpSzum+/8qosj7nuYTBR1a1uEd0JWbNVV47f5HLGLmXnVgA
	 M4Pdo0TzqaupqC5Z9KNyzZx2Bc779ltbt75TefYk0JOwL3PZmmb9J+kN0e2/U4ACTAJ3o
	 HSWlL3XEBZsa757zB80cSQ5tp0N6P2BgXhgMVtaZgMcIQM65SGUnxS3pkRwTu9WDJJo/T
	 rWyHmOj6UWx9Ds28JEH8TVNWpe7NtsVpLkeicR2DWfXDfg6lSlnEpqYQ5UQJ+cgRlVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775878;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=XukA89Q9BDkd0XtBh2gSl1FnwMloWguuCBheAa68ykw=;
	b=3l6zSzdiTegeE2RzyOKJ4MiAgU4FoG1u5o4KyN+4rquwYjaa+hLN8by11sYxr9tU9qBo
	 2FHlmG0uafPQTzfCaZTQ1IyWd7z/WzgI4IWsfYf8KvnXIlMJhavP+P+uEXVWTWGSKo0hf
	 6rQgsBNib2qPFfeCdms+s/EIQeLDxzMXLEVdO2OHJDFFjc/8Q7yzRujhYO/hzBEJYeAzE
	 xBot9J2siParxutz8Z2nq803z7D4r0escSMnkYUW2Q1ZcYe0+7EqDTQWwqQoV8tZjJaAa
	 LOlYUApE46wNmhN/65rm7pI/OJ+IOZEx+HwZURbHKRO6NIzANBrDnYDp8XQp9qr9Ang==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vCdHe2g2;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+jvISlXK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vCdHe2g2;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+jvISlXK;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B16160A261D;
	Fri, 23 Oct 2026 17:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B16160A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vCdHe2g2;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+jvISlXK;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vCdHe2g2;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+jvISlXK
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 215DA1F76C;
	Fri, 23 Oct 2026 17:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792775870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XukA89Q9BDkd0XtBh2gSl1FnwMloWguuCBheAa68ykw=;
	b=vCdHe2g20uTYZTpiEzNLppFWchd8VyMkM1DHEGXwMrpeg4DbRGsEhQ630nUcaQIy7s3eya
	KEa6Fw7SfXIZLqNVqYWr7vP9+b6ka8t8DnDO+6q/utbkH2D5hI01sM2j8niDsxM30n2ruo
	pdMnkBXhZtmBiyTfIgUtuoIYWD1Dt8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792775870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XukA89Q9BDkd0XtBh2gSl1FnwMloWguuCBheAa68ykw=;
	b=+jvISlXK3WIo6Q5Pi1FehViuMkWMKuJFt8x02SWULTXNth4JhX10w56wAyJ4JA2cpH+FNf
	LHoSA4avmdjqvJDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vCdHe2g2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+jvISlXK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792775870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XukA89Q9BDkd0XtBh2gSl1FnwMloWguuCBheAa68ykw=;
	b=vCdHe2g20uTYZTpiEzNLppFWchd8VyMkM1DHEGXwMrpeg4DbRGsEhQ630nUcaQIy7s3eya
	KEa6Fw7SfXIZLqNVqYWr7vP9+b6ka8t8DnDO+6q/utbkH2D5hI01sM2j8niDsxM30n2ruo
	pdMnkBXhZtmBiyTfIgUtuoIYWD1Dt8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792775870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XukA89Q9BDkd0XtBh2gSl1FnwMloWguuCBheAa68ykw=;
	b=+jvISlXK3WIo6Q5Pi1FehViuMkWMKuJFt8x02SWULTXNth4JhX10w56wAyJ4JA2cpH+FNf
	LHoSA4avmdjqvJDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABEF8133F6;
	Fri, 23 Oct 2026 17:17:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XCS7FryW22opPAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 23 Oct 2026 17:17:48 +0000
Date: Fri, 23 Oct 2026 18:17:42 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Imre Kaloz <kaloz@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v3 4/4] mm: pass the number of PTEs to move_pte()
Message-ID: <atuU4Ig51wvNt2eD@pedro-suse.tail5790ac.ts.net>
References: <cover.1792609488.git.kaloz@kernel.org>
 <2bc50d2a6829b49ee909e5bb943244859661a40b.1792609488.git.kaloz@kernel.org>
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
In-Reply-To: <2bc50d2a6829b49ee909e5bb943244859661a40b.1792609488.git.kaloz@kernel.org>
X-Rspamd-Queue-Id: 215DA1F76C
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.51

On Thu, Oct 22, 2026 at 01:33:40AM +0200, Imre Kaloz wrote:
> Since commit f822a9a81a31 ("mm: optimize mremap() by PTE batching"),
> move_ptes() moves a batch of PTEs mapping consecutive pages of a folio
> at a time, but calls move_pte() once per batch with the first PTE
> only. sparc64, the only architecture that overrides move_pte(), flushes
> from the D-cache the page that PTE maps when the move changes its
> colour, so the other pages of a batch would keep lines of the old
> colour. This cannot happen today only because sparc64 has no
> pte_batch_hint(), and mremap_folio_pte_batch() then never batches.
> 
> Pass nr_ptes to move_pte(), as get_and_clear_ptes() takes it. The
> generic version ignores it, and sparc64 flushes every page of the
> batch.
> 
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
>  arch/sparc/include/asm/pgtable_64.h | 16 +++++++++-------
>  include/linux/pgtable.h             |  2 +-
>  mm/mremap.c                         |  2 +-
>  3 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 1430489b9ac5..9ca787b3cbfe 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -946,21 +946,23 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  	set_pte_at((mm), (addr), (ptep), __pte(0UL))
>  
>  #ifdef DCACHE_ALIASING_POSSIBLE
> -/* This flushes only the page the PTE maps, so it relies on move_ptes()
> - * calling it for one PTE at a time, which the default pte_batch_hint()
> - * guarantees.
> +/* The nr PTEs map consecutive pages of one folio and all move by the
> + * same offset, so either every page of the batch aliases or none does.
>   */
>  #define __HAVE_ARCH_MOVE_PTE
> -#define move_pte(pte, old_addr, new_addr)				\
> +#define move_pte(pte, old_addr, new_addr, nr)				\

The \ is now misaligned (at least according to my email client), perhaps you
can fix it up :)

The only nit I have is regarding the function's name.  move_pte with a nr is
no longer really move_pte, move_ptes() is the calling function's name... Yuck.

Also it seems a bit overengineered at this point, move_pte() returns a pte
that sparc never modifies.

>  ({									\
>  	pte_t newpte = (pte);						\
>  	if (tlb_type != hypervisor && pte_present(pte)) {		\
>  		unsigned long this_pfn = pte_pfn(pte);			\
> +		unsigned int i;						\
>  									\
>  		if (pfn_valid(this_pfn) &&				\
> -		    (((old_addr) ^ (new_addr)) & (1 << 13)))		\
> -			flush_dcache_page_all(current->mm,		\
> -					      pfn_to_page(this_pfn));	\
> +		    (((old_addr) ^ (new_addr)) & (1 << 13))) {		\
> +			for (i = 0; i < (nr); i++)			\
> +				flush_dcache_page_all(current->mm,	\
> +					pfn_to_page(this_pfn + i));	\

Is there no way to pass nr_ptes directly to flushing code?

Anyway,

Reviewed-by: Pedro Falcato <pfalcato@suse.de> 

-- 
Pedro
