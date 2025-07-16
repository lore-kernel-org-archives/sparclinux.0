Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E79E293B42
	for <sparclinux@vger.kernel.org>; Wed, 16 Jul 2025 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653788; cv=none; b=d20KjqM7ndNGsBmeMnQLrvfY9AhZ1o+XgX0nQEQtnMNv1UbZnc/ZQdv4quRTl9SJM7WbOAVyTpoHttzZVv4+je846mpU6jBknJ7zf2NRqyucsSp1BjnyVw1wf3XRUMqLAqvH88PeJQy2W0kdXcyuGIWBXskWzgrotPMs0CuqSZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653788; c=relaxed/simple;
	bh=C9qCjan2DrC5SZdq14Ww+urBXIR3AMmzAmQwUK+lhsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhLi+U6vPGoi/xRJ7QfCsxyX4Bz0SbxxBXFyCBUyuOQnz9BX+A5ThtQgJr/rBax7Ez4hY65NETLXw8AniqvWWSX9/2xRYfJSXhzmlzjzQcKzUTVboKTrAT0C0y2c3ZWIXwVH9QIiuQy0Uym8PZbu4TtfM6VOFTVEmVCH3vx3gUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=utfEywL7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9zXm1v7n; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=utfEywL7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9zXm1v7n; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="utfEywL7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9zXm1v7n";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="utfEywL7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9zXm1v7n"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F2CB1F38E;
	Wed, 16 Jul 2025 08:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752653783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLorJymyea+lD0Bkzjb3XBtsNd5E1+PeexO0r+gae5s=;
	b=utfEywL7KtxdGml46nHAdkZOXfQOUMplDCvbAglz1UhjwJWlK6nRvpkB6iYWPLPKbKLfkU
	T6gPYrB8XD0OUUJ54BM7w5fdw8TWDsk8uNbP6Jt/81988mivTO8utir43njOq8n2cqLgLH
	KUGfDMjybkNukSwafnY1cWgOttbGZJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752653783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLorJymyea+lD0Bkzjb3XBtsNd5E1+PeexO0r+gae5s=;
	b=9zXm1v7nYPqKXP4S3U3YsWzotz44Nxrdl/MyKlWn14tkoN1ku3OPe5DcqY1s/pWX3sz7A+
	Ekhqq/JFKcpo8ICg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752653783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLorJymyea+lD0Bkzjb3XBtsNd5E1+PeexO0r+gae5s=;
	b=utfEywL7KtxdGml46nHAdkZOXfQOUMplDCvbAglz1UhjwJWlK6nRvpkB6iYWPLPKbKLfkU
	T6gPYrB8XD0OUUJ54BM7w5fdw8TWDsk8uNbP6Jt/81988mivTO8utir43njOq8n2cqLgLH
	KUGfDMjybkNukSwafnY1cWgOttbGZJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752653783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLorJymyea+lD0Bkzjb3XBtsNd5E1+PeexO0r+gae5s=;
	b=9zXm1v7nYPqKXP4S3U3YsWzotz44Nxrdl/MyKlWn14tkoN1ku3OPe5DcqY1s/pWX3sz7A+
	Ekhqq/JFKcpo8ICg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB515138D2;
	Wed, 16 Jul 2025 08:16:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YfDeNtVfd2hQEAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 16 Jul 2025 08:16:21 +0000
Date: Wed, 16 Jul 2025 10:16:16 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: davem@davemloft.net, andreas@gaisler.com, arnd@arndb.de,
	muchun.song@linux.dev, akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	linux-mm@kvack.org, sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexghiti@rivosinc.com, agordeev@linux.ibm.com,
	anshuman.khandual@arm.com, christophe.leroy@csgroup.eu,
	ryan.roberts@arm.com, will@kernel.org
Subject: Re: [PATCH 0/3] drop hugetlb_free_pgd_range()
Message-ID: <aHdf0IUl_i0SI6h6@localhost.localdomain>
References: <20250716012611.10369-1-anthony.yznaga@oracle.com>
 <aHddYU8elWhddpoP@localhost.localdomain>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHddYU8elWhddpoP@localhost.localdomain>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,sude.de:email,imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Wed, Jul 16, 2025 at 10:05:53AM +0200, Oscar Salvador wrote:
> Acked-by: Oscar Salvador <osalvador@sude.de>

Fat fingers, sorry:

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs
