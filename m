Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3952D18C334;
	Tue,  3 Sep 2024 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381251; cv=none; b=WYMn8aFoj3Xqe3dN8fWDXo4U67KbSnLheuEOhRLZMOzQ98fV24G1UB976on9r0FoZGwfe0jHARdcdGFQPe6v/GIYA9riK9DuTbR9es+Fot1XbO4DhUN/KFyegPRe4X9beEh2YvMncPVAQ7MPfOpcadGHBQa5YLSfLKUqmvi6ixs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381251; c=relaxed/simple;
	bh=hnoOMPHIelaOOG6+6DV+DgPu+uv33EXGZHi0Ebg/Xbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZIxnKVGQyuMY6p4AP0YoSOKYLO67XlWyJ0cEQEou9kazYjT9QbXsc7Wm2CuhPZUy5vTv0ARVfOmFi6fNxjqa61Sl/Flzpjonhv6j1i3EJJf4aGFJQuvF5YU4lZy48B8TyPYBcfUWX1h6EwnWdijigmhVd3NOIxOUaqc7C2zOppY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=odfxCAf9; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="odfxCAf9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Iu88FFSUL1wGyVd5VlbCTjXI0fMdyq6cAE9Sm953SYc=; t=1725381247; x=1725986047; 
	b=odfxCAf9t9DqQ4Zb/XeF15thxUjaFgtq/G2pOXZoTsr4fHfC1fABOEauYsiwUDh7b0g5MHgPBi3
	AVXZKp6e5ngFwC3VE1BLJ4Wg0bLbpDd3cXAM+dtfYSXU6ulFqN74oQyzYGNnby3lYzveNaqwTwcqF
	x832YE+9dxZ0+GCyS8vcbYS9hyY1tg6sxHRnoWrtXoG87sQ7zumfqbjnNZM2pxZyw4stFNnM73h+/
	hbrrrVHNSK2NsJxXyk0uiqKtr9UZmqgiWOhC99vWNNHg9wJWwEJB2C2toye0ceoy9ZcpvZ4EegAPf
	6y/CWYJ3pMqafd+XgdkGf9pNxtwa6bDOZVxA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1slWTb-00000003v4f-3lLf; Tue, 03 Sep 2024 18:33:55 +0200
Received: from p5b13a591.dip0.t-ipconnect.de ([91.19.165.145] helo=z6.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1slWTb-00000000Z4H-2cwv; Tue, 03 Sep 2024 18:33:55 +0200
Received: from glaubitz by z6.fritz.box with local (Exim 4.96)
	(envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1slWTb-0000pX-0e;
	Tue, 03 Sep 2024 18:33:55 +0200
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: feng.tang@intel.com
Cc: akpm@linux-foundation.org,
	bristot@redhat.com,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vbabka@suse.cz,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	sparclinux@vger.kernel.org
Subject: Re: sched/debug: Dump end of stack when detected corrupted
Date: Tue,  3 Sep 2024 18:33:55 +0200
Message-Id: <20240903163355.3187-1-glaubitz@physik.fu-berlin.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219032254.96685-1-feng.tang@intel.com>
References: <20231219032254.96685-1-feng.tang@intel.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Feng,

> When debugging a kernel hang during suspend/resume, there are random
> memory corruptions in different places like being detected by scheduler
> with error message:
> 
>   "Kernel panic - not syncing: corrupted stack end detected inside scheduler"
> 
> Dump the corrupted memory around the stack end will give more direct
> hints about how the memory is corrupted:
> 
>  "
>  Corrupted Stack: ff11000122770000: ff ff ff ff ff ff 14 91 82 3b 78 e8 08 00 45 00  .........;x...E.
>  Corrupted Stack: ff11000122770010: 00 1d 2a ff 40 00 40 11 98 c8 0a ef 30 2c 0a ef  ..*.@.@.....0,..
>  Corrupted Stack: ff11000122770020: 30 ff a2 00 22 3d 00 09 9a 95 2a 00 00 00 00 00  0..."=....*.....
>  ...
>  Kernel panic - not syncing: corrupted stack end detected inside scheduler
>  "
> 
> And with it, the culprit was quickly identified to be an ethernet
> driver with its DMA operations.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  kernel/sched/core.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a795e030678c..1280f7012bc5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5949,8 +5949,18 @@ static noinline void __schedule_bug(struct task_struct *prev)
>  static inline void schedule_debug(struct task_struct *prev, bool preempt)
>  {
>  #ifdef CONFIG_SCHED_STACK_END_CHECK
> -	if (task_stack_end_corrupted(prev))
> +	if (task_stack_end_corrupted(prev)) {
> +		unsigned long *ptr = end_of_stack(prev);
> +
> +		/* Dump 16 ulong words around the corruption point */
> +#ifdef CONFIG_STACK_GROWSUP
> +		ptr -= 15;
> +#endif
> +		print_hex_dump(KERN_ERR, "Corrupted Stack: ",
> +			DUMP_PREFIX_ADDRESS, 16, 1, ptr, 16 * sizeof(*ptr), 1);
> +
>  		panic("corrupted stack end detected inside scheduler\n");
> +	}
>  
>  	if (task_scs_end_corrupted(prev))
>  		panic("corrupted shadow stack detected inside scheduler\n");

Have you gotten any feedback on this? Would be nice to get this merged as we're
seeing crashes due to stack corruption on sparc from time to time and having the
end of the stack dumped in such cases would make debugging here a bit easier.

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
