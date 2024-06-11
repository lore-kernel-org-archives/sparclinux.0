Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [46.30.211.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1441C6D
	for <sparclinux@vger.kernel.org>; Tue, 11 Jun 2024 17:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718127532; cv=none; b=DT66WuKiIgxZDbnAuVKwljQIOInwado+S4bXvvi+B8J7NqN051sYRvEaWnVymmyvoahg+haDyOX9PU+dfmy3e2NMfhOUwXc99rUxI2KxUlK4rF0huqqg/XdwPnmdBN5rFnXM0qnSt5RN3s66H4cJqMOxJMlvyHidJR1BFTXFGZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718127532; c=relaxed/simple;
	bh=gaNq3fC+MZp3PDlomdoMLzwN5PZ9Cxb12EgPGkMtvJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qh3UMAkqp7xMlCh21LrrzU7cxeF0/xn54otkGDXRD9mi18NQkNqspIQy4IbegEIWPuA7WVBYxMHZhZsFxW53OTcBlcrYsSDZF1dchUuytQ6jNKpYJ4SIlcJdzy+In+mbhYSQWqQMf5ANmiY2H3J2cqSG5I7oDo7pZdbmzeE+dKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=SJa8nts3; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=dPBuPwhg; arc=none smtp.client-ip=46.30.211.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="SJa8nts3";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="dPBuPwhg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=9ZfjXa/hnECETyrDldud1i66Ab4iFu37h9HZkZGnH9Q=;
	b=SJa8nts3q+P7A+Gl9yYp8R+W0wOOSBAGF2s2GKGFzeIm8dmgaEyzL+yvfwxzoCkmVgIIHjSdla+Hg
	 AnYaPrGOb5euKlHLNdhaPoQtCur+JfqnAIsQ5AcYeLJbZ9DlgmmQgPDm6Sgkfx+zy3HXe463IjF33+
	 sTdSjrwK9xwCMkJwgUK/AMea5ZxoWLQJGtXPraQ1KB409J/Ac8NMk2Wl6JhvNqojPt4wuUu4KCcBBq
	 iSH9afVR99ZyXVsyZ1F3EVHK3EE7lpD5+ARERXVe+35gudYd+nzuCyla5NXKQSsjAIV7a6JsBD/cNp
	 kkjkrxKeH3QfJL54KH8RvcpdwPZ+4uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=9ZfjXa/hnECETyrDldud1i66Ab4iFu37h9HZkZGnH9Q=;
	b=dPBuPwhgV8p4BmgDsKLok0un18HEonux1vMbYsGnb2KIDlJYWoUPQx81LscEj5pSQmGXK8LHK6cin
	 4hgJgo7DA==
X-HalOne-ID: 4bb23e55-2819-11ef-aeab-8b4f1ef432ad
Received: from ravnborg.org (2-105-16-150-cable.dk.customer.tdc.net [2.105.16.150])
	by mailrelay1.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 4bb23e55-2819-11ef-aeab-8b4f1ef432ad;
	Tue, 11 Jun 2024 17:37:40 +0000 (UTC)
Date: Tue, 11 Jun 2024 19:37:39 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.10-rc3
Message-ID: <20240611173739.GB545417@ravnborg.org>
References: <CAHk-=wiK75SY+r3W5hx+Tt_bjhcSKPLdji-Zf_8HjikRPbn9wg@mail.gmail.com>
 <20240610071049.933142-1-geert@linux-m68k.org>
 <46c5a25-ea8c-4a1-5241-df88a9848a9@linux-m68k.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46c5a25-ea8c-4a1-5241-df88a9848a9@linux-m68k.org>

Hi Andreas,

On Mon, Jun 10, 2024 at 09:28:25AM +0200, Geert Uytterhoeven wrote:
> On Mon, 10 Jun 2024, Geert Uytterhoeven wrote:
> > JFYI, when comparing v6.10-rc3[1] to v6.10-rc2[3], the summaries are:
> >  - build errors: +6/-1
> 
>   + error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x4), (.fixup+0xc)
>   + error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x34), (.fixup+0x10), (.fixup+0x0), (.fixup+0x28), (.fixup+0x4), (.fixup+0x18), (.fixup+0x20), (.fixup+0x1c), (.fixup+0x8)
>   + error: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5040), (.head.text+0x5100)
>   + error: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)

Did you have something in a local branch that would address this?
I have no idea how to fix it.
> 
> sparc64-gcc5/sparc-allmodconfig
> sparc64-gcc13/sparc-allmodconfig
> 
>   + {standard input}: Error: pcrel too far: 1095, 1074, 1022, 1020, 1021, 1096, 1126 => 1074, 1021, 1255, 1096, 1095, 1020, 1022, 1126, 1254
>   + {standard input}: Error: unknown pseudo-op: `.al':  => 1270
Hmm, strange..

	Sam
