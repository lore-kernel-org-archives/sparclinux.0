Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB8F1586CF;
	Fri,  6 Sep 2024 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725612368; cv=none; b=r8sSAjC9UA6X+jIlyfWCfEcxZ4dTLaXgNjxugM2EVLqMYuieuY7yzaig/wCicWjhVkpD/eoFXkYfOYuFFilKoS4jwNkU6I9j6C3EH45Xe9rY3svMBgE0g01LJewIs3beB9of4+5hz8qlDV28P55JTIsZhEtUhY6mh2lItogv0Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725612368; c=relaxed/simple;
	bh=5DX8NBW5IHQxtFGId/Ks5tZ+9Ae5JKt4Z6Ep9C0Tpfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KteEFcKGvUW7XQ6L1FjZuGaaDrPJIRgRYQ/rJ5CS7vbNIW3wnrMEMCx+JG70S+WNlNjIC6Vcs3B9zF/fX+sSK83RtGs1EvN5UjllzssMo2SnASiT6F4wdAwpzz6KD8LH8jmspvUBP0q485lmDY/kt1LbqngVmul3QCnNF3I6TqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=DAe3ZNbw; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="DAe3ZNbw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aPfq7cnDv8FQtcv09eTir2I8inQ/WuWxw15pdVzwa1I=; t=1725612364; x=1726217164; 
	b=DAe3ZNbwRhXBVTbSRxj9c9+ajEQJU/wVU+FYHktlufLfa2St8d4dlndpg/b34Ef3Wl7gSxbxnNt
	dd8xE3tpIObmbi/Ku51iqjNN/WNOyvE9h4JNRX+uQxZRQrtBNb/vQDrYn+efCtVvxpXaGoHe6TOku
	asz2/Vf/90qwmrLBK73AGOlKevprNSJbYd2I6j1WwdNVi2sD0hefsVA9IHSwfS9SIh0eYKV1P3Uyb
	ax/vk/aexrZmnRBwX0noNMlp4lgIhryPgz/d3REiwtG3V60kRh+Hn4GL13f5vLKnhVrMqFUDZTq7C
	dOUyfoH2IVuaIueylxG+wRUaqXsBxb/XbjLA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1smUbL-00000000H1W-27Uc; Fri, 06 Sep 2024 10:45:55 +0200
Received: from p5b13a591.dip0.t-ipconnect.de ([91.19.165.145] helo=z6.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1smUbL-00000002DRt-10if; Fri, 06 Sep 2024 10:45:55 +0200
Received: from glaubitz by z6.fritz.box with local (Exim 4.96)
	(envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1smUbK-0000rT-2W;
	Fri, 06 Sep 2024 10:45:54 +0200
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
	sparclinux@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: sched/debug: Dump end of stack when detected corrupted
Date: Fri,  6 Sep 2024 10:45:46 +0200
Message-Id: <20240906084546.3304-1-glaubitz@physik.fu-berlin.de>
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

I would recommend determining the buffer element size with sizeof(unsigned long) for
better readability and using "true" instead of "1" to set the value of the ascii
parameter to print_hex_dump(), see [1]. Otherwise looks good to me.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

PS: Please CC me for a potential v3.

Thanks,
Adrian

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/hexdump.c#n252

--
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
